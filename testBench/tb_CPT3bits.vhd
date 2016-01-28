library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_CPT3bits is
end tb_CPT3bits;

architecture Behavioral of tb_CPT3bits is

component CPT_3bits is
    Port ( H : in STD_LOGIC;
           C0 : out STD_LOGIC_VECTOR (2 downto 0));
           --Q : out STD_LOGIC_VECTOR);
end component;

signal H : STD_LOGIC := '0';
signal C0 : STD_LOGIC_VECTOR (2 downto 0) := "000";
signal Q : STD_LOGIC_VECTOR (2 downto 0) := "000";
constant period : time := 1 ns;
begin
uut : CPT_3bits port map(
    H => H,
    C0 => C0,
    Q => Q);

H_process : process
begin
    H <= '1';
    wait for period/2;
    H <= '0';
    wait for period/2;
    H <= '1';
    wait for period/2;
    H <= '0';
    wait for period/2;
    H <= '1';
    wait for period/2;
    H <= '0';
    wait for period/2;
end process;
end Behavioral;
