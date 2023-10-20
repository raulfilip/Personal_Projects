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
  signal BranchAddress,wdfinal : std_logic_vector(15 downto 0);          
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
  signal wa : std_logic_vector(2 downto 0);        
  signal PCSrc         : std_logic;
  signal enableMPG     : std_logic;
   signal RegIFID : std_logic_vector(31 downto 0);
     --Pc+1(15 downto 0)
     --Instr(15 downto 0)
 --total 32
 
signal RegIDEX : std_logic_vector(82 downto 0);
    -- Alt Pc+1(15 downto 0)
     --RD1(15 downto 0)
     --RD2(15 downto 0)
     --MemWrite: 1
     --MemtoReg: 1
     --RegWrite: 1
     --Branch: 1
     --ALUOp:(2 downto 0)
     --ALUSrc: 1
     --RegDst: 1
     --ExtImm: (15 downto 0)
     --func:(2 donwnto 0) 
     --sa: 1
     --rt 3
     --rd 3
 --total 83
         
 signal RegExMEM : std_logic_vector(55 downto 0);
    -- MemtoReg: 1
     --RegWrite: 1
     --MemWrite: 1
     --Branch: 1
     --BranchAddress: (15 downto 0)
     --zero: 1
     --ALURes: (15 downto 0)
     --RD2: (15 downto 0)
     --WA: (3 downto 0)
 --total 56
 
 signal RegMEMWB : std_logic_vector(36 downto 0);
 --Reg4: MEM/WB
   --  MemtoReg: 1
    -- RegWrite: 1
     --MemData: (15 downto 0)
     --ALURes: (15 downto 0)
     --WA: (3 downto 0)
 --total 37
  
  begin
     --ok 
      C1: MPG port map(
                      en  => enable, 
                      btn => btn(0), 
                      clk => clk
                      );      
    --ok                  
      C2: MPG port map(
                      en  => reset, 
                      btn => btn(1), 
                      clk => clk
                      );
      
      
      --  ok
      C4:    InstructionFetch port map(
                       clk           => clk        ,
                       Instruction  => Instr      ,
                       PCplus1     => PCout      ,
                       jump          => Jump       ,
                       PCsrc         => sw(1)     ,
                       JumpAdress   => jumpaddress, 
                       BranchAdress =>Regexmem(51 downto 36),
                       MPGenable           => enable,
                       reset         => reset
                       );
                       
                          
                                
                           
                                 
                                 
                                  
                       
                       
                                 
                                    
      --ok                           
                                   
      C5: InstructionDecode port map(
                       RegWrite  => Regmemwb(35)   ,
                       Instr     =>  Regifid(15downto 0)    ,
                       RegDst    => RegDst      ,
                       ExtOp     => ExtOp       ,
                       RD1       => RD1         ,
                       RD2       => RD2         ,
                       WD        => wdfinal,
                       clk       => clk         ,
                       enableMPG => enableMPG   , 
                       Ext_Imm   => Ext_Imm     , 
                       func      => Func        , 
                       sa        => SA
                       );
                       
                         
                                      
                              
                                                       
                               
                               
                          
   --ok
      C6: UC port map(
                       Instr   => regifid(15 downto 13),
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
     
      --ok
      C7:    DataMemory    port map(
                       clk          => clk     ,
                       ALURes       => Regexmem(34 downto 19) ,
                       WriteData    =>Regexmem(18 downto 3)    ,
                       MemWrite     => RegExMEM(53),
                       MemWriteCtrl => enable  , 
                       MemData      => MemData ,
                       ALURes2      => ALUResFinal
                       );
                           
                           --ok       
      C8: UEX port map(
                                       
                       RD1        => Regidex(66 downto 51)     ,
                       RD2        =>  Regidex(50 downto 35)       ,
                       Ext_Imm    => Regidex(25 downto 10 ) ,
                       sa         => Regidex(6)    ,
                       func       =>  Regidex(9 downto 7)     , 
                       ALUOp      => Regidex(30 downto 28)    ,
                       ALUSrc     => Regidex(27)   ,
                       Zero       => ZeroSignal,
                       ALURes     => ALURes    , 
                       PC         => Regifid(31 downto 16)     , 
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
  process(clk)
  begin
      PCSrc       <= Regexmem(35) and Regexmem(52);
      JumpAddress <= regifid(31 downto 30) & regifid(13 downto 0);
      end process;
  --ok
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
      --ok
          C3: afisor_7_segmente port map(
                       clk  => clk   ,
                       digit0 => SSDout(15 downto 12),
                       digit1 => SSDout(11 downto 8),
                       digit2 => SSDout(7 downto 4),
                       digit3 => SSDout(3 downto 0),
                       an     => an    ,
                       cat    => cat
                       );
  --ok
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
      
   proces_regIF_ID: process(clk)
                 begin 
                 if(rising_edge(clk)) then
                 if enableMPG='1' then
                 Regifid(31downto 16)<=pcout;
                  Regifid(15downto 0)<=instr;
                      
                 end if ;
                 end if;
                 end process;
                 
                   proces_regID_EX: process(clk)
                                begin 
                                if(rising_edge(clk)) then
                                if enableMPG='1' then
                               
                                
                                 Regidex(82 downto 67)<=Regifid(31 downto 16);
                                 Regidex(66 downto 51)<=rd1 ;
                                 Regidex(50 downto 35)<=rd2 ;   
                                 Regidex(34)<=MemWrite;
                                 Regidex(33)<=MemtoReg;
                                 Regidex(32)<=RegWrite;
                                 Regidex(31)<=Branch;
                                  Regidex(30 downto 28)<=ALUOp;
                                  Regidex(27)<=ALUSrc;
                                  Regidex(26)<=RegDst;
                                  Regidex(25 downto 10)<=Ext_Imm(15 downto 0);
                                  Regidex(9 downto 7)<=func;
                                  Regidex(6)<=sa;
                                  Regidex(5 downto 3)<=Regifid(9 downto 7);
                                  Regidex(2 downto 0)<=Regifid(6 downto 4);
                                end if ;
                                end if;
                                end process;
                                process(Regidex(26),Regifid(9 downto 7),Regifid(6 downto 4))
                                begin
                                wa<=Regifid(9 downto 7);
                                if(Regidex(26)='1')then
                                wa<=Regifid(6 downto 4);
                                end if;
                                end process;
                                 proces_regEX_MEM: process(clk)
                                                begin 
                                                if(rising_edge(clk)) then
                                                if enableMPG='1' then
                                                Regexmem(55)<=Regidex(33);
                                                Regexmem(54)<=Regidex(32);
                                                Regexmem(53)<=Regidex(34);
                                                Regexmem(52)<=Regidex(31);
                                                Regexmem(51 downto 36)<=BranchAddress;
                                                Regexmem(35)<=zerosignal;
                                                Regexmem(34 downto 19)<=aluresfinal;
                                                Regexmem(18 downto 3)<=Regidex(50 downto 35);
                                                Regexmem(2 downto 0)<=wa;
                                                    
                                                     
                                                end if ;
                                                end if;
                                                end process;
                                                
                                                
                                                     proces_regMEM_WB: process(clk)
                                                                 begin 
                                                                 if(rising_edge(clk)) then
                                                                 if enableMPG='1' then
                                                                  Regmemwb(36)<=Regexmem(55);
                                                                 Regmemwb(35)<= Regexmem(54);
                                                                    Regmemwb(34 downto 19)<=memdata;
                                                                      Regmemwb(18 downto 3)<=Regexmem(34 downto 19);
                                                                      Regmemwb(2 downto 0)<=Regexmem(2 downto 0);
                                                                      
                                                                 end if ;
                                                                 end if;
                                                                 end process;
                                                                 process(Regmemwb(34 downto 19),Regmemwb(18 downto 3),Regmemwb(36))
                                                                 begin
                                                                 wdfinal<=Regmemwb(18 downto 3);
                                                                 if(Regmemwb(36)='1') then
                                                                 wdfinal<=Regmemwb(34 downto 19);
                                                                 end if;
                                                                 
                                                                 end process;
end Behavioral;