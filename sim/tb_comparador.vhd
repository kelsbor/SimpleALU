library ieee;
use ieee.std_logic_1164.all;
use work.ula_package.comparador;
entity tb_comparador is
end tb_comparador;

architecture simular of tb_comparador is
    signal A,B : STD_LOGIC_VECTOR(3 downto 0);
    signal least, greater, equal : STD_LOGIC;
    
    begin
        -- instanciação do comparador
        comp : comparador port map
        (
            a => A,
            b => B,
            grt => greater,
            equ => equal,
            lst => least
        );
    
    stm_comparador : process
    begin 
        
        -- Comparação entre 1 e 1 (Igual)
        A <= "0001"; B <= "0001";
        wait for 10 ns;

        -- Comparação entre 2 e 1 (Maior)
        A <= "0010"; B <= "0001";
        wait for 10 ns;

        -- Comparação entre 1 e 2 (Menor)
        A <= "0001"; B <= "0010";
        wait for 10 ns;
        
        wait;
    end process;
end simular;