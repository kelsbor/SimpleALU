
# SimpleALU

This is a simple 4-bit Arithmetic Logic Unit (ALU) implemented in VHDL. It is an academic project designed for learning purposes. The ALU can perform arithmetic and logical operations, and comparisons.

## Project Structure

The project is organized into the following directories:

- `src`: Contains the VHDL source files for the ALU and its components.
- `sim`: Contains the VHDL testbenches for simulating the ALU and its components.
- `waves`: Contains the waveform files generated after simulation.
- `docs`: Contains additional documentation.

## Components

The ALU is composed of the following components:

- **`ULA.vhd`**: The top-level entity that integrates all the other components into a functional ALU.
- **`somasub_4b.vhd`**: A 4-bit adder/subtractor.
- **`mul_2b.vhd`**: A 2-bit multiplier.
- **`comparador.vhd`**: A 4-bit comparator.
- **`full_adder.vhd`**: A 1-bit full adder, used by the adder/subtractor and multiplier.
- **`display_logic.vhd`**: Logic for displaying numbers on a 7-segment display.
- **`ula_package.vhd`**: A package that declares all the components used in the project.

## Operations

The ALU supports the following operations, selected by a 3-bit opcode:

| Opcode | Operation | Description |
|---|---|---|
| 000 | NOP | No operation |
| 001 | AND | Logical AND |
| 010 | NOT | Logical NOT (of input B) |
| 011 | OR | Logical OR |
| 100 | ADD | Addition |
| 101 | SUB | Subtraction |
| 110 | MUL | 2-bit Multiplication |
| 111 | CMP | Comparison |

## Simulation

To simulate the project, you can use a VHDL simulator like GHDL. Each component has a corresponding testbench in the `sim` directory.

For example, to simulate the top-level ULA, you can compile and run the `tb_ULA.vhd` testbench.

**Compilation and Simulation with GHDL:**

```bash
# Analyze all the VHDL files in the correct order
ghdl -a src/ula_package.vhd
ghdl -a src/full_adder.vhd
ghdl -a src/somasub_4b.vhd
ghdl -a src/mul_2b.vhd
ghdl -a src/comparador.vhd
ghdl -a src/display_logic.vhd
ghdl -a src/ULA.vhd
ghdl -a sim/tb_ULA.vhd

# Elaborate the testbench
ghdl -e tb_ULA

# Run the simulation and generate a waveform file
ghdl -r tb_ULA --wave=waves/ULA.ghw
```

You can then view the waveform using a waveform viewer like GTKWave.
