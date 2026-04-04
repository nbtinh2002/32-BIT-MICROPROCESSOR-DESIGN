# ============================================================================
# Advanced RTL Makefile with PPA Sweep & Progress Tracking
# ============================================================================

# --- Project Configuration ---
TOP                ?= riscv_top
TOP_TB             ?= tb_riscv_top_verify
FPGA_PART          ?= xc7z020clg400-1
PROJECT_ROOT       := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

# --- Directories & Files ---
SIM_DIR            := /dev/shm/wsl_sim_$(USER)/$(TOP)
BIN                := $(PROJECT_ROOT)/$(SIM_DIR)/simv.out
VCD                := $(PROJECT_ROOT)/$(TOP_TB).vcd
FL_SIM             := filelist/rtl_sim.f
FL_SYN             := filelist/rtl_syn.f
FL_TB              := filelist/tb.f

# --- Simulation Selection Variables ---
SIM_PLUSARGS       := $(strip $(if $(TC_LIST),+TC_LIST=$(TC_LIST)) $(if $(TC),+TC=$(TC)) $(if $(GR),+GR=$(GR)))

# --- Timing Sweep & Constraints Variables ---
CLOCK_NAME         ?= clk
INPUT_DELAY_RATIO  ?= 0.2
OUTPUT_DELAY_RATIO ?= 0.2
START_PERIOD       ?= 3.0
END_PERIOD         ?= 5.0
STEP               ?= 0.5
PERIOD             ?= 5.0
IS_COMBINATIONAL   ?= 0

# --- Automatic RTL File Extraction ---
RTL_SYN_FILES      = $(shell awk 'NF && !/^#|^\/\//' $(FL_SYN))

# --- Internal Calculation ---
# Use bc for floating point math in Linux
IN_DELAY           = $(shell echo "$(PERIOD) * $(INPUT_DELAY_RATIO)" | bc)
OUT_DELAY          = $(shell echo "$(PERIOD) * $(OUTPUT_DELAY_RATIO)" | bc)

.PHONY: all clean syntax lint compile run wave ppa sweep report

all: run

$(SIM_DIR):
	@mkdir -p $(PROJECT_ROOT)/$(SIM_DIR)

lint:
	@echo ">> [LINT] Fast verifying with Verilator..."
	@verilator --lint-only -Wall -Wno-fatal --top-module $(TOP) \
		-f $(FL_SYN) $(addprefix -I, $(sort $(dir $(shell grep -v '^//' $(FL_SYN))))) \
		-j $(shell nproc)

# --- 2. SIMULATION FLOW ---
compile: $(SIM_DIR)
	@echo ">> [COMPILE] Building TB & RTL..."
	@iverilog -g2012 -Wall \
		-I $(PROJECT_ROOT)/rtl -I $(PROJECT_ROOT)/tb \
		-o $(BIN) -s $(TOP_TB) -c $(FL_SYN) -c $(FL_TB)
run: compile
	@echo ">> [SIM] Executing..."
	@cd $(PROJECT_ROOT) && vvp -n $(BIN) $(SIM_PLUSARGS)

wave:
	@echo ">> [WAVE] Opening viewer..."
	gtkwave $(VCD) &

# --- 3. FULL PPA REPORT (VIVADO BATCH MODE) ---
ppa: $(SIM_DIR)
	@mkdir -p constraints
	@echo ">> [XDC] Generating Dynamic Timing and Loading User Constraints..."

	@echo "create_clock -period $(PERIOD) -name $(CLOCK_NAME) [get_ports $(CLOCK_NAME)]" > constraints/timing.xdc
	@echo "set_input_delay -clock $(CLOCK_NAME) $(IN_DELAY) [all_inputs]" >> constraints/timing.xdc
	@echo "set_output_delay -clock $(CLOCK_NAME) $(OUT_DELAY) [all_outputs]" >> constraints/timing.xdc

	@echo "cd {$(shell wslpath -m $(PWD))}" > $(SIM_DIR)/run_ppa.tcl
	@echo "read_verilog -sv $(RTL_SYN_FILES)" >> $(SIM_DIR)/run_ppa.tcl
	@echo "read_xdc constraints/timing.xdc" >> $(SIM_DIR)/run_ppa.tcl
	@if [ -f constraints/user.xdc ]; then echo "read_xdc constraints/user.xdc" >> $(SIM_DIR)/run_ppa.tcl; fi

	@echo "set default_part [lindex [get_parts] 0]" >> $(SIM_DIR)/run_ppa.tcl
	@echo "synth_design -top $(TOP) -part \$$default_part -mode out_of_context" >> $(SIM_DIR)/run_ppa.tcl
	@echo "report_utilization -file $(SIM_DIR)/report_area.rpt" >> $(SIM_DIR)/run_ppa.tcl
	@echo "report_timing_summary -file $(SIM_DIR)/report_timing.rpt" >> $(SIM_DIR)/run_ppa.tcl
	@echo "report_power -file $(SIM_DIR)/report_power.rpt" >> $(SIM_DIR)/run_ppa.tcl

	@cd /mnt/c && /mnt/c/Windows/System32/cmd.exe /c "C:\AMDDesignTools\2025.2\Vivado\bin\vivado.bat -mode batch -source $(shell wslpath -m $(PWD)/$(SIM_DIR)/run_ppa.tcl) -nolog -nojournal"
	@python3 scripts/summary_ppa.py $(PERIOD)

# Target sweep: Iteratively runs ppa to find the design's limits
sweep: $(SIM_DIR)
	@echo ">> [SWEEP] Starting Timing Sweep from $(START_PERIOD)ns to $(END_PERIOD)ns..."
	@echo "Period(ns) | WNS(ns) | Fmax(MHz) | Status" > $(SIM_DIR)/sweep_log.txt
	@echo "-----------|---------|-----------|--------" >> $(SIM_DIR)/sweep_log.txt
	@for p in $$(seq $(START_PERIOD) $(STEP) $(END_PERIOD)); do \
		echo -n ">> [SWEEP] Testing Period: $$p ns... "; \
		$(MAKE) ppa PERIOD=$$p --no-print-directory; \
		RES=$$(python3 scripts/summary_ppa.py $$p 2>&1); \
		echo "Debug: $$RES"; \
		echo "$$RES" >> $(SIM_DIR)/sweep_log.txt; \
		echo "Done."; \
	done
	@echo ""
	@echo ">> [SWEEP] Completed! Results Summary:"
	@cat $(SIM_DIR)/sweep_log.txt

# --- 4. CLEAN ---
clean:
	@echo ">> [CLEAN] Removing artifacts..."
	rm -rf $(PROJECT_ROOT)/$(SIM_DIR)
	rm -rf $(PROJECT_ROOT)/constraints/timing.xdc
	rm -rf $(PROJECT_ROOT)/dfx_runtime.txt
