library ieee;
use ieee.std_logic_1164.all;
use work.ula_package.somasub_4b;

entity display_logic is
    port (
        number : in std_logic_vector(3 downto 0);
        is_signed : in std_logic;
        display_hex : out std_logic_vector(6 downto 0);
        sinal_hex : out std_logic_vector(6 downto 0)
    );
end display_logic;

architecture behavior of display_logic is
    signal negative : std_logic;
    signal magnitude_neg : std_logic_vector(3 downto 0);
    signal magnitude : std_logic_vector(3 downto 0);

    begin
        -- Verifica se se trata de um numero negativo caso seja sinalizado
        negative <= number(3) and is_signed;

        -- Utiliza um subtrator para obter a magnitude do numero sinalizado
        inversor : somasub_4b port map ('1', "0000", number, magnitude_neg);
        
        -- Se o numero for sinalizado e negativo, utiliza magnitude do subtrator
        -- Caso contrário, se não for sinalizado, utiliza o numero original
        magnitude <= magnitude_neg when (negative = '1') else number;

        -- Mapeia o display de acordo com a magnitude
        -- Quando temos 0 os segmentos estão acesos. 
        -- O formato utilizado pelo display é abcdefg (mas invertido por conta do vetor).
        with magnitude select
            display_hex <= 
                "1000000" when "0000", -- 0
                "1111001" when "0001", -- 1
                "0100100" when "0010", -- 2
                "0110000" when "0011", -- 3
                "0011001" when "0100", -- 4
                "0010010" when "0101", -- 5
                "0000010" when "0110", -- 6
                "1111000" when "0111", -- 7
                "0000000" when "1000", -- 8
                "0010000" when "1001", -- 9
                "0001000" when "1010", -- A
                "0000011" when "1011", -- b
                "1000110" when "1100", -- C
                "0100001" when "1101", -- d
                "0000110" when "1110", -- E
                "0001110" when others; -- F

        -- Se o número for negativo, mostra o sinal de negativo no display selecionado
        sinal_hex <= "0111111" when (negative = '1') else "1111111";
end behavior; 