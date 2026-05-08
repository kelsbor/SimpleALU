library ieee;
use ieee.std_logic_1164.all;

-- Arquivo central do projeto que une a lógica da ULA e a interface da placa

entity ULA is
	port (
		SW: in std_logic_vector(10 downto 0);
		
		-- Responsavel por mostrar o opcode selecionado
		HEX0: out std_logic_vector(6 downto 0); -- Opcode selecionado
		HEX2: out std_logic_vector(6 downto 0); -- Representação do Número B
		HEX4: out std_logic_vector(6 downto 0); -- Representação do Número A
		HEX6: out std_logic_vector(6 downto 0); -- Resultado da operação selecionada (opcode)
		LEDR: out std_logic_vector(5 downto 0) -- Flags (overflow, zero, cout, comparações)
	);
	
end entity ULA;

architecture interface of ULA is
	signal A,B : std_logic_vector(3 downto 0);
	signal opcode : std_logic_vector (2 downto 0);
	
	begin
	A <= SW(10 downto 7);
	B <= SW(6 downto 3);
	opcode <= SW(2 downto 0);
	
	with opcode select
		HEX0 <= "0000001" when "000",
			"0000010" when "001",
			"0000011" when "010",
			"0000100" when "011",
			"0000101" when "100",
			"0000110" when others;
		
end interface;