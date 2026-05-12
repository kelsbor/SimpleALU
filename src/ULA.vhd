library ieee;
use ieee.std_logic_1164.all;
use work.ULA_package.all;

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
	signal Res_And, Res_Or, Res_Not, Res_Soma, Res_Sub, Res_Mul : std_logic_vector(3 downto 0);
	signal Res_Comp : std_logic_vector(2 downto 0);
	signal resfinal : std_logic_vector(3 downto 0);
	signal carry_out : std_logic;
	
	begin
	A <= SW(10 downto 7);
	B <= SW(6 downto 3);
	opcode <= SW(2 downto 0);
	
	-- Mapeamos as saídas do display de acordo com os valores de A e B, 
	-- atribuidos através dos switches acionados.
	-- O uso da notação x"0" simplifica a digitação do binário por extenso "0000".
	
	Res_And <= A and B;
	Res_Not <= not B;
	Res_Or <= A or B;
	
	somador : somador_4b port map ('0', A, B, Res_Soma, carry_out);
	subtrator : somador_4b port map ('1', A,B,Res_Sub, carry_out);
	multiplicador : mul_2b port map (A(1 downto 0), B(1 downto 0), res_Mul);
	comparar : comparador port map (A,B, Res_comp(2), Res_Comp(1), Res_Comp(0));
	
	
	with opcode select
		HEX0 <=      "1000000" when "000",
						 "1111001" when "001",
                   "0100100" when "010",
                   "0110000" when "011",
                   "0011001" when "100",
                   "0010010" when "101",
                   "0000010" when "110",
						 "1111111" when others;
	
	with opcode select
		resfinal <=  res_And when "001",
                   res_Not when "010",
                   res_Or when "011",
						 res_Soma when "100",
						 res_Sub when "101",
						 res_Mul when "110",
						 "0000" when others;
						 
						 
	with resfinal select
		Hex6 <= 		 "1000000" when x"0",
                   "1111001" when "0001",
                   "0100100" when x"2",
                   "0110000" when x"3",
                   "0011001" when x"4",
                   "0010010" when x"5",
                   "0000010" when x"6",
                   "1111000" when x"7",
                   "0000000" when x"8",
                   "0010000" when x"9",
                   "0001000" when x"A",
                   "0000011" when x"B",
                   "1000110" when x"C",
                   "0100001" when x"D",
                   "0000110" when x"E",
                   "0001110" when x"1111",
                   "1111111" when others;
	
	with A select
		HEX4 <=  "1000000" when x"0",
                   "1111001" when x"1",
                   "0100100" when x"2",
                   "0110000" when x"3",
                   "0011001" when x"4",
                   "0010010" when x"5",
                   "0000010" when x"6",
                   "1111000" when x"7",
                   "0000000" when x"8",
                   "0010000" when x"9",
                   "0001000" when x"A",
                   "0000011" when x"B",
                   "1000110" when x"C",
                   "0100001" when x"D",
                   "0000110" when x"E",
                   "0001110" when x"F",
                   "1111111" when others;

	with B select
		HEX2 <=  "1000000" when x"0",
                   "1111001" when x"1",
                   "0100100" when x"2",
                   "0110000" when x"3",
                   "0011001" when x"4",
                   "0010010" when x"5",
                   "0000010" when x"6",
                   "1111000" when x"7",
                   "0000000" when x"8",
                   "0010000" when x"9",
                   "0001000" when x"A",
                   "0000011" when x"B",
                   "1000110" when x"C",
                   "0100001" when x"D",
                   "0000110" when x"E",
                   "0001110" when x"F",
                   "1111111" when others;
	
end interface;