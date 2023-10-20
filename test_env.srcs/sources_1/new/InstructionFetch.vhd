----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2023 04:13:34 PM
-- Design Name: 
-- Module Name: InstructionFetch - Behavioral
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

entity InstructionFetch is
    Port ( JumpAdress : in STD_LOGIC_VECTOR (15 downto 0);
           BranchAdress : in STD_LOGIC_VECTOR (15 downto 0);
           Jump : in STD_LOGIC;
           Clk : in STD_LOGIC;
           PcSrc : in STD_LOGIC;
           MPGenable: in std_logic;
           PcPlus1 : out STD_LOGIC_VECTOR (15 downto 0);
           reset: in std_logic;
           Instruction : out STD_LOGIC_VECTOR (15 downto 0));
end InstructionFetch;

architecture Behavioral of InstructionFetch is
 signal Pc : STD_LOGIC_VECTOR (15 downto 0):= "0000000000000000";
 signal Pc1 : STD_LOGIC_VECTOR (15 downto 0):= "0000000000000000";
 signal exitmux1 : STD_LOGIC_VECTOR (15 downto 0):= "0000000000000000";
 signal exitmux2 : STD_LOGIC_VECTOR (15 downto 0):= "0000000000000000";
 type ROM is array(0 to 31 )of STD_LOGIC_VECTOR (15 downto 0);
 signal data: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
 signal rom_mem: ROM := (
     "0000000000000001",
     "0000000000000010",
     "0000000000000011",
     "0000000000000100",
     "0000000000000101",
     "0000000000000110",
     "0000000000000111",
     "0000000000001000",
     others => "0000000000000000"
 );
begin



	process(clk,reset,Mpgenable) 
	begin 								 
		if reset = '1' then 
			PCplus1 <= (others => '0') ; 
		elsif clk'event and clk = '1' then 
			if Mpgenable = '1' then 
				Pc1 <= Pc + 1;
            PcPlus1 <= Pc1;  
			end if ;
		end if ;
	end process; 


Mux1:process(Pc1,PcSrc)
begin
case PcSrc is
            when '0' =>
                exitmux1 <= Pc1;
            when others =>
            exitmux1 <=BranchAdress;
    end case;
end process;

Mux2:process(exitmux1,Jump)
begin
case Jump is
            when '0' =>
                exitmux2 <= exitmux1;
            when others =>
            exitmux2 <=JumpAdress;
    end case;
end process;
process(exitmux2,clk)
begin
if (clk'event and clk='1') then
    Pc<=exitmux2;
end if;
end process;

MemRom:process(Pc)
begin
data<=rom_mem(conv_integer(Pc));
end process;
end Behavioral;
