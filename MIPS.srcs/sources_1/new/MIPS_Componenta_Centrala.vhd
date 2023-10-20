----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2023 04:49:11 PM
-- Design Name: 
-- Module Name: MIPS_Componenta_Centrala - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;	   
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MIPS_Componenta_Centrala is
 Port (clk : in  STD_LOGIC;
           btn : in  STD_LOGIC_VECTOR (4 downto 0) ;
           sw  : in  STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an  : out STD_LOGIC_VECTOR (3 downto 0) ;
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end MIPS_Componenta_Centrala;

architecture Behavioral of MIPS_Componenta_Centrala is
component UEX is
  Port (
           rd1 : in STD_LOGIC_vector(15 downto 0);
           rd2 : in STD_LOGIC_VECTOR (15 downto 0);
           aluOp : in STD_LOGIC_VECTOR(2 downto 0);
           aluSrc : in STD_LOGIC;
          ext_imm: in STD_LOGIC_VECTOR (15 downto 0);
          sa:in STD_LOGIC;
          func:in STD_LOGIC_VECTOR(2 downto 0); 
          zero:out STD_LOGIC;
          PC: in STD_LOGIC_VECTOR (15 downto 0);
          BranchRes: out STD_LOGIC_VECTOR (15 downto 0);
          aluRes:out STD_LOGIC_VECTOR (15 downto 0));

end component;

component UC is
 Port (
    Instr: in std_logic_vector(2 downto 0);
    RegDst : out std_logic;
    ExtOp : out std_logic;
    ALUSrc : out std_logic;
    Branch : out std_logic;
    Jump : out std_logic;
    ALUOp : out STD_LOGIC_VECTOR(2 downto 0);
    MemWrite : out std_logic;
    MemtoReg : out std_logic;
    Regwrite : out std_logic
  );
  end component;
  
  component ROM is
   Port (
               intrare : in STD_LOGIC_VECTOR (4 downto 0);
               iesire : out STD_LOGIC_VECTOR (15 downto 0));
  end component;
  
  component InstructionFetch is
      Port ( JumpAdress : in STD_LOGIC_VECTOR (15 downto 0);
             BranchAdress : in STD_LOGIC_VECTOR (15 downto 0);
             Jump : in STD_LOGIC;
             Clk : in STD_LOGIC;
             PcSrc : in STD_LOGIC;
             MPGenable: in std_logic;
             PcPlus1 : out STD_LOGIC_VECTOR (15 downto 0);
             reset: in std_logic;
             Instruction : out STD_LOGIC_VECTOR (15 downto 0));
  end component InstructionFetch;
  
  component DataMemory is
      Port (  clk          : in std_logic;
              ALURes       : in std_logic_vector(15 downto 0)  ;
              WriteData    : in std_logic_vector(15 downto 0)  ;
              MemWrite     : in std_logic;            
              MemWriteCtrl : in std_logic;    
              MemData      : out std_logic_vector(15 downto 0) ;
              ALURes2      : out std_logic_vector(15 downto 0));
  end component;
  
  component InstructionDecode is
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
  end component ; 
  
  component Reg_File is
      port (
          clk : in std_logic;
          ra1 : in std_logic_vector (2 downto 0); --adresa de citire
          ra2 : in std_logic_vector (2 downto 0); --adresa de citire
          wa : in std_logic_vector (2 downto 0); -- adresa de scriere
          wd : in std_logic_vector (7 downto 0); -- adresa de scriere
          wen : in std_logic; -- intrare de activare a scrierii
          MPG_EN:in std_logic;
          rd1 : out std_logic_vector (7 downto 0); -- iesire de date de citire
          rd2 : out std_logic_vector (7 downto 0)
  );
  end component;
  
  component afisor_7_segmente is
      Port ( clk : in STD_LOGIC;
             digit0 : in STD_LOGIC_VECTOR (3 downto 0);
             digit1 : in STD_LOGIC_VECTOR (3 downto 0);
             digit2 : in STD_LOGIC_VECTOR (3 downto 0);
             digit3 : in STD_LOGIC_VECTOR (3 downto 0);
             an : out STD_LOGIC_VECTOR (3 downto 0);
             cat : out STD_LOGIC_VECTOR (6 downto 0));
  end component;
  
  component MPG is
      Port ( en : out STD_LOGIC;
             btn : in STD_LOGIC;
             clk : in STD_LOGIC);
  end component MPG;
  
  component Lab2_2ALU is
      Port ( clk : in STD_LOGIC;
             btn : in STD_LOGIC_VECTOR (4 downto 0);
             sw : in STD_LOGIC_VECTOR (15 downto 0);
             led : out STD_LOGIC_VECTOR (15 downto 0);
             an : out STD_LOGIC_VECTOR (3 downto 0);
             cat : out STD_LOGIC_VECTOR (6 downto 0));
  end component Lab2_2ALU;
  
signal MemtoReg : std_logic;	  
  signal RegWrite : std_logic;
  signal Jump     : std_logic;              
  signal Branch   : std_logic;
  signal ALUSrc   : std_logic;  
  signal ALUOp    : std_logic_vector(2 downto 0);     
  signal MemWrite : std_logic;
  signal RegDst   : std_logic; 
  signal ExtOp    : std_logic;
  
  signal enable        : STD_LOGIC;                                   
  signal reset         : STD_LOGIC;                                    
  signal BranchAddress : std_logic_vector(15 downto 0);          
  signal JumpAddress   : std_logic_vector(15 downto 0);             
  signal SSDout        : std_logic_vector(15 downto 0) := X"0000";   
  signal Instr         : std_logic_vector(15 downto 0);                
  signal PCout         : std_logic_vector(15 downto 0);                     
  signal ALURes        : std_logic_vector(15 downto 0);                
  signal ZeroSignal    : std_logic;                                
  signal RD1           : std_logic_vector(15 downto 0);                     
  signal RD2           : std_logic_vector(15 downto 0);                    
  signal Ext_Imm       : std_logic_vector(15 downto 0);                
  signal Func          : std_logic_vector(2 downto 0) ;                    
  signal SA            : std_logic;                                        
  signal MemData       : std_logic_vector(15 downto 0);                
  signal ALUResFinal   : std_logic_vector(15 downto 0);            
  signal WriteDataReg  : std_logic_vector(15 downto 0);            
  signal PCSrc         : std_logic;
  signal enableMPG     : std_logic;
  
  begin
      
      C1: MPG port map(
                      en  => enable, 
                      btn => btn(0), 
                      clk => clk
                      );      
                      
      C2: MPG port map(
                      en  => reset, 
                      btn => btn(1), 
                      clk => clk
                      );
      
      C4:    InstructionFetch port map(
                       clk           => clk        ,
                       Instruction  => Instr      ,
                       PCplus1     => PCout      ,
                       jump          => Jump       ,
                       PCsrc         => sw(1)     ,
                       JumpAdress   => x"0000", 
                       BranchAdress => x"0004",
                       MPGenable           => enable,
                       reset         => reset
                       );
      
      C5: InstructionDecode port map(
                       RegWrite  => RegWrite    ,
                       Instr     => Instr       ,
                       RegDst    => RegDst      ,
                       ExtOp     => ExtOp       ,
                       RD1       => RD1         ,
                       RD2       => RD2         ,
                       WD        => WriteDataReg,
                       clk       => clk         ,
                       enableMPG => enableMPG   , 
                       Ext_Imm   => Ext_Imm     , 
                       func      => Func        , 
                       sa        => SA
                       );
      
      C6: UC port map(
                       Instr   => Instr(15 downto 13),
                       RegDst   => RegDst             ,
                       ExtOp    => ExtOp              ,                
                       ALUsrc   => ALUSrc             ,
                       Branch   => Branch             , 
                       Jump     => Jump               , 
                       ALUop    => ALUOp              , 
                       MemWrite => MemWrite           , 
                       MemtoReg => MemtoReg           , 
                       RegWrite => RegWrite
                       );
      
      C7:    DataMemory    port map(
                       clk          => clk     ,
                       ALURes       => ALURes  ,
                       WriteData    => RD2     ,
                       MemWrite     => MemWrite,
                       MemWriteCtrl => enable  , 
                       MemData      => MemData ,
                       ALURes2      => ALUResFinal
                       );
              
      C8: UEX port map(
                       RD1        => RD1       ,
                       RD2        => RD2       ,
                       Ext_Imm    => Ext_Imm   ,
                       sa         => enable    ,
                       func       => Func      , 
                       ALUOp      => ALUOp     ,
                       ALUSrc     => ALUSrc    ,
                       Zero       => ZeroSignal,
                       ALURes     => ALURes    , 
                       PC         => PCOut     , 
                       BranchRes => BranchAddress
                       );
                       
      process(MemtoReg,ALUResFinal,MemData) 
      begin
          case (MemtoReg) is
              when '1'    => WriteDataReg <= MemData     ;
              when '0'    => WriteDataReg <= ALUResFinal ;
              when others => WriteDataReg <= WriteDataReg;
          end case;
      end process;
  
      PCSrc       <= ZeroSignal and Branch;
      JumpAddress <= PCOut(15 downto 14) & Instr(13 downto 0);
  
      process(Instr,PCout,RD1,RD2,Ext_Imm,ALURes,MemData,WriteDataReg,sw)
      begin
          case(sw(7 downto 5)) is
              when "000" =>
                      SSDOut <= Instr;            
              when "001" =>
                      SSDOut <= PCout;                
              when "010" =>
                      SSDOut <= RD1;                
              when "011" =>
                      SSDOut <= RD2;                
              when "100" =>
                      SSDOut <= Ext_Imm;            
              when "101" =>
                      SSDOut <= ALURes;                    
              when "110" =>
                      SSDOut <= MemData;            
              when "111" =>
                      SSDOut <= WriteDataReg;    
              when others =>
                      SSDOut <= X"0000";
          end case;
      end process; 
      
          C3: afisor_7_segmente port map(
                       clk  => clk   ,
                       digit0 => SSDout(15 downto 12),
                       digit1 => SSDout(11 downto 8),
                       digit2 => SSDout(7 downto 4),
                       digit3 => SSDout(3 downto 0),
                       an     => an    ,
                       cat    => cat
                       );
  
      process(RegDst,ExtOp,ALUSrc,Branch,Jump,MemWrite,MemtoReg,RegWrite,sw,ALUOp)
      begin
          if sw(0) = '0' then        
              led(7) <= RegDst  ; 
              led(6) <= ExtOp   ;
              led(5) <= ALUSrc  ;
              led(4) <= Branch  ;
              led(3) <= Jump    ;
              led(2) <= MemWrite;
              led(1) <= MemtoReg;
              led(0) <= RegWrite;        
          else
              led(2 downto 0) <= ALUOp(2 downto 0);
              led(7 downto 3) <= "00000";
          end if;
      end process;
end Behavioral;