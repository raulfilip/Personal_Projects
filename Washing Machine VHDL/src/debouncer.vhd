library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity debouncer is
	port(BTN:in std_logic;
		CLK:in std_logic;
		R:in std_logic;
		BTN_NOU:out std_logic);
end entity;				 

architecture debouncer of debouncer is
signal n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12: std_logic;
begin	
	process(CLK,R)
	begin
		if r='1' then  
			n1<='0'; 
			n2<='0';
			n3<='0';
			n4<='0';
			n5<='0';
			n6<='0';  
			n7<='0'; 
			n8<='0';
			n9<='0';
			n10<='0';	
			n11<='0';
			n12<='0';
		elsif CLK='1' and CLK'event then
			n1<=BTN; 
			n2<=n1;
			n3<=n2;
			n4<=n3;
			n5<=n4;	   
			n6<=n5;  
			n7<=n6; 
			n8<=n7;
			n9<=n8;
			n10<=n9;  	  
			n11<=n10;
			n12<=n11;
		end if;
	end	 process;
	BTN_NOU<= n1 and n2 and n3 and n4 and n5 and n6 and n7 and n8 and n9 and n10 and  n11 and n12;
end architecture;	