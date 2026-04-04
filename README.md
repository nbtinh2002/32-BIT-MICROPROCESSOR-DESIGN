# 32-BIT RISC-V MICROPROCESSOR

Verilog/SystemVerilog implementation of a 32-bit pipelined RISC-V microprocessor with a filelist-driven build flow, self-checking verification testbench, and synthesis reporting support.

This is a personal project by Nguyen Bao Tinh.

## Project Summary

| Item | Description |
|---|---|
| Project Name | 32-BIT RISC-V Microprocessor |
| Target | Education / Research |
| Project Type | Personal project |
| Owner | Nguyen Bao Tinh |
| Email | nbtinh2002@gmail.com |
| Design Style | Pipelined RTL microarchitecture |
| Verification | SystemVerilog directed verification bench |
| Main Tools | Vivado, Icarus Verilog, Verilator, GTKWave |

## Key Features

- 32-bit RISC-V top-level processor core.
- Modular RTL decomposition for fetch, decode, execute, memory, and writeback stages.
- Self-checking top-level verification using a directed program image.
- Makefile-based flow for compile, run, lint, and synthesis-oriented checks.

## Architecture Overview

The core is organized around a classic pipelined datapath with hazard handling, forwarding, memory access, and writeback paths.

```text
				+----------------------+
clk, rst -----> |    riscv_top         |
				|----------------------|
				| IF -> ID -> EX -> MEM|
				|         -> WB        |
				|  Hazard / Forwarding  |
				+----------+-----------+
						   |
					   ResultW
```

Block diagram placeholder: replace this sketch with the final pipeline diagram, control-path view, or timing diagram used in your project documentation.

## Directory Structure

```text
.
├── Makefile
├── README.md
├── REVIEW.md
├── docs/
├── filelist/
│   ├── rtl_sim.f
│   ├── rtl_syn.f
│   └── tb.f
├── rtl/
│   ├── riscv_top.v
│   ├── instruction_fetch_cc.v
│   ├── instruction_decode_cc.v
│   ├── execute_cc.v
│   ├── memory_access_cc.v
│   ├── writeback_cc.v
│   └── ...
├── tb/
│   ├── tb_riscv_top_verify.sv
│   ├── memfile.hex
│   └── ...
├── sim/
└── scripts/
```

Note: `sim/` and `scripts/` are standard hardware-project directories. If they are not yet populated in this repository, they can be added later for waveform, report, or automation assets.

## Interface Summary

The current top-level RTL module is [rtl/riscv_top.v](rtl/riscv_top.v), which exposes the following ports:

| Signal | Direction | Width | Description |
|---|---:|---:|---|
| `clk` | Input | 1 | System clock. |
| `rst` | Input | 1 | Active-high reset used by the top-level pipeline. |
| `ResultW` | Output | 32 | Final writeback value from the pipeline. |

## Verification Strategy

Verification is currently implemented with a directed SystemVerilog testbench:

- Top-level testbench: [tb/tb_riscv_top_verify.sv](tb/tb_riscv_top_verify.sv)
- Test program image: [tb/memfile.hex](tb/memfile.hex)
- Check style: final architectural-state validation with pass/fail reporting

The verification program exercises:

- register immediate writes,
- arithmetic operations,
- load and store behavior,
- writeback correctness,
- data memory state,
- program counter progression.

## Tools

| Tool | Purpose |
|---|---|
| Vivado | Synthesis, timing, and power reporting |
| Icarus Verilog | RTL compilation and simulation |
| Verilator | Linting |
| GTKWave | Waveform viewing |
| WSL / Unix shell | Recommended environment for the provided Makefile flow |

## Requirements

- A SystemVerilog-capable simulator for the verification testbench.
- A Verilog toolchain installed and available in `PATH`.
- On Windows, WSL is recommended for the existing Makefile and file paths.

## How To Run

From the project root:

```bash
make compile
make run
```

Useful supporting targets:

```bash
make lint
make wave
make clean
```

### Makefile Targets

| Target | Description |
|---|---|
| `make compile` | Compile the RTL and top-level testbench with Icarus Verilog. |
| `make run` | Execute the compiled simulation. |
| `make lint` | Run a Verilator lint pass. |
| `make wave` | Open waveform output in GTKWave. |
| `make ppa` | Run Vivado batch synthesis and generate utilization/timing/power reports. |
| `make sweep` | Sweep timing values and collect PPA results. |
| `make clean` | Remove generated artifacts. |

## Resource Utilization

Replace this placeholder with synthesis results from Vivado after running `make ppa`.

| Resource | Used | Available | Utilization |
|---|---:|---:|---:|
| LUT | TBD | TBD | TBD |
| FF | TBD | TBD | TBD |
| BRAM | TBD | TBD | TBD |
| DSP | TBD | TBD | TBD |
| Fmax | TBD | TBD | TBD |

## Build Flow Notes

- RTL and testbench file selection is controlled through `filelist/`.
- The active verification bench is `tb_riscv_top_verify`.
- `rtl/instruction_memory.v` loads `tb/memfile.hex` using a relative path so the simulation stays portable.

## Output Artifacts

Typical generated artifacts include:

- simulation binaries,
- `.vcd` waveform files,
- Vivado timing and power reports,
- temporary synthesis constraints.

These files are generated from the build and should not be checked in unless explicitly required.

## License

No license has been declared yet. Add one before public release.

## Contact

Nguyen Bao Tinh

Email: nbtinh2002@gmail.com

Personal project maintained by Nguyen Bao Tinh.
