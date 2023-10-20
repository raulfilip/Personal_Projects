
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Lab2_2ALU is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end Lab2_2ALU;

architecture Behavioral of Lab2_2ALU is

component MPG is
    Port ( en : out STD_LOGIC;
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
signal cnt: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
signal add, sub, lsl, lsr, digits: STD_LOGIC_VECTOR(15 downto 0);

begin

    monopulse: MPG port map(ce, btn(0), clk);

    counter : process (clk)
    begin
        if rising_edge(clk) then
            if ce = '1' then
                cnt <= cnt + 1;
            end if;
        end if;
    end process;

    add <= ("000000000000" & sw(3 downto 0)) + ("000000000000" & sw(7 downto 4)); 
    sub <= ("000000000000" & sw(3 downto 0)) - ("000000000000" & sw(7 downto 4));
    lsl <= "000000" & sw(7 downto 0) & "00";
    lsr <= "0000000000" & sw(7 downto 2);
    
    mux : process (cnt, add, sub, lsl, lsr)
    begin
        case cnt is
            when "00" => digits <= add;
            when "01" => digits <= sub;
            when "10" => digits <= lsl;
            when "11" => digits <= lsr;
            when others => digits <= (others => 'X');
        end case;
    end process;

    display : afisor_7_segmente port map (clk, digits(3 downto 0),digits(7 downto 4),digits(11 downto 8),digits(15 downto 12), an, cat);
        
    led(7) <= '1' when digits = 0 else '0';
    
end Behavioral;