library ieee;
use ieee.std_logic_1164.all;

entity vending_machine is 
    Port(clk, rst :IN STD_LOGIC; 
    nickel_in, dime_in, quarter_in : IN BOOLEAN;
    candy_out, nickel_out, dime_out, quarter_out : OUT STD_LOGIC);
end vending_machine;

architecture fsm of vending_machine IS 
TYPE state IS (st0, st5, st10, st15, st15, st20, st25, st30, st35,
st40, st45);
SIGNAL present_state, next_state:STATE;

begin
    process(rst, clk)
    begin
        if (rst = '1') then 
          present_state <= st0;
        elsif (clk' EVENT AND clk='1') THEN
          present_stake <= next_state;
        end if;
    end process;

    process(present_state, money_in)
    begin
        case present_state is
            when idle => --state reset or idle 
                eggRow <= 0;
                m