library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity memorie_ROM is
	port(A_ROM: in std_logic_vector(3 downto 0);  
	enable_memorie: in std_logic;
	D_ROM: out std_logic_vector(15 downto 0));
end memorie_ROM;

 

architecture memorie_ROM of memorie_ROM is	 
type MEMORIE is array (0 to 4)	of std_logic_vector (15 downto 0);
signal M:MEMORIE:=(x"104C",x"10B4",x"1469",x"14AA",x"10FC");
begin 
	process(A_ROM,enable_memorie)
	begin 
		if(enable_memorie='1')then
			case A_ROM is
				when x"0" => D_ROM <= M(0);
				when x"1" => D_ROM <= M(1);
				when x"2" => D_ROM <= M(2);
				when x"3" => D_ROM <= M(3);
				when x"4" => D_ROM <= M(4);
				when others => D_ROM <= x"0000";
			end case;
		else 
			D_ROM <= x"0000";
		end if;
	end process;
end architecture;