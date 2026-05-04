library ieee;
use ieee.std_logic_1164.all;

package ULA is
    component full_adder is
        port (
            carry_in : in STD_LOGIC;
            bit_a : in STD_LOGIC;
            bit_b : in STD_LOGIC;
            sum : out STD_LOGIC;
            carry_out : out STD_LOGIC
        );
    end component;
end package ULA;