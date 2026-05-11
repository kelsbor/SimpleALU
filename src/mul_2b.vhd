library ieee;
use ieee.std_logic_1164.all;

entity mul_2b is
    port (
        a, b: in std_logic_vector(3 downto 1);
        mul :  out std_logic_vector(3 downto 1)
    );
end mul_2b;

architecture multiplication of mul_2b is
    signal s0,s1,s2 : std_logic;
    begin
    -- mul(0) <= a(0) AND b(0);
    s0 <= a(1) AND b(0);
    s1 <= a(0) AND b(1);
    
    
end multiplication;