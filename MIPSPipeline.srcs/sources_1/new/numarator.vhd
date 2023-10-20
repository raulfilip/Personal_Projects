library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lab1_3 is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end lab1_3;

architecture Behavioral of lab1_3 is

component MPG is
	port ( en : out STD_LOGIC;
           input : in STD_LOGIC;
           clock : in STD_LOGIC);
end component;

component afisor_7_segmente is
    Port ( clk : in STD_LOGIC;
           digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal ce : STD_LOGIC;
signal cnt : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

begin
    
    monopulse: MPG port map(ce, btn(0), clk);
    counter : process (clk) 
    begin
        if rising_edge(clk) then
            if ce = '1' then
                if sw(0) = '1' then   
                    cnt <= cnt + 1;
                else
                    cnt <= cnt - 1;
                end if;
            end if;
        end if;
    end process;
     afisor_7segmente: afisor_7_segmente port map(clk,cnt(15 downto 11),cnt(11 downto 7),cnt(7 downto 3),cnt(3 downto 0),an,cat);
    led <= cnt;
    an <= btn(3 downto 0);
    cat <= (others=>'0');    

end Behavioral;