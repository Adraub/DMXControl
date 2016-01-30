library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mem is
    Port ( CLK : in STD_LOGIC;
           MODE : in STD_LOGIC_VECTOR (2 downto 0);
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           SAVE : in STD_LOGIC;
           SEL : in STD_LOGIC_VECTOR (2 downto 0);
           D_OUT : out STD_LOGIC_VECTOR (7 downto 0));
end mem;

architecture Behavioral of mem is
—-Définition de la mémoire 8 octets comme un tableau de 8 vecteurs
type memArray is array (0 to 7) of STD_LOGIC_VECTOR(7 downto 0);
signal memSignal : memArray:=("00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000", "00000000");
signal DOUT : STD_LOGIC_VECTOR (7 downto 0):="00000000";

begin
D_OUT <= DOUT;
process(CLK)
begin
if CLK'EVENT and CLK='1' then
    if SAVE='1' then
        case MODE is
            when "000" => memSignal(0) <= DATA;
            when "001" => memSignal(1) <= DATA;
            when "010" => memSignal(2) <= DATA;
            when "011" => memSignal(3) <= DATA;
            when "100" => memSignal(4) <= DATA;
            when "101" => memSignal(5) <= DATA;
            when "110" => memSignal(6) <= DATA;
            when "111" => memSignal(7) <= DATA;
            when others => null;
        end case;
     else null;
     end if;

    case SEL is
        when "000" => DOUT <= memSignal(0);
        when "001" => DOUT <= memSignal(1);
        when "010" => DOUT <= memSignal(2);
        when "011" => DOUT <= memSignal(3);
        when "100" => DOUT <= memSignal(4);
        when "101" => DOUT <= memSignal(5);
        when "110" => DOUT <= memSignal(6);
        when "111" => DOUT <= memSignal(7);
        when others => null;
    end case;
end if;        
end process;
end Behavioral;
