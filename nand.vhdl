VHDL code:

library ieee;
use ieee.std_logic_1164.all;

entity nand1 is
    port(a, b;in bit; c:out bit);
end nand1;

architecture virat of nand1 is
begin 
    c <=a nand b;
end virat;