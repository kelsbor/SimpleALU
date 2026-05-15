library ieee;
use ieee.std_logic_1164.all;
use work.ula_package.mul_2b;

entity tb_mul_2b is
end tb_mul_2b;

architecture simular of tb_mul_2b is
    signal a,b: std_logic_vector(1 downto 0);
    signal mul: std_logic_vector(3 downto 0);

    begin
        fa : mul_2b port map 
            (
                a => a, 
                b => b, 
                mul => mul
            );
        
        stm: process
        begin

            --- Simulação da Tabela verdade para o multiplicador
            -- 0 * 0 = 0
            a <= "00"; b <= "00";
            wait for 10 ns;
            
            -- 1 * 2 = 2
            a <= "01"; b <= "10";
            wait for 10 ns;

            -- 2 * 2 = 4
            a <= "10"; b <= "10";
            wait for 10 ns;

            -- 3 * 3 = 9
            a <= "11"; b <= "11";
            wait for 10 ns;

            wait;
        end process;
end simular;