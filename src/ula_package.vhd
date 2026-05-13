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

    component somasub_4b is
        port (
            Cin : in std_logic;
		    A: in std_logic_vector(3 downto 0);
		    B: in std_logic_vector(3 downto 0);
		    soma : out std_logic_vector(3 downto 0);
		    carry_out, overflow, zero : out std_logic
        );
    end component;

    component mul_2b is
        port (
            a,b : in std_logic_vector(1 downto 0);
            mul : out std_logic_vector(3 downto 0)
        );
    end component;
	 
    component comparador is
        port (
            a,b : in std_logic_vector(3 downto 0);
            grt, equ, lst : out std_logic
        );
    end component;
end package ula_package;