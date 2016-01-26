----------------------------------------------------------------------------------
--Main component used for DMX512 transmission of 8 registers
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TxSystem is
    Port(Clk: in STD_LOGIC;
         Send : in STD_LOGIC;   
         Data : in STD_LOGIC_VECTOR(7 downto 0);
         Selection : out STD_LOGIC_VECTOR(2 downto 0);
         Done: out STD_LOGIC := '1';
         Tx : out STD_LOGIC :='1' );
end TxSystem;

architecture Behavioral of TxSystem is
COMPONENT ClockGenerator
    PORT ( MAINCLK : in STD_LOGIC;
            TRIGGER : in STD_LOGIC;
            BAUDRATE: in INTEGER;
            CLKOUT : out STD_LOGIC);
END COMPONENT;

COMPONENT Com_Init
    PORT ( Clk : in STD_LOGIC;
           BdClk : in STD_LOGIC;
           Start : in STD_LOGIC;
           Done : out STD_LOGIC;
           Tx : out STD_LOGIC);
END COMPONENT;

COMPONENT TxData is
    Port ( ClkTx : in STD_LOGIC;
           BdClkTx : in STD_LOGIC;
           StartTx : in STD_LOGIC;
           Data : in STD_LOGIC_VECTOR(7 downto 0);
           Done : out STD_LOGIC;
           Tx2 : out STD_LOGIC);
END COMPONENT;

TYPE STATE_TYPE IS (Idle,Init,Tr0,Tr1,Tr2
    ,Tr3,Tr4,Tr5,Tr6,Tr7);
    signal state : STATE_TYPE := Idle;

constant BaudRate : integer := 250000;
signal BdClkEn : std_logic := '0';
signal BdCLk : std_logic :='0';
signal DoneInit : std_logic;
signal DoneTx : std_logic;
signal TxIn : std_logic;
signal TxSe : std_logic;
signal SendInit : std_logic := '0';
signal SendTx : std_logic := '0';
signal Carry : STD_LOGIC_VECTOR (2 downto 0) := "111"; 
signal Counter : integer;


begin
 ClkGen : ClockGenerator PORT MAP(
    MAINCLK =>Clk,
    TRIGGER => BdClkEn,
    BAUDRATE => BaudRate,
    CLKOUT =>BdClk);
    
 TxInit : Com_Init PORT MAP(
        Clk =>Clk,
        BdClk => BdClk,
        Start => SendInit,
        Done => DoneInit,
        Tx => TxIn);
        
  TxSend : TxData PORT MAP(
                ClkTx =>Clk,
                BdClkTx => BdClk,
                StartTx => SendTx,
                Data => Data,
                Done => DoneTx,
                Tx2 => TxSe);
                
   Selection <=Carry;             
--Machine état
       FSMglobal : process(Clk)
                begin
                    If Clk'event and Clk='1' then
                        CASE state IS
                            WHEN Idle =>
                                 if Send = '1' then
                                        state <= Init;
                                        Counter <= 1;
                                 else
                                        state<= Idle;
                                 end if;
                            WHEN Init =>
                                 if DoneInit = '1' and Counter > 5 then
                                        state <= Tr0;
                                        Counter <= 1;
                                 else
                                        state<= Init;
                                        Counter <= Counter+1;
                                 end if;
                            WHEN Tr0 => 
                                 if DoneTx = '1' and Counter > 5 then
                                       state <= Tr1;
                                       Counter <= 1;
                                 else
                                       state<= Tr0;
                                       Counter <= Counter+1;
                                 end if;
                            WHEN Tr1 => 
                                if DoneTx = '1' and Counter > 5 then
                                       state <= Tr2;
                                       Counter <= 1;
                                else
                                       state<= Tr1;
                                       Counter <= Counter+1;
                                end if;
                            WHEN Tr2 => 
                                 if DoneTx = '1' and Counter > 5 then
                                      state <= Tr3;
                                      Counter <= 1;
                                  else
                                      state<= Tr2;
                                      Counter <= Counter+1;
                                  end if;
                            WHEN Tr3 => 
                                 if DoneTx = '1' and Counter > 5 then
                                      state <= Tr4;
                                      Counter <= 1;
                                 else
                                      state<= Tr3;
                                      Counter <= Counter+1;
                                 end if;
                            WHEN Tr4 => 
                                 if DoneTx = '1' and Counter > 5 then
                                       state <= Tr5;
                                       Counter <= 1;
                                 else
                                       state<= Tr4;
                                       Counter <= Counter+1;
                                 end if;
                            WHEN Tr5 => 
                                  if DoneTx = '1' and Counter > 5 then
                                       state <= Tr6;
                                       Counter <= 1;
                                  else
                                       state<= Tr5;
                                       Counter <= Counter+1;
                                  end if;
                            WHEN Tr6 => 
                                  if DoneTx = '1' and Counter > 5 then
                                        state <= Tr7;
                                        Counter <= 1;
                                  else
                                        state<= Tr6;
                                        Counter <= Counter+1;
                                  end if;
                            WHEN Tr7 => 
                                  if DoneTx = '1' and Counter > 5 then
                                         state <= Idle;
                                         Counter <= 1;
                                  else
                                         state<= Tr7;
                                         Counter <= Counter+1;
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
                                Carry <= "000";
                                BdClkEn <= '0';
                                SendTx <= '0';
                                SendInit <='0';
                            WHEN Init =>
                                Tx <= Txin;
                                Done <= '0';
                                Carry <= "111";
                                BdClkEn <= '1';
                                if DoneInit = '1' and Counter<20 then
                                    SendInit <='1';
                                else
                                    SendInit <='0';
                                end if;
                            WHEN Tr0 =>
                                    Tx <= TxSe;
                                    Done <= '0';
                                    Carry <= "000";
                                    BdClkEn <= '1';
                                    if DoneTx = '1' then
                                          SendTx <='1';
                                    else
                                          SendTx <='0';
                                    end if;
                            WHEN Tr1 =>
                                    Tx <= TxSe;
                                    Done <= '0';
                                    Carry <= "001";
                                    BdClkEn <= '1';
                            WHEN Tr2 =>
                                    Tx <= TxSe;
                                    Done <= '0';
                                    Carry <= "010";
                                    BdClkEn <= '1';
                            WHEN Tr3 =>
                                    Tx <= TxSe;
                                    Done <= '0';
                                    Carry <= "011";
                                    BdClkEn <= '1';
                            WHEN Tr4 =>
                                    Tx <= TxSe;
                                    Done <= '0';
                                    Carry <= "100";
                                    BdClkEn <= '1';
                            WHEN Tr5 =>
                                    Tx <= TxSe;
                                    Done <= '0';
                                    Carry <= "101";
                                    BdClkEn <= '1';
                            WHEN Tr6 =>
                                    Tx <= TxSe;
                                    Done <= '0';
                                    Carry <= "110";
                                    BdClkEn <= '1';
                            WHEN Tr7 =>
                                    Tx <= TxSe;
                                    Done <= '0';
                                    Carry <= "111";
                                    BdClkEn <= '1';
                           END CASE;
                    end if;  
                end process; 

end Behavioral;
