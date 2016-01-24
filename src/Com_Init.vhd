
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Com_Init is
    Port ( Clk : in STD_LOGIC;
           BdClk : in STD_LOGIC;
           Start : in STD_LOGIC;
           Done : out STD_LOGIC;
           Tx : out STD_LOGIC);
end Com_Init;

architecture Behavioral of Com_Init is
    TYPE STATE_TYPE IS (Idle,Break,MAB,Start_Code
    ,StopB,MTBF);
    signal state : STATE_TYPE := Idle;
    signal Counter : integer;
begin

--Machine état
FSMinit : process(Clk)
begin
    If Clk'event and Clk='1' then
        CASE state IS
            WHEN Idle =>
                      if Start = '1' then
                             state <= Break;
                             Counter <= 1;
                      else
                            state<= Idle;
                      end if;
            WHEN Break =>
                          if BdClk = '1' then
                            if Counter = 22 then
                                state <= MAB;
                                Counter <= 1;
                            else
                                Counter <= Counter+1;
                                state<= Break;
                            end if;
                          end if;
            WHEN MAB => 
             if BdClk = '1' then
              if Counter = 2 then
                  state <= Start_Code;
                  Counter <= 1;
              else
                  Counter <= Counter+1;
                  state<= MAB;
              end if;
            end if;
            WHEN Start_Code => 
             if BdClk = '1' then
              if Counter = 9 then
                  state <= StopB;
                  Counter <= 1;
              else
                  Counter <= Counter+1;
                  state<= Start_Code;
              end if;
            end if;  
            WHEN StopB => 
             if BdClk = '1' then
              if Counter = 2 then
                  state <= MTBF;
                  Counter <= 1;
              else
                  Counter <= Counter+1;
                  state<= StopB;
              end if;
            end if;
            WHEN MTBF => 
             if BdClk = '1' then
                state<= Idle;
             else
                  state<= MTBF;
            end if;                           
        END CASE;
     end if;  
end process; 

--Etat des sorties
FSMvalue : process(Clk)
begin
    If Clk'event and Clk='1' then
        CASE state IS
            WHEN Idle =>
                Tx <= '1';
                Done <= '1';
            WHEN Break =>
                Tx <= '0';
                Done <= '0';
            WHEN MAB =>
                    Tx <= '1';
                    Done <= '0';
            WHEN Start_Code =>
                        Tx <= '0';
                        Done <= '0';
            WHEN StopB =>
                        Tx <= '1';
                        Done <= '0';
            WHEN MTBF =>
                           Tx <= '1';
                           Done <= '0';
           END CASE;
    end if;  
end process; 

end Behavioral;
