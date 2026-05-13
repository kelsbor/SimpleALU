library ieee;
use ieee.std_logic_1164.all;
use work.ula_package.full_adder;

-- Declaração das entradas e saídas do somador
entity somasub_4b is
  port (
    Cin       : in std_logic;
    A         : in std_logic_vector(3 downto 0);
    B         : in std_logic_vector(3 downto 0);
    soma      : out std_logic_vector(3 downto 0);
    carry_out, overflow, zero: out std_logic
  );
end somasub_4b;

architecture somar of somasub_4b is
  -- Declaração de sinais intermediários para os carrys e inversão de B
  signal c0, c1, c2, carry_aux: std_logic;
  signal B_aux, soma_aux: std_logic_vector(3 downto 0);

begin
  -- Quando Cin recebe 1, somador se torna subtrator com inverão da Entrada B.
  with Cin select
    B_aux<= not B when '1',
    B when others;

  SO1 : full_adder PORT map (carry_in => Cin, bit_a => A(0), bit_b => B_aux(0), sum => soma_aux(0), carry_out => c0);
  SO2 : full_adder PORT map (carry_in => c0, bit_a => A(1), bit_b => B_aux(1), sum => soma_aux(1), carry_out => c1);
  SO3 : full_adder PORT map (carry_in => c1, bit_a => A(2), bit_b => B_aux(2), sum => soma_aux(2), carry_out => c2);
  SO4 : full_adder PORT map (carry_in => c2, bit_a => A(3), bit_b => B_aux(3), sum => soma_aux(3), carry_out => carry_aux);

  carry_out <= carry_aux;
  soma <= soma_aux;

  -- Multiplexador verifica se o resultado da soma é zero
  with soma_aux select
    zero <= '1' when "0000",
            '0' when others;
  
  -- Verificação da condição de overflow a partir da verificação
  -- entre carry de entrada e saída no ultimo bit
  overflow <= c2 XOR carry_aux;
end somar;