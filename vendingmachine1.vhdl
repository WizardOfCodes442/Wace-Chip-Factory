library ieee; use IEEE.std_logic_1164.all;
entity VendingMachine is 
    port (CLK : in std_logic; --Clock, 
        active high RSTn : in std_logic; --Async. 
        Reset, active low money_in : in std_logic_vector (1 downto 0); --Which coin was inserted 
        eggRow : out std_logic; --Is eggRow dispensed ? 
        money_out : out std_logic ); --giving change? ); 
end entity; 
        
architecture behavior of VendingMachine is -- add your code here 
type state_type is ( 
S0,S1,S2,--represent the current sum of money accumulated 
release_fifty, --release #50 naira change
release_eggRow --release eggRow
); --type of state machine. 
signal current_state,next_state: state_type; --current and next state declaration. 
begin process(CLK,RSTn) 
    if(RSTn = '0') 
    then current_s <= S0 --defualt state is on RESET 
    elsif(clk'event and clk = '1') 
    then current_state <= next_state; 
    end if; 
end process; 
--------------------
--VendingMachine process: 
process(current_state, money_in) 
begin 
case current_state is
when money_in =>
    when S0 => --wait for money to be entered 
      if(money_in = "00")then eggRow <= '0'; 
        money_out <= "0"; next_state <= S0; 
      elsif(money_in = "01")then --insert 50 naira 
        eggRow <= '0'; 
        money_out <= "0"; 
        next_state <= S1; 
      elsif(money_in = "10") then --insert 100 naira 
        eggRow <= '0'; 
        money_out <= "0"; 
        next_state <= S2; 
     elsif(money_in = "11")then --insert 50 and 100 at once cause don't care 
        money_out <= 'x'; --don't care
        CoinOut <= "x"; --don't care
        next_state <= 'x';  --don't care 
     end if;
     ------------------------------------------------------ 
     when S1 => ---already accumulated #50
       if(money_in = "00") then--nothing inserted, stay on the same state 
         eggRow <= '0'; 
         money_out <= "0"; 
         next_s <= S1; 
       elsif(money_in = "01") then--inserted another 50 + accumulated 50 
         eggRow <= '0'; 
         money_out <= "0"; 
         next_state <= S2; 
       elsif(money_in = "10") then--inserted another #100 + accm 50 naira 
         eggRow <= '1'; -- you get one egg row; 
         money_out <= "0";  --no change 
         next_state <= release_eggRow; ---- release eggrow mechanism
         when release_eggRow =>
           next_state <= S0; -- reset to default after release eggrow 
       elsif(money_in = "11") then  ---insert #100 + #50 note at once causes don't care 
         eggRow <= 'x'; --don't care
         money_out <= "x"; --don't care 
         next_state <= "x"; --don't care
       end if; 
    ------------------------------------------------------
    when S2 => ---already accumulate 100 from 2F or 1H
       if(money_in = "00") then--nothing inserted stay on the same state 
         eggRow <= '0'; 
         money_out <= "0"; 
         next_s <= S2; 
       elsif(money_in = "01") then--inserted another 50 + accumulated 100 
         eggRow <= '1'; 
         money_out <= "0"; 
         next_state <= release_eggRow;  --- release eggrow mechanism 
         when release_eggRow => --after releasing eggrow
           next_state <= S0; ---reset to default
       elsif(money_in = "10") then--inserted another #100 + accm 50 naira 
         eggRow <= '1'; -- you get one egg row; 
         money_out <= "0";  --no change 
         next_state <= release_eggRow; ---- release eggRow Mechanism
         when release_eggRow =>        --after releasing Eggrow
           next_state <= release_fifty; --- release change mechanism
           when release_fifty =>      ---after releasing change 
             next_state <=  S0; --now finally return to default 
       elsif(money_in = "11") then  ---insert #100 + #50 note at once causes don't care 
         eggRow <= 'x'; 
         money_out <= "x"; 
         next_state <= "x"; 
       end if;   
end case; 
end process; 
end behavior;
