VHDL code:

library ieee;
use ieee.std_logic_1164.all;

entity nor1 is
    port(a, b:in bit; c:out bit);
end nor1;

architecture virat of nor1 is 
begin 
    c<= a nor b