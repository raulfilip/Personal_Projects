library IEEE;
use IEEE.STD_LOGIC_1164.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL;	   
use IEEE.NUMERIC_STD.ALL;

entity InstructionDecode is
	Port(RegWrite : in std_logic ;
	     Instr : in std_logic_vector(15 downto 0) ; 
		 RegDst : in std_logic ; 	  
		 ExtOp : in std_logic ; 
		 RD1 : out std_logic_vector(15 downto 0) ;
		 RD2 : out std_logic_vector(15 downto 0) ;		 
		 WD : in std_logic_vector(15 downto 0) ;
		 clk : in std_logic ; 					   
		 enableMPG : in std_logic ;
		 Ext_Imm : out std_logic_vector(15 downto 0) ;
		 func : out std_logic_vector(2 downto 0);
		 sa : out std_logic
		 );
end entity ; 

architecture Behavioral of InstructionDecode is  

component reg_file is
	port (
		clk : in std_logic;
		ra1 : in std_logic_vector (2 downto 0);
		ra2 : in std_logic_vector (2 downto 0);
		wa : in std_logic_vector (2 downto 0);
		wd : in std_logic_vector (15 downto 0);
		wen : in std_logic;	 
		RegWrite : in std_logic ;
		rd1 : out std_logic_vector (15 downto 0);  
		rd2 : out std_logic_vector (15 downto 0)
         );
end component reg_file;

	signal swa : std_logic_vector(2 downto 0);
	signal sra1, sra2 : std_logic_vector(2 downto 0); 
begin		
	
	C1: reg_file port map(
	                     clk => clk,
						 ra1 => sra1, 
						 ra2 =>	sra2, 
						 wa  =>	swa,
						 wd  => WD,
						 wen =>	RegWrite,  
						 RegWrite => enableMPG,
						 rd1 => RD1,
						 rd2 => RD2
						  );
	
	sra1 <= Instr(12 downto 10); 
	sra2 <= Instr(9 downto 7); 
	
	func <= Instr(2 downto 0);
	sa <= Instr(3) ;   
	
	process(ExtOp)
	begin
		if ExtOp = '1' then 
			-- extensie cu semn 
			Ext_Imm	<=       Instr(6) & Instr(6) & Instr(6) & Instr(6) & Instr(6) & Instr(6) & Instr(6) & Instr(6) & Instr(6) & Instr(6 downto 0); 
	    else 
			-- ext fara semn 	 
			Ext_Imm	<= "0000000000" & Instr(6 downto 0) ;
		end if ; 
    end process;  	
	
	process(RegDst)
	begin
	   if RegDst = '1' then
		   swa <= Instr(9 downto 7) ; 
	   else
		   swa <= Instr(6 downto 4);
	   end if;
	end process; 
	
end Behavioral ;