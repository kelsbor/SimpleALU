library ieee ;
use ieee.std_logic_1164.all;

entity comparador is
Port ( 
    a,b : IN STD_LOGIC_vector(3 downto 0) ;
    grt,equ,lst : OUT STD_LOGIC
    ) ;
end comparador;

architecture behavior of comparador is
    signal i: std_logic_vector(3 downto 0);
    signal j: std_logic_vector(1 downto 0);

begin
     i <= a xnor b;
     j(0) <= ((a(3) and not b(3)) or (i(3) and a(2) and not b(2)) or (i(3) and i(2) and a(1) and not b(1)) or (i(3) and i(2) and i(1) and a(0) and not b(0)));
     j(1) <= i(3) and i(2) and i(1) and i(0);
     equ <=j(1);
     grt <= j(0);
	 lst <= j(1) nor j(0);

end behavior;