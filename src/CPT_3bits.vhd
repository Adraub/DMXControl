library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

—- Définition du compteur 3 bits
entity CPT_3bits is
    Port ( CLK : in STD_LOGIC;
           H : in STD_LOGIC;
           C0 : out STD_LOGIC_VECTOR (2 downto 0); —- Sortie du compteur vers la mémoire
           Q : out STD_LOGIC_VECTOR (2 downto 0)); —- Sortie du compteur vers les LEDs
end CPT_3bits;

architecture Behavioral of CPT_3bits is
signal CPT : STD_LOGIC_VECTOR (2 downto 0) := "000";

begin
C0 <= CPT;
Q <= CPT;
process(CLK)
begin
if CLK'EVENT and CLK = '1' then
    if H='1' then 
        case CPT is
            when "111" => CPT <= "000";
            when others => CPT <= CPT + 1;
        end case;
    else null;
    end if;
end if;
end process;
end Behavioral;
