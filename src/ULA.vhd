library ieee;
use ieee.std_logic_1164.all;
use work.ula_package.all;

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
		HEX0 <=         "1000000" when "000",
						"1111001" when "001",
                        "0100100" when "010",
                        "0110000" when "011",
                        "0011001" when "100",
                        "0010010" when "101",
                        "0000010" when "110",
						"1111111" when others;
	
	with opcode select
		resfinal <=     res_And when "001",
                        res_Not when "010",
                        res_Or when "011",
						res_Soma when "100",
						res_Sub when "101",
						res_Mul when "110",
						"0000" when others;
						 
						 
	with resfinal select
		Hex6 <=    "1000000" when "0000", 
                   "1111001" when "0001",
                   "0100100" when "0010",
                   "0110000" when "0011",
                   "0011001" when "0100",
                   "0010010" when "0101",
                   "0000010" when "0110",
                   "1111000" when "0111",
                   "0000000" when "1000", -- (-8)
                   "1111000" when "1001", -- (-7)
                   "0000010" when "1010", -- (-6)
                   "0010010" when "1011", -- (-5)
                   "0011001" when "1100", -- (-4)
                   "0110000" when "1101", -- (-3)
                   "0100100" when "1110", -- (-2)
                   "1111001" when "1111", --(-1)
                   "1111111" when others;
	
	with A select
		HEX4 <=  "1000000" when "0000", 
                   "1111001" when "0001",
                   "0100100" when "0010",
                   "0110000" when "0011",
                   "0011001" when "0100",
                   "0010010" when "0101",
                   "0000010" when "0110",
                   "1111000" when "0111",
                   "0000000" when "1000", -- (-8)
                   "1111000" when "1001", -- (-7)
                   "0000010" when "1010", -- (-6)
                   "0010010" when "1011", -- (-5)
                   "0011001" when "1100", -- (-4)
                   "0110000" when "1101", -- (-3)
                   "0100100" when "1110", -- (-2)
                   "1111001" when "1111", --(-1)
                   "1111111" when others;

	with B select
		HEX2 <=  "1000000" when "0000", 
                   "1111001" when "0001",
                   "0100100" when "0010",
                   "0110000" when "0011",
                   "0011001" when "0100",
                   "0010010" when "0101",
                   "0000010" when "0110",
                   "1111000" when "0111",
                   "0000000" when "1000", -- (-8)
                   "1111000" when "1001", -- (-7)
                   "0000010" when "1010", -- (-6)
                   "0010010" when "1011", -- (-5)
                   "0011001" when "1100", -- (-4)
                   "0110000" when "1101", -- (-3)
                   "0100100" when "1110", -- (-2)
                   "1111001" when "1111", --(-1)
                   "1111111" when others;
	
end interface;