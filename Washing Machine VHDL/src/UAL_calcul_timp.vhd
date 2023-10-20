---------------------------------------------------------------------------------------------------
--
-- Title       : UAL_calcul_timp
-- Design      : Masina_de_spalat
-- Author      : User
-- Company     : Utcn
--
---------------------------------------------------------------------------------------------------
--
-- File        : UAL_calcul_timp.vhd
-- Generated   : Sat May  7 18:03:43 2022
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
--{entity {UAL_calcul_timp} architecture {UAL_calcul_timp}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity UAL_calcul_timp is 
	port( CS,Presp : std_logic;
	TEMP : in integer;
	TIMPU,TIMPZ : out integer;
	iprm,ispm,iclm,icsm,icem: out integer
	);
end UAL_calcul_timp;

--}} End of automatically maintained section

architecture UAL_calcul_timp of UAL_calcul_timp is 
begin 
	process(CS,PRESP,TEMP) is 
	variable TIMP_TOTAL,tpr,tsp,tcl,tcs,tce,tt,var1:integer;
	begin 
		TIMP_TOTAL:=40;
		case TEMP is
				when 30 => TIMP_TOTAL:=TIMP_TOTAL+1 ;
				when 40 => TIMP_TOTAL:=TIMP_TOTAL+1  ;
				when 60 => TIMP_TOTAL:=TIMP_TOTAL+2	;
				when 90 => TIMP_TOTAL:=TIMP_TOTAL+3	 ;
				when others => TIMP_TOTAL := 40;
		end case;
		tsp:=timp_total-20;
		if PRESP='1' then
			TIMP_TOTAL:=TIMP_TOTAL+10;
			case TEMP is
				when 30 => TIMP_TOTAL:=TIMP_TOTAL+1 ;
				when 40 => TIMP_TOTAL:=TIMP_TOTAL+1  ;
				when 60 => TIMP_TOTAL:=TIMP_TOTAL+2	;
				when 90 => TIMP_TOTAL:=TIMP_TOTAL+3	 ;
				when others => TIMP_TOTAL := 40;
		end case; 
		tpr:=tsp-10;
		else
			tpr:=0;
		end if;
		if CS='1' then
			TIMP_TOTAL:=TIMP_TOTAL+10;
			tcs:=10;
		else
			tcs:=0;
		end if;
		tce:=10;
		tcl:=10;
		TIMPU<=TIMP_TOTAL MOD 10;
		TIMPZ<=TIMP_TOTAL/10;
		tt:=0;
		tce:=tce+tt;
		tcs:=tcs+tce;
		tcl:=tcs+tcl;
		tsp:=tcl+tsp;
		tpr:=tsp+tpr;
		icem<=tce;
		ispm<=tsp;
		icsm<=tcs;
		iclm<=tcl;
		iprm<=tpr;
		end process;

	 -- enter your statements here --

end UAL_calcul_timp;
