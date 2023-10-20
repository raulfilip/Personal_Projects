---------------------------------------------------------------------------------------------------
--
-- Title       : afisor_7_segmente
-- Design      : Masina_de_spalat
-- Author      : User
-- Company     : Utcn
--
---------------------------------------------------------------------------------------------------
--
-- File        : afisor_7_segmente.vhd
-- Generated   : Thu May 19 21:37:35 2022
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
--{entity {afisor_7_segmente} architecture {afisor_7_segmente}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity afisor_7_segmente is
	port(clock:in std_logic; 
	timpUNITATI,timpZECI:in std_logic_vector(3 downto 0); 
	vectorANOZI:out std_logic_vector(3 downto 0); 
	vectorCATOZI: out std_logic_vector(6 downto 0)
	);
end afisor_7_segmente;

--}} End of automatically maintained section

architecture afisor_7_segmente of afisor_7_segmente is 

component mux_catozi is 
	port(sel2: in std_logic_vector (1 downto 0);
	timp_U1,timp_z1: in std_logic_vector(3 downto 0);
	iesire:out std_logic_vector(3 downto 0)
	);
end component mux_catozi;

component mux_anozi is
	port(sel1: in std_logic_vector(1 downto 0);
	anozi: out std_logic_vector(3 downto 0));
end component mux_anozi;

component decodificator_bcd is
	port(a1: in std_logic_vector (3 downto 0);
	catozi: out std_logic_vector(6 downto 0)
	);
end component  decodificator_bcd;

component numarator_16_biti is
	port( A2:in std_logic_vector(15 downto 0); 
	eneable2: in std_logic;
	clk2: in std_logic;
	pl2,reset2: in std_logic;
	tc2:out std_logic;  
	Q2:out std_logic_vector(15 downto 0)
	);
end component numarator_16_biti;
signal selectii_mux: std_logic_vector(1 downto 0);
signal sf_num:  std_logic;
signal iesire_numarator:   std_logic_vector(15 downto 0);
signal numar_codificat:std_logic_vector(3 downto 0);
begin
	V1:numarator_16_biti port map("0000000000000000",'1',clock,'0','0',sf_num,iesire_numarator);
	selectii_mux(1 downto 0)<=iesire_numarator(1 downto 0);
	v2:mux_anozi port map(selectii_mux,vectorANOZI); 
	v3:mux_catozi port map(selectii_mux,timpUNITATI,timpZECI,numar_codificat);
	v4:decodificator_bcd port map(numar_codificat,vectorCATOZI);
	 -- enter your statements here --

end afisor_7_segmente;
