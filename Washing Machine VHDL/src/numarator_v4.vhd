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
 
entity numarator is
	port( A:in std_logic_vector(3 downto 0); 
	B:in std_logic_vector(3 downto 0);
	enable: in std_logic;
	clk: in std_logic;
	pl,reset: in std_logic;
	tc:out std_logic;  
	Q1:out std_logic_vector(3 downto 0);
	Q:out std_logic_vector(3 downto 0);
	deschidere_usa: out std_logic
	);
end numarator;
 
--}} End of automatically maintained section
 
architecture numarator of numarator is
signal nr:std_logic:='1';	
signal tc1: std_logic:='1';
begin
	process(clk,reset,enable)
	variable count:std_logic_vector(3 downto 0);
	variable count1:std_logic_vector(3 downto 0);
 
	begin 
		if (enable='1')	then
		if(tc1='1') then
	if(nr='1') then
		count:=A;
		 count1:=B;
		nr<='0'; 
	end if ; 
	if(count="1001") then
		   tc<='0';
		end if;
		if reset='1' then
			count:="1001";
		elsif pl='1' then
			count:=A;
		elsif(clk'event and clk='1') then
			count:=count-1; 
 
		elsif count="0000" and count1="0000" then
			Q<="0000"; 
			Q1<="0000";
			tc1<='0';
			   
			deschidere_usa<='1';
		
 
		elsif(count="0000") then
			count:="1001";
			count1:=count1-1;
 
 
		   else count:=count;
		end if;
		end if;
		end if;
		Q<=count; 
		Q1<=count1;
 		
 		  end process;
		
 
	 -- enter your statements here --
 
end numarator;