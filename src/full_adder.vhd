library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    -- Definição da entidade do somador completo
    -- Soma 2 bits + carry_in (que pode ser usado também para o subtrator)
    port (
        carry_in : in STD_LOGIC;
        bit_a : in STD_LOGIC;
        bit_b : in STD_LOGIC;
        sum : out STD_LOGIC;
        carry_out : out STD_LOGIC
    );
end entity;

architecture somar of full_adder is
    -- Definição da soma a partir da tabela verdade do somador completo
    begin
        sum <= (bit_a XOR bit_b XOR carry_in);
        carry_out <= (bit_a AND bit_b) OR (bit_a AND carry_in) OR (bit_b and carry_in);
    
end architecture;