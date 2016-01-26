library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_cpt_mem is
end tb_cpt_mem;

architecture Behavioral of tb_cpt_mem is

--
component cpt_mem is
    Port ( MODE : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           SAVE : in STD_LOGIC;
           SEL : in STD_LOGIC_VECTOR (2 downto 0);
           D_OUT : out STD_LOGIC_VECTOR (7 downto 0);
           LED : out STD_LOGIC_VECTOR (2 downto 0);
           CLK : in STD_LOGIC);
end component;

signal CLK : STD_LOGIC := '0';
signal MODE : STD_LOGIC := '0'; 
signal DATA : STD_LOGIC_VECTOR (7 downto 0) :="10101010";
signal SAVE : STD_LOGIC := '0'; 
signal SEL : STD_LOGIC_VECTOR (2 downto 0) := "001";  
signal D_OUT : STD_LOGIC_VECTOR (7 downto 0):="00000000";
signal LED : STD_LOGIC_VECTOR (2 downto 0);
constant period : time:=10ns;
--

begin
uut : cpt_mem port map(
    MODE => MODE,
    DATA => DATA,
    SAVE => SAVE,
    SEL => SEL,
    D_OUT => D_OUT,
    LED => LED,
    CLK => CLK);

CLKprocess : process
begin
    CLK <= '0';
    wait for period/2;
    CLK <= '1';
    wait for period/2;
end process;

stim_proc : process
    begin
        --Mode 0
        DATA <= "10000000";
        SAVE <= '1';
        wait for period;
        SAVE<= '0';
        
        --Mode 1        
        wait for period;
        MODE <= '1';
        wait for period/2;
        MODE <= '0';
        wait for period/2;
        DATA <= "01000000";
        SAVE <= '1';
        wait for period;
        SAVE <= '0';
        
        --Mode 2
        wait for period;
        MODE <= '1';
        wait for period/2;
        MODE <= '0';
        wait for period/2;
        DATA <= "00100000";
        SAVE <= '1';
        wait for period;
        SAVE <= '0';
        
        --Mode 3
        wait for period;
        MODE <= '1';
        wait for period/2;
        MODE <= '0';
        wait for period/2;
        DATA <= "00010000";
        SAVE <= '1';
        wait for period;
        SAVE <= '0';
        
        --Mode 4
        wait for period;
        MODE <= '1';
        wait for period/2;
        MODE <= '0';
        wait for period/2;
        DATA <= "00001000";
        SAVE <= '1';
        wait for period;
        SAVE <= '0';
        
        --Mode 5
        wait for period;
        MODE <= '1';
        wait for period/2;
        MODE <= '0';
        wait for period/2;
        DATA <= "00000100";
        SAVE <= '1';
        wait for period;
        SAVE <= '0';
        
        --Mode 6
        wait for period;
        MODE <= '1';
        wait for period/2;
        MODE <= '0';
        wait for period/2;
        DATA <= "00000010";
        SAVE <= '1';
        wait for period;
        SAVE <= '0';
        
        --Mode 7
        wait for period;
        MODE <= '1';
        wait for period/2;
        MODE <= '0';
        wait for period/2;
        DATA <= "00000001";
        SAVE <= '1';
        wait for period;
        SAVE <= '0';
        wait for period*4;
        
        SEL <= "000";
        wait for period;
        SEL <= "001";
        wait for period;
        SEL <= "010";
        wait for period;
        SEL <= "011";
        wait for period;
        SEL <= "100";
        wait for period;
        SEL <= "101";
        wait for period;
        SEL <= "110";
        wait for period;
        SEL <= "111";
        wait for period;
    end process;
--
end Behavioral;
