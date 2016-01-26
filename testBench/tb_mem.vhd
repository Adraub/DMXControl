library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_mem is
--  Port ( );
end tb_mem;

architecture Behavioral of tb_mem is
    component mem is
        Port ( MODE : in STD_LOGIC_VECTOR (2 downto 0);
            DATA : in STD_LOGIC_VECTOR (7 downto 0);
            SAVE : in STD_LOGIC;
            SEL : in STD_LOGIC_VECTOR (2 downto 0);
            D_OUT : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
signal MODE : STD_LOGIC_VECTOR (2 downto 0) := "000"; 
signal DATA : STD_LOGIC_VECTOR (7 downto 0) :="10101010";
signal SAVE : STD_LOGIC := '0'; 
signal SEL : STD_LOGIC_VECTOR (2 downto 0) := "001";  
signal D_OUT : STD_LOGIC_VECTOR (7 downto 0):="00000000";
constant period : time:=10ns;
begin
uut : mem port map(
    MODE => MODE,
    DATA => DATA,
    SAVE => SAVE,
    SEL => SEL,
    D_OUT => D_OUT);

stim_proc : process
    begin
        MODE <= "000";
        DATA <= "10000000";
        SAVE <= '1';
        wait for period;
        SAVE<= '0';
        wait for period;
        MODE <= "001";
        DATA <= "01000000";
        SAVE <= '1';
        wait for period;
        SAVE <= '0';
        wait for period;
        MODE <= "010";
        DATA <= "00100000";
        SAVE <= '1';
        wait for period;
        SAVE <= '0';
        wait for period;
        MODE <= "011";
        DATA <= "00010000";
        SAVE <= '1';
        wait for period;
        SAVE <= '0';
        wait for period;
        MODE <= "100";
        DATA <= "00001000";
        SAVE <= '1';
        wait for period;
        SAVE <= '0';
        wait for period;
        MODE <= "101";
        DATA <= "00000100";
        SAVE <= '1';
        wait for period;
        SAVE <= '0';
        wait for period;
        MODE <= "110";
        DATA <= "00000010";
        SAVE <= '1';
        wait for period;
        SAVE <= '0';
        wait for period;
        MODE <= "111";
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
end Behavioral;
