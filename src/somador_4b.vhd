library ieee;
use ieee.std_logic_1164.all;
use work.ula_package.full_adder;

entity somador_4b is
	port (
		Cin: in std_logic;
		A: in std_logic_vector(3 to 0);
		B: in std_logic_vector(3 to 0);
		soma : out std_logic_vector(3 to 0);
		carry_out: out std_logic
	);
end somador_4b;

architecture somar of somador_4b is
	signal c0,c1,c2 : std_logic;
	
	begin
	SO1 : full_adder port map (carry_in => Cin, bit_a=> A(0), bit_b=>B(0) , sum=> soma(0), carry_out => c0);
	SO2 : full_adder port map (carry_in => c0, bit_a=> A(1), bit_b=>B(1) , sum=> soma(1), carry_out => c1);
	SO3 : full_adder port map (carry_in => C1, bit_a=> A(2), bit_b=>B(2) , sum=> soma(2), carry_out => c2);
	SO4 : full_adder port map (carry_in => C2, bit_a=> A(3), bit_b=>B(3) , sum=> soma(3), carry_out => carry_out);
	
end somar;