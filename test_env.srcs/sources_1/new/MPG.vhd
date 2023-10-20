library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MPG is
    Port ( en : out STD_LOGIC;
           btn : in STD_LOGIC;
           clk : in STD_LOGIC);
end MPG;

architecture Behavioral of MPG is

signal count_int : STD_LOGIC_VECTOR (17 downto 0) := (others => '0');
signal Q1 : STD_LOGIC := '0';
signal Q2 : STD_LOGIC := '0';
signal Q3 : STD_LOGIC := '0';

begin

    en <= Q2 AND (not Q3);

    process (clk)
    begin
        if clk='1' and clk'event then
            count_int <= count_int + 1;
        end if;
    end process;

    process (clk)
    begin
        if clk'event and clk='1' then
            if count_int(17 downto 0) = "111111111111111111" then
                Q1 <= btn;
            end if;
        end if;
    end process;

    process (clk)
    begin
        if clk'event and clk='1' then
            Q2 <= Q1;
            Q3 <= Q2;
        end if;
    end process;

end architecture;