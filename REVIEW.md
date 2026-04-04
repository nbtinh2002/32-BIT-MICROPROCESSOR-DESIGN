# Project Review

## Advantages

1. Modular RTL decomposition: decode/execute/memory/writeback and utility blocks are separated, improving readability and reuse.
2. Build automation exists: one `Makefile` centralizes lint, compile, simulation, and PPA flows.
3. Multi-level verification assets: there is both top-level and per-module testbench coverage.
4. PPA-oriented flow included: the timing sweep and report generation support design-space exploration.
5. Naming and organization were normalized: lowercase module naming and consistent `tb_<module_name>` testbench pattern reduce ambiguity.

## Disadvantages

1. Testbench quality appears uneven: several TB files still use older coding style and may need cleanup for strict linting.
2. Toolchain assumptions are platform-specific: some PPA commands rely on WSL + fixed Vivado path, which can reduce portability.
3. Dependency order and ownership documentation are light: easier onboarding would benefit from block diagrams and interface contracts.
4. CI is not configured in the repo root: regressions are harder to catch automatically without scripted checks.
5. Some legacy comments/headers remain from previous names and paths, which can confuse new contributors.

## Recommended Next Improvements

1. Add a CI pipeline for `lint` + `compile` + selected smoke simulations.
2. Add a short architecture document in `RISCV_CORE/docs/` with stage interfaces and hazard handling summary.
3. Standardize all TB templates (reset/clock generation, self-checking asserts, pass/fail summary).
4. Add code format/lint style rules for Verilog and enforce them in CI.
