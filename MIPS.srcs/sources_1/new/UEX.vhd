----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2023 04:28:22 PM
-- Design Name: 
-- Module Name: UEX - Behavioral
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

entity UEX is
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

end UEX;

architecture Behavioral of UEX is
signal iesire_mux : std_logic_vector(15 downto 0); 
signal AluCtrl : std_logic_vector(2 downto 0);
signal Alurestemp : std_logic_vector(2 downto 0);
begin
BranchRes<=PC+ext_imm;
process(aluSrc,ext_imm,rd2)
    begin
    if aluSrc = '1' then
        iesire_mux<=ext_imm;
       else
        iesire_mux<=rd2;
       end if;
end process;

process(aluOp,func)
    begin
    case aluOp is
            when "000" =>
             case (func) is 
                    when "000" => AluCtrl<="000";--  +
                    when "001" => AluCtrl<="001";--  -
                    when "010" => AluCtrl<="010";-- <<1
                    when "011" => AluCtrl<="011";-- >>1
                    when "100" => AluCtrl<="100";-- &
                    when "101" => AluCtrl<="101";-- |
                    when "110" => AluCtrl<="110";-- ^
                    when "111" => AluCtrl<="111";-- >>a
              end case;
            when "001" => AluCtrl<="000";-- +
            when "010" => AluCtrl<="000";-- +
            when "011" => AluCtrl<="000";-- +
            when "100" => AluCtrl<="001";-- - 
            when "101" => AluCtrl<="101";-- |
            when "110" => AluCtrl<="110";-- ^
            when "111" => aluCtrl <= (others => 'X');
        end case;
end process;

process(AluCtrl)
    begin
    case AluCtrl(2 downto 0) is
            when "000" => alurestemp<=rd1+iesire_mux;
            when "001" => alurestemp<=rd1-iesire_mux;
            when "010" =>
            if sa='1' then 
                alurestemp(15 downto 1)<=rd1(14 downto 0);
                alurestemp(0)<='0';
            end if;
            when "011" => 
            if sa='1' then 
                 alurestemp(14 downto 0)<= '0'&rd1(15 downto 1) ;
                 alurestemp(15)<='0';
            end if;
            when "100" => 
                        
                 for i in rd1'range loop
                     alurestemp(i) <= rd1(i) and iesire_mux(i);
                 end loop;
                
            when "101" => 
                                         
                 for i in rd1'range loop
                     alurestemp(i) <= rd1(i) or iesire_mux(i);
                 end loop;
             when "110" => 
                                                         
                 for i in rd1'range loop
                     alurestemp(i) <= rd1(i) xor iesire_mux(i);
                 end loop;
             when "111" => 
                  if sa='1' then 
                     alurestemp(14 downto 0)<= '0'&rd1(15 downto 1) ;
                     alurestemp(15)<=rd1(15);
                  end if;
                       
        end case;
    
end process;
alures<=alurestemp;
zero<='0';
process (alurestemp)
begin
if(alurestemp="0000000000000000") then
zero<='1';
else
zero<='0';
end if;
end process;




end Behavioral;
