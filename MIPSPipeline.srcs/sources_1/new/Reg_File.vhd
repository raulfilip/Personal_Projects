library IEEE;
use IEEE.STD_LOGIC_1164.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL;	   
use IEEE.NUMERIC_STD.ALL;

entity Reg_File is
	port (
		clk : in std_logic;
		ra1 : in std_logic_vector (2 downto 0); --adresa de citire
		ra2 : in std_logic_vector (2 downto 0); --adresa de citire
		wa : in std_logic_vector (2 downto 0); -- adresa de scriere
		wd : in std_logic_vector (7 downto 0); -- adresa de scriere
		wen : in std_logic; -- intrare de activare a scrierii
		MPG_EN:in std_logic;
		rd1 : out std_logic_vector (7 downto 0); -- iesire de date de citire
		rd2 : out std_logic_vector (7 downto 0)
);
end Reg_File;	

architecture Behavioral of Reg_File is
	type reg_array is array (0 to 7) of std_logic_vector(7 downto 0);
	signal reg_file : reg_array;	-- pentru a stoca valorile reg   
	
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if wen = '1' then
			if(MPG_EN='1') then
				reg_file(conv_integer(wa)) <= wd;
				end if;
		end if;
	end if;
end process;
		rd1 <= reg_file(conv_integer(ra1));
		rd2 <= reg_file(conv_integer(ra2));
end Behavioral;