----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/10/2023 04:40:14 PM
-- Design Name: 
-- Module Name: afisor_7_segmente - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity afisor_7_segmente is
    Port ( clk : in STD_LOGIC;
           digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end afisor_7_segmente;

architecture Behavioral of afisor_7_segmente is
signal  selectie : STD_LOGIC_VECTOR(1 downto 0):= (others => '0');
signal  count : STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
signal  fir1 : STD_LOGIC_VECTOR(3 downto 0):= (others => '0');
begin

mux_catozi: process(selectie, digit0, digit1, digit2, digit3)

begin
 case selectie is
 when "00" => fir1 <= digit0;
 when "01" => fir1 <= digit1;
 when "10" => fir1 <= digit2;
 when others => fir1 <= digit3;
 end case;
end process;

numarator: process (clk)
begin
 if rising_edge(clk) then
      count <= count + 1;
  end if;
    selectie <=count(1 downto 0);
end process;


mux_anozi: process(selectie)
begin
 case selectie is
 when "00" => an <= "1110";
 when "01" => an <= "1101";
 when "10" => an <= "1011";
 when others => an <= "0111";
 end case;
end process;


--HEX-to-seven-segment decoder
--   HEX:   in    STD_LOGIC_VECTOR (3 downto 0);
--   LED:   out   STD_LOGIC_VECTOR (6 downto 0);
--
-- segment encoinputg
--      0
--     ---
--  5 |   | 1
--     ---   <- 6
--  4 |   | 2
--     ---
--      3

    with fir1 SELect
   cat<= "1111001" when "0001",   --1
         "0100100" when "0010",   --2
         "0110000" when "0011",   --3
         "0011001" when "0100",   --4
         "0010010" when "0101",   --5
         "0000010" when "0110",   --6
         "1111000" when "0111",   --7
         "0000000" when "1000",   --8
         "0010000" when "1001",   --9
         "0001000" when "1010",   --A
         "0000011" when "1011",   --b
         "1000110" when "1100",   --C
         "0100001" when "1101",   --d
         "0000110" when "1110",   --E
         "0001110" when "1111",   --F
         "1000000" when others;   --0


				
				

end Behavioral;
