library ieee;
use ieee.std_logic_1164.all;
use work.ula_package.somasub_4b;

entity tb_somasub_4b is
end tb_somasub_4b;

architecture simular of tb_somasub_4b is
    -- Sinais que receberão os estimulos
    signal A,B: std_logic_vector(3 downto 0);
    signal soma: std_logic_vector(3 downto 0);
    signal Cin, carry_out, overflow, zero: std_logic;
    
    begin

        -- Fazemos a instanciação do somador
        somasub4b : somasub_4b port map (
                A => A,
                B => B,
                Cin => Cin,
                soma => soma,
                carry_out => carry_out,
                overflow => overflow,
                zero => zero
            );

        sim : process
            begin
            -- Simulação de uma soma padrão 
            A <= "0010"; -- (+2)
            B <= "0011"; -- (+3)
            Cin <= '0';
            wait for 10 ns;
            
            -- Simulação do resultado Zero
            A <= "1101"; -- (-3)
            B <= "0011"; -- (3)
            Cin <= '0';
            wait for 10 ns;
            
            -- Simulação do overflow
            A <= "0111"; -- (+7)
            B <= "0001"; -- (+1)
            Cin <= '0';
            wait for 10 ns;
            
            -- Simulação Overflow Negativo
            A <= "1000"; -- (-8)
            B <= "1011"; -- (-5)
            Cin <= '0';
            wait for 10 ns;
            
            -- Simulação Subtração (5 - (+3))
            A <= "0101"; -- (5)
            B <= "0011"; -- (3)
            Cin <= '1';
            wait for 10 ns;
            wait;
        end process;

end simular;