VHDL Code:

library ieee;
use ieee.std_logic_1164.all;

entity xor1 is 
    port(a, b:in bit; c:out bit);
end xor1;

architecture virat of xor1 is
begin
    c<= a xor b
end virat;