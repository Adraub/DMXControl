----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.01.2016 11:33:18
-- Design Name: 
-- Module Name: lyreCom - Behavioral
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

entity lyreCom is
    Port ( Clk : in STD_LOGIC;
           Mode : in STD_LOGIC;
           DataIn : in STD_LOGIC_VECTOR (7 downto 0);
           Save : in STD_LOGIC;
           Led : out STD_LOGIC_VECTOR (2 downto 0);
           Send : in STD_LOGIC;
           Done: out STD_LOGIC;
           Tx : out STD_LOGIC);
end lyreCom;

architecture Behavioral of lyreCom is
signal Selectionner : STD_LOGIC_VECTOR(2 downto 0);
signal dataTrans : STD_LOGIC_VECTOR(7 downto 0);


component cpt_mem
    Port ( CLK : in STD_LOGIC;
           MODE : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           SAVE : in STD_LOGIC;
           SEL : in STD_LOGIC_VECTOR (2 downto 0);
           D_OUT : out STD_LOGIC_VECTOR (7 downto 0);
           LED : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component TxSystem
    Port(Clk: in STD_LOGIC;
         Send : in STD_LOGIC;   
         Data : in STD_LOGIC_VECTOR(7 downto 0);
         Selection : out STD_LOGIC_VECTOR(2 downto 0);
         Done: out STD_LOGIC := '1';
         Tx : out STD_LOGIC :='1' );
end component;

begin

memory : cpt_mem port map(
          CLK =>Clk,
          MODE=>Mode,
          DATA =>DataIn,
          SAVE => Save,
          SEL => Selectionner,
          D_OUT => dataTrans,
          LED => Led);

transmitter : TxSystem port map(
           Clk => Clk,
           Send => Send,   
           Data => dataTrans,
           Selection => selectionner,
           Done => Done,
           Tx => Tx);

end Behavioral;
