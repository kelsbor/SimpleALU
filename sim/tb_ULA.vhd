library ieee;
use ieee.std_logic_1164.all;
use work.ula_package.all;

entity tb_ULA is
end tb_ULA;

architecture sim of tb_ULA is
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

        -- Teste 1: Soma (Opcode "100")
        -- A = 0101 (+5), B = 1101 (-3). Res = 0010 (+2)
        SW <= "0101" & "1101" & "100";
        wait for 20 ns;

        -- Teste 2: Subtração gerando negativo (Opcode "101")
        -- A = 1100 (-4), B = 0010 (+2). Res = 1010 (-6)
        SW <= "1100" & "0010" & "101";
        wait for 20 ns;

        -- Teste 3: Multiplicação Não-Sinalizada (Opcode "110")
        -- A = xx11 (3), B = xx10 (2). Res = 0110 (6)
        -- (Os bits superiores devem ser ignorados pelo filtro adotado)
        SW <= "1111" & "1010" & "110";
        wait for 20 ns;

        -- Teste 4: Comparação (Opcode "111")
        -- A = 0111 (7), B = 1111 (15). (7 < 15, LED lst deve acender)
        SW <= "0111" & "1111" & "111";
        wait for 20 ns;

        wait;
    end process;
end sim;