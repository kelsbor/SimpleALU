library ieee;
use ieee.std_logic_1164.all;
use work.ula_package.all;

-- Arquivo central do projeto que une a lógica da ULA e a interface da placa

entity ULA is
	port (
		-- Switches de entrada para selação dos numeros e da operação
        SW: in std_logic_vector(10 downto 0);

		-- Responsavel por mostrar o opcode selecionado
		HEX0: out std_logic_vector(6 downto 0); -- Opcode selecionado

		HEX2: out std_logic_vector(6 downto 0); -- Representação do Número B
        HEX3: out std_logic_vector(6 downto 0); -- Sinal do número B, caso seja negativo.

		HEX4: out std_logic_vector(6 downto 0); -- Representação do Número A
        HEX5: out std_logic_vector(6 downto 0); -- Sinal do número A, caso seja negativo.

		HEX6: out std_logic_vector(6 downto 0); -- Resultado da operação selecionada
        HEX7: out std_logic_vector(6 downto 0); -- Sinal da Operação, caso seja negativo.

		LEDR: out std_logic_vector(5 downto 0) -- Flags (overflow, zero, cout, comparações)
	);
	
end entity ULA;

architecture interface of ULA is
    -- Sinais de entrada
	signal A,B : std_logic_vector(3 downto 0);
    signal half_A, half_B: std_logic_vector(1 downto 0);
	signal opcode : std_logic_vector (2 downto 0);

    -- Sinal para display de multiplicação (mostra apenas os 2 bits de entrada)
    signal A_filtro, B_filtro : std_logic_vector(3 downto 0);

    -- Sinal para mostrar o código opcode no display (formato 4 bits)
    signal op_filtro : std_logic_vector(3 downto 0);

    -- Resultados das operações
	signal Res_And, Res_Or, Res_Not, Res_Soma, Res_Sub, Res_Mul : std_logic_vector(3 downto 0);
	signal resfinal : std_logic_vector(3 downto 0);

    -- Sinais para cada operação para não haver interferências
	signal carry_out_soma, carry_out_sub, overflow_soma, overflow_sub, zero_soma, zero_sub : std_logic;
	signal lst, equ, grt: std_logic;
	
    -- Sinal final das flags que vão ativar os LEDs
    signal overflow_flag, zero_flag, carry_out_flag: std_logic;

    -- Controle de sinalização das operações (sub e soma)
    signal sig_operation : std_logic;

	begin
    -- Atribuição dos sinais de entrada 
	A <= SW(10 downto 7);
	B <= SW(6 downto 3);
	opcode <= SW(2 downto 0);

    -- Atribuição dos sinais de saída
    Res_And <= A and B;
	Res_Not <= not B;
	Res_Or <= A or B;

	somador : somasub_4b port map ('0', A, B, Res_Soma, carry_out_soma, overflow_soma, zero_soma);
	subtrator : somasub_4b port map ('1', A,B,Res_Sub, carry_out_sub, overflow_sub, zero_sub);
	comparador_inst : comparador port map (A,B, grt, equ, lst);
	multiplicador : mul_2b port map (A(1 downto 0), B(1 downto 0), res_Mul);
	
    -- A partir do valor de Opcode selecionado é selecionado o valor da operação correspondente
	with opcode select
		resfinal <=     res_And when "001", -- Não sinalizado
                        res_Not when "010", -- Não sinalizado
                        res_Or when "011", -- Não sinalizado
						res_Soma when "100",
						res_Sub when "101",
						res_Mul when "110", -- Não é sinalizado
						"0000" when others;
	
    with opcode select
        sig_operation <= 
            '1' when "100",
            '1' when "101",
            '0' when others;
	
    with opcode select
        overflow_flag <= 
            overflow_soma when "100",
            overflow_sub when "101",
            '0' when others;

    with opcode select
        zero_flag <= 
            zero_soma when "100",
            zero_sub when "101",
            '0' when others;

    with opcode select
        carry_out_flag <= 
            carry_out_soma when "100",
            carry_out_sub when "101",
            '0' when others;
    
    LEDR(0) <= carry_out_flag;
    LEDR(1) <= zero_flag;
    LEDR(2) <= overflow_flag;
    with opcode select
        LEDR(3) <= equ when "111", '0' when others;
    with opcode select
        LEDR(4) <= grt when "111", '0' when others;
    with opcode select
        LEDR(5) <= lst when "111", '0' when others;

    -- Entradas filtradas para o display A e B para a operação de multiplicação e NOP
    with opcode select
        A_filtro <= 
            "00" & A(1 downto 0) when "110",
            "0000" when "000",
            A when others;
    with opcode select
        B_filtro <= 
            "00" & B(1 downto 0) when "110",
            "0000" when "000",
            B when others;
    
    op_filtro <= "0" & opcode;

    display_opcode : display_logic port map (
        number => op_filtro,
        is_signed => '0',
        display_hex => HEX0,
        sinal_hex => open
    );

    display_A : display_logic port map (
        number => A_filtro,
        is_signed => sig_operation,
        display_hex => HEX4,
        sinal_hex => HEX5
    );
    
    display_B : display_logic port map (
        number => B_filtro,
        is_signed => sig_operation,
        display_hex => HEX2,
        sinal_hex => HEX3
    );

    display_result : display_logic port map (
        number => resfinal,
        is_signed => sig_operation,
        display_hex => HEX6,
        sinal_hex => HEX7
    );
end interface;