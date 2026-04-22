library ieee ;
use ieee.std_logic_1164.all;

entity comparador is
    -- Declaração da Entidade
Port ( 
    a,b : IN STD_LOGIC_vector(3 downto 0) ;
    grt,equ,lst : OUT STD_LOGIC
    ) ;
end comparador;

architecture behavior of comparador is
    -- Sinais intermediários 
    signal i: std_logic_vector(3 downto 0);
    signal j: std_logic_vector(1 downto 0);

begin
    -- Vefica quais bits são iguais a partir da operação XNOR
    i <= a xnor b;

    -- Verifica se a é maior que b bit a bit (a and not b), utilizando o sinal anterior (i)
    -- Se para algum bit a for maior que b o resultado é maior.
    j(0) <= ((a(3) and not b(3)) or (i(3) and a(2) and not b(2)) or (i(3) and i(2) and a(1) and not b(1)) or (i(3) and i(2) and i(1) and a(0) and not b(0)));
    
    -- Se todos os bits forem iguais o valor final é equ
    j(1) <= i(3) and i(2) and i(1) and i(0);

    -- Atribui os sinais aos resultados finais
    equ <=j(1);
    grt <= j(0);

    -- O resultado é menor quando não for nem igual nem maior.
	lst <= j(1) nor j(0);

end behavior;