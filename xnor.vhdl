VHDL Code:

library ieee;
use ieee.std_logic_1164.all;

entity xnor1 is 
    port(a, b:in bit; c:out bit);
end xnor1;

architecture virat of xnor1 is 
begin 
    c<=not(a xor b);
end virat; 