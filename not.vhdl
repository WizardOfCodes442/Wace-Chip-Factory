VHDL code:

library ieee;
use ieee.std_logic_1164.all;

entity not1 is 
    port(x:in bit; y:out bit);
end not1;

architecture virat of not1 is 
begin 
    y <= not x;
end virat;


