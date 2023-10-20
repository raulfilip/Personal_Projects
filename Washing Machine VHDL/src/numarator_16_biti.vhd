---------------------------------------------------------------------------------------------------
--
-- Title       : numarator_2bit
-- Design      : colocviu
-- Author      : Andreea
-- Company     : asdt
--
---------------------------------------------------------------------------------------------------
--
-- File        : numarator_2bit.vhd
-- Generated   : Sun May 15 02:19:59 2022
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
---------------------------------------------------------------------------------------------------
--
-- Description : 
--
---------------------------------------------------------------------------------------------------
 
--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {numarator_2bit} architecture {numarator_2bit}}
 
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity numarator_16_biti is
	port( A2:in std_logic_vector(15 downto 0); 
	eneable2: in std_logic;
	clk2: in std_logic;
	pl2,reset2: in std_logic;
	tc2:out std_logic;  
	Q2:out std_logic_vector(15 downto 0)
	);
end numarator_16_biti;
 
--}} End of automatically maintained section
 
architecture numarator_16_biti of numarator_16_biti is
signal nr2:std_logic:='1';	
signal tc3: std_logic:='1';
begin
	process(clk2,reset2)
	variable count2:std_logic_vector(15 downto 0);
 
	begin
		if(tc3='1') then
	if(nr2='1') then
		count2:="0000000000000000";
		nr2<='0'; 
	end if ; 
	if(count2="1111111111111111") then
		   tc2<='0';
		end if;
		if reset2='1' then
			count2:="0000000000000000";
		elsif pl2='1' then
			count2:=A2;
		elsif(clk2'event and clk2='1') then
			count2:=count2+1; 

 
 
		   else count2:=count2;
		end if;
		end if;
		Q2<=count2; 
 
		end process;
 
 
	 -- enter your statements here --
 
end numarator_16_biti;