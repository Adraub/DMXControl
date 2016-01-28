library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpt_mem is
    Port ( CLK : in STD_LOGIC;
           MODE : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           SAVE : in STD_LOGIC;
           SEL : in STD_LOGIC_VECTOR (2 downto 0);
           D_OUT : out STD_LOGIC_VECTOR (7 downto 0);
           LED : out STD_LOGIC_VECTOR (2 downto 0));
end cpt_mem;
architecture Behavioral of cpt_mem is
signal CPT : STD_LOGIC_VECTOR (2 downto 0);

-—Composant compteur 3 bits
component CPT_3bits
    Port ( CLK : in STD_LOGIC;
           H : in STD_LOGIC;
           C0 : out STD_LOGIC_VECTOR (2 downto 0);
           Q : out STD_LOGIC_VECTOR (2 downto 0));
end component;

—-Composant de mémoire
component mem
    Port ( CLK : in STD_LOGIC;
           MODE : in STD_LOGIC_VECTOR (2 downto 0);
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           SAVE : in STD_LOGIC;
           SEL : in STD_LOGIC_VECTOR (2 downto 0);
           D_OUT : out STD_LOGIC_VECTOR (7 downto 0));
end component;

begin
-- Compteur 3 bits
CPT_MODE : CPT_3bits port map (CLK, MODE, CPT, LED);
-- MÈmoire 8 octets
eightbytes_mem : mem port map (CLK, CPT, DATA, SAVE, SEL, D_OUT);

end Behavioral;