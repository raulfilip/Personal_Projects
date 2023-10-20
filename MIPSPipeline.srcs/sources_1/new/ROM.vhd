
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
 Port (
             intrare : in STD_LOGIC_VECTOR (4 downto 0);
             iesire : out STD_LOGIC_VECTOR (15 downto 0));
end ROM;

architecture Behavioral of ROM is
type ROM is array(0 to 31 )of STD_LOGIC_VECTOR (15 downto 0);
signal data: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
signal rom_mem: ROM := (
    "0000000000010001",
    "001000100000101",
    "0000000000100001",
    "0000000001010001",
    "100001100000101",
    "010010011101000",
    "0001010111010001",
    "001010010000100",
    "001001001000010",
    "1110000000000100",
    "011000101111100",
    others => "0000000000000000"
);
begin
data<=rom_mem(conv_integer(intrare));


end Behavioral;
