library ieee;
use ieee.std_logic_1164.all;
use work.ula_package.all;

entity tb_carry is
end tb_carry;

architecture sim of tb_carry is

    -- Sinais de interface
    signal SW : std_logic_vector(10 downto 0);
    signal HEX0, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : std_logic_vector(6 downto 0);
    signal LEDR : std_logic_vector(5 downto 0);

begin

    -- Instanciação da ULA
    ULA_inst : entity work.ULA
        port map (
            SW => SW,
            HEX0 => HEX0, HEX2 => HEX2, HEX3 => HEX3,
            HEX4 => HEX4, HEX5 => HEX5,
            HEX6 => HEX6, HEX7 => HEX7,
            LEDR => LEDR
        );

    -- Estimulos do testbench
    stim_test : process
    begin
        -- Estrutura da entrada: A(4 bits) & B(4 bits) & Opcode(3 bits)

        -- Teste 1: Soma com carry out
        -- A = -1 (1111), B = 1 (0001). Opcode "100" (ADD)
        -- Res = 0 (0000), Carry Out = 1
        SW <= "1111" & "0001" & "100";
        wait for 20 ns;

        -- Teste 2: Soma sem carry out
        -- A = 7 (0111), B = 1 (0001). Opcode "100" (ADD)
        -- Res = -8 (1000), Carry Out = 0
        SW <= "0111" & "0001" & "100";
        wait for 20 ns;

        -- Teste 3: Subtração com carry out (sem borrow)
        -- A = 5 (0101), B = 3 (0011). Opcode "101" (SUB)
        -- Res = 2 (0010), Carry Out = 1
        SW <= "0101" & "0011" & "101";
        wait for 20 ns;

        -- Teste 4: Subtração sem carry out (com borrow)
        -- A = 3 (0011), B = 5 (0101). Opcode "101" (SUB)
        -- Res = -2 (1110), Carry Out = 0
        SW <= "0011" & "0101" & "101";
        wait for 20 ns;

        wait;
    end process;
end sim;
