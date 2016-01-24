----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.01.2016 23:13:31
-- Design Name: 
-- Module Name: tb_txsystem - Behavioral
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

entity tb_txsystem is
--  Port ( );
end tb_txsystem;

architecture Behavioral of tb_txsystem is

component TxSystem is
  Port(Clk: in STD_LOGIC;
         Send : in STD_LOGIC;   
         Data : in STD_LOGIC_VECTOR(7 downto 0);
         Selection : out STD_LOGIC_VECTOR(2 downto 0);
         Done: out STD_LOGIC := '1';
         Tx : out STD_LOGIC := '1');
end component;
signal Clk : STD_LOGIC :='0';
signal Send : STD_LOGIC :='0';
signal Done : STD_LOGIC :='1';
signal Tx : STD_LOGIC :='1';
signal Data : STD_LOGIC_VECTOR (7 downto 0) :="01011101";
signal Selection : STD_LOGIC_VECTOR (2 downto 0) :="010";

-- Clock 
constant CLK_period : time := 200ns;
begin

uut : TxSystem port map(
    Clk => Clk,
    Send => Send,
    Data => Data,
    Selection => Selection,
    Done => Done,
    Tx => Tx
    );

-- Clock process definitions
CLK_process : process
begin
Clk <= '0';
wait for CLK_period / 2;
Clk <= '1';
wait for CLK_period / 2;
end process;

-- Stimulus process
stim_proc : process
begin
Send <= '0';
wait for 20 ns;
Send <= '1';
wait for 1000 ns;
Send <= '0';
wait for 12000 us;
Send <= '1';
wait;
end process;
end Behavioral;
