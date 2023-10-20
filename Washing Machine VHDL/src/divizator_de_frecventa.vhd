library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity divizor_de_frecventa is
    Port ( clk_100: in std_logic;
	Y:out std_logic);
end divizor_de_frecventa;
 
architecture divizor_de_frecventa of divizor_de_frecventa is
signal ok:std_logic:='1';
begin
	process(clk_100)
variable nr: integer;
variable one_second_enable: std_logic;	

begin  
	if(ok='1')then
		one_second_enable:='0';
		ok<='0';
		nr:=1;
		end if;
	if (clk_100'event and clk_100='1') then
		nr:=nr+1;
	if (nr = 50) then
		nr:=1;
		
		one_second_enable:=not(one_second_enable); 
	end if;
	end if;
	y<=one_second_enable;
		end process;
    
end divizor_de_frecventa;