--welcome to the mealy 
--vending machine with three states
--it accepts two types of notes 
-- a fifty(F) and a hundred(H)
--each with a weight of 50 and 100 respectively
-- it gives a egg for 150 
--and gives a change of 50 if it accumulate 200

library ieee;
use ieee.std_logic_1164.all

--code the specification
entity mealyVendingMachine is
    port (clk, rst: IN STD_LOGIC; money_in: IN BOOLEAN;
            eggRow, fifty_out: OUT STD_LOGIC);
end entity;

--code the architecture

architecture behavior of mealyVendingMachine is
type state_type is (S0, S1, S2, eggRow_out, release_fifty);
signal present_state, next_state: state_type;
begin process(clk, rst)
    if (rst = '0')
    then present_state <= S0; --default state after reset
    else if (clk'event and clk = '1') then present_state <= next_state;
    end if;
end process;
process (present_state, money_in)
case present_state is 
    when S0 => --state reset or idle
      eggRow <= '0';
      fifty_out <= '0';
      next_state <= S0;
end sequential;
    when money_in => ----wait for a note to be slot in 
        if (money_in = "00") then
          eggRow <= '0';
          fifty_out <= '0';
          next_state <= S0;
        elsif (money_in = "01") then --slot in 50 naira
          eggRow <= '0';
          fifty_out <= '0';
          next_state <= S1;      
        elsif (money_in = "10") then --slot 100 naira
          eggRow <= '0';
          fifty_out <= '0';
          next_state <= S2;
              
        elsif(money_in ="11") then --insert 100 and 50 at once error
          eggRow <= 'x'; --don't care
          fifty_out <= 'x'; --don't care
          next_state <= 'x';--don't care
        end if; 
            ---------------------------------------------------
    when S1 => -- you already have 50 naira in the machine
        if (money_in = "00") then --- nothing inserted, repeat
          eggRow <= '0';
          fifty_out <= '0';
          next_state <= S1;              
        elsif(money_in = "01") then --now you have 100 naira 
          eggRow <= '0';
          fifty_out <= '0';
          next_state <= S2;
              
        elsif(money_in = "10") then -- slot in 100, now you have 150
          eggRow <= '1'; ---gives you an eggrow
          fifty_out <= '0'; --no change
          next_state <= eggRow_out;
          when eggRow_out;
            next_state <= S0;

        elsif(money_in =="11")  then --causes a don't care
          eggRow <= 'x';
          fifty_out = 'x';
          next_state = 'x';
        ---------------------------------------------

    when S2 => --you already accumulated 100 through 1H or 2F
      if(money_in = "00") -- noting slotted in 
        eggRow <= '0';
        fifty_out <= '0';
        next_state <= S2;
                
      elsif (money_in = "01") -- 50 inserted + accm 100 
        eggRow <= '1'; ---gives you an eggrow
        fifty_out <= '0'; --no change
        next_state <= eggRow_out;
        when eggRow_out =>;
        next_state <= S0;

      elsif (money_in = "10") -- 100 inserted + accm 100
        eggRow <= '1'; --- gives you an egg row 
        fifty_out <= '1'; -- you get a fifty 
        next_state <= eggRow_out;
        when eggRow_out => ---giving eggrow
          next_state <= release_fifty; -- giving chnage
            when release_fifty =>
              next_state <= S0; --reset 
            
      elsif (money_in = "11") --causes don't care
        eggRow <= 'x';
        fifty_out <= 'x';
        next_state <= 'x';
        end if;
end case;
end process;
end behavior;