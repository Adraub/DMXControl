----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.01.2016 17:52:25
-- Design Name: 
-- Module Name: ClockGenerator - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ClockGenerator is
    Port ( MAINCLK : in STD_LOGIC;
            TRIGGER : in STD_LOGIC;
            BAUDRATE: in INTEGER;
            CLKOUT : out STD_LOGIC);
end ClockGenerator;

architecture Behavioral of ClockGenerator is
    CONSTANT MAINFREQ : integer := 100000000;
    
    signal counter : integer;
    begin
    process(MAINCLK, TRIGGER)
    begin
        If MAINCLK'event and MAINCLK='1' then
            if TRIGGER = '1' then
                if counter>=MAINFREQ/BAUDRATE then counter <=0;
                        CLKOUT<='1';
                else counter<=counter+1;
                    CLKOUT<='0';
                end if;
             else 
                counter <= 0;
                CLKOUT<='0'; 
             end if;
         end if;
     end process;


end Behavioral;
