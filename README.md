# 32-BIT-MICROPROCESSOR-DESIGN

A Verilog RTL project for a pipelined RISC-V core with module-level testbenches and a top-level simulation flow.

## Project Structure

- `Makefile`: build, lint, simulation, and PPA/sweep targets.
- `filelist/`: simulation/synthesis file lists used by the Makefile.
  - `rtl_syn.f`
  - `rtl_sim.f`
  - `tb.f`
- `RISCV_CORE/rtl/`: RTL source files.
- `RISCV_CORE/tb/`: testbench files and simulation data files (`memfile.hex`, `ASM.txt`).
- `RISCV_CORE/docs/`: documentation assets.

## Naming Convention (Applied)

The codebase has been normalized to lowercase naming:

- RTL module names: `lower_snake_case`
- Testbench module names: `tb_<module_name>`
- RTL/TB file names: lowercase with underscore separators

Note: Verilog identifiers cannot contain `-`, so module names use `_` instead of `-`.

## Top Module and Testbench

- Top RTL module: `riscv_top`
- Top testbench module: `tb_riscv_top`

## Quick Start

Run from project root:

```bash
make compile
make run
```

Optional:

```bash
make lint
make wave
```

## Makefile Notes

- `TOP` defaults to `riscv_top`.
- Include paths now target:
  - `RISCV_CORE/rtl`
  - `RISCV_CORE/tb`
- Filelists are read from `filelist/`.

## Main Targets

- `make compile`: compile RTL + TB with Icarus Verilog.
- `make run`: run simulation with `vvp`.
- `make lint`: lint check with Verilator.
- `make ppa`: run Vivado batch synthesis/timing/power reports.
- `make sweep`: sweep timing period and collect PPA summary.
- `make clean`: remove generated artifacts.
