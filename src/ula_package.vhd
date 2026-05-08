library ieee;
use ieee.std_logic_1164.all;

package ula_package is
    component full_adder is
        port (
            carry_in : in STD_LOGIC;
            bit_a : in STD_LOGIC;
            bit_b : in STD_LOGIC;
            sum : out STD_LOGIC;
            carry_out : out STD_LOGIC
        );
    end component;
end package ula_package;