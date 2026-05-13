library ieee;
use ieee.std_logic_1164.all;
use work.ula_package.full_adder;

entity tb_full_adder is
end tb_full_adder;

architecture simular of tb_full_adder is
    signal carry_in, bit_a, bit_b : std_logic;
    signal sum, carry_out         : std_logic;

    begin
        fa : full_adder port map 
        (
            carry_in => carry_in, 
            bit_a => bit_a, 
            bit_b => bit_b, 
            sum => sum, 
            carry_out => carry_out
        );
    
        stm : process
        begin
            --- Simulação da Tabela verdade para o somador completo
            bit_a <= '0'; bit_b <= '0'; carry_in <= '0';
            wait for 10 ns;
            
            bit_a <= '0'; bit_b <= '0'; carry_in <= '1';
            wait for 10 ns;
            
            bit_a <= '0'; bit_b <= '1'; carry_in <= '0';
            wait for 10 ns;

            bit_a <= '0'; bit_b <= '1'; carry_in <= '1';
            wait for 10 ns;

            bit_a <= '1'; bit_b <= '0'; carry_in <= '0';
            wait for 10 ns;

            bit_a <= '1'; bit_b <= '0'; carry_in <= '1';
            wait for 10 ns;

            bit_a <= '1'; bit_b <= '1'; carry_in <= '0';
            wait for 10 ns;

            bit_a <= '1'; bit_b <= '1'; carry_in <= '1';
            wait for 10 ns;           

            wait;
        end process;
end simular;