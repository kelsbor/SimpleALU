library ieee;
use ieee.std_logic_1164.all;
use work.ula_package.full_adder;

entity mul_2b is
    port (
        a, b: in std_logic_vector(1 downto 0);
        mul :  out std_logic_vector(3 downto 0)
    );
end mul_2b;

architecture multiplication of mul_2b is
    -- Sinais que guardam o resultado da multiplicação entre os bits
    signal s0,s1,s2 : std_logic;
    -- Carry out da soma interna
    signal cout : std_logic;

    begin
    
    s0 <= a(1) AND b(0);
    s1 <= a(0) AND b(1);
    s2 <= a(1) AND b(1);

    mul(0) <= a(0) AND b(0);

    -- Bits do meio e do final são resultantes das somas entre as multiplicações
    soma1: full_adder port map (carry_in => '0', bit_a => s0, bit_b => s1, sum => mul(1), carry_out => cout);
    soma2: full_adder port map (carry_in => cout, bit_a => s2, bit_b => '0', sum => mul(2), carry_out => mul(3));
end multiplication;