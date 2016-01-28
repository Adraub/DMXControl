----------------------------------------------------------------------------------
-- This component allows to send a byte on the dmx bus
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--StartTx: launch transmission
--Data: byte to be send
--Done: '1' if transmission is over
--Tx2: Connected to dmx bus
entity TxData is
    Port ( ClkTx : in STD_LOGIC;
           BdClkTx : in STD_LOGIC;
           StartTx : in STD_LOGIC;
           Data : in STD_LOGIC_VECTOR(7 downto 0);
           Done : out STD_LOGIC;
           Tx2 : out STD_LOGIC);
end TxData;

 architecture Behavioral of TxData is

TYPE STATE_TYPE IS (Idle,StartB,Tr0,Tr1,Tr2
    ,Tr3,Tr4,Tr5,Tr6,Tr7,Stop,MTBF);
    signal state : STATE_TYPE := Idle;
    signal Counter : integer;

begin

--finit state machine
FSMtx : process(ClkTx)
begin
    If ClkTx'event and ClkTx='1' then
        CASE state IS
            WHEN Idle =>
                if StartTx = '1' then
                       state <= StartB;
                       Counter <= 1;
                else
                       state<= Idle;
                end if;
            WHEN StartB =>
                if BdClkTx = '1' then
                       state <= Tr0;
                else
                       state<= StartB;
                end if;
            WHEN Tr0 => 
                if BdClktx = '1' then
                       state<= Tr1;
                else
                       state<= Tr0;
                end if;
            WHEN Tr1 => 
               if BdClkTx = '1' then
                       state<= Tr2;
               else
                       state<= Tr1;
               end if;
            WHEN Tr2 => 
               if BdClkTx = '1' then
                      state<= Tr3;
               else
                      state<= Tr2;
               end if;
            WHEN Tr3 => 
              if BdClkTx = '1' then
                     state<= Tr4;
              else
                     state<= Tr3;
              end if;
            WHEN Tr4 => 
              if BdClkTx = '1' then
                   state<= Tr5;
              else
                   state<= Tr4;
              end if;
            WHEN Tr5 => 
              if BdClkTx = '1' then
                   state<= Tr6;
              else
                   state<= Tr5;
              end if;
            WHEN Tr6 => 
              if BdClkTx = '1' then
                  state<= Tr7;
              else
                  state<= Tr6;
              end if;
            WHEN Tr7 => 
              if BdClkTx = '1' then
                  state<= Stop;
              else
                  state<= Tr7;
              end if;
            WHEN Stop =>
              if BdClkTx = '1' then
                 if Counter = 2 then
                     state <= MTBF;
                     Counter <= 1;
                 else
                     Counter <= Counter+1;
                     state<= Stop;
                 end if;
              end if;
            WHEN MTBF => 
                 if BdClkTx = '1' then
                      state<= Idle;
                 else
                      state<= MTBF;
                 end if;                                      
        END CASE;
     end if;  
end process; 


--states and its outputs
FSMvalue : process(ClkTx)
begin
    If ClkTx'event and ClkTx='1' then
        CASE state IS
            WHEN Idle =>
                Tx2 <= '1';
                Done <= '1';
            WHEN StartB =>
                Tx2 <= '0';
                Done <= '0';
            WHEN Tr0 =>
                Tx2 <= Data(7);
                Done <= '0';
            WHEN Tr1 =>
                Tx2 <= Data(6);
                Done <= '0';
            WHEN Tr2 =>
                Tx2 <= Data(5);
                Done <= '0';
            WHEN Tr3 =>
                Tx2 <= Data(4);
                Done <= '0';
            WHEN Tr4 =>
                Tx2 <= Data(3);
                Done <= '0';
            WHEN Tr5 =>
                Tx2 <= Data(2);
                Done <= '0';
            WHEN Tr6 =>
                Tx2 <= Data(1);
                Done <= '0';
            WHEN Tr7 =>
                Tx2 <= Data(0);
                Done <= '0';           
            WHEN Stop =>
                Tx2 <= '1';
                Done <= '0';
            WHEN MTBF =>
                Tx2 <= '1';
                Done <= '0';
           END CASE;
    end if;  
end process; 

end Behavioral;
