library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DataMemory is
	Port (  clk          : in std_logic;
			ALURes       : in std_logic_vector(15 downto 0)  ;
			WriteData    : in std_logic_vector(15 downto 0)  ;
			MemWrite     : in std_logic;			
			MemWriteCtrl : in std_logic;	
			MemData      : out std_logic_vector(15 downto 0) ;
			ALURes2      : out std_logic_vector(15 downto 0));
end entity;

architecture Behavioral of DataMemory is

signal Address: std_logic_vector(3 downto 0);

type ram_type is array (0 to 15) of std_logic_vector(15 downto 0);
signal RAM:ram_type:=(
		X"0001",
		X"0002",
		X"0004",
		X"0008",
		X"0012",
		X"000A",
		X"000B",
		X"000C",		
		others =>X"0000");

begin

Address <= ALURes(3 downto 0);

process(clk) 			
begin
	if(rising_edge(clk)) then
		if MemWriteCtrl = '1' then
			if MemWrite = '1' then
				RAM(conv_integer(Address)) <= WriteData;			
			end if;
		end if;	
	end if;
	MemData <= RAM(conv_integer(Address));
end process;
	
ALURes2 <= ALURes;

end Behavioral;