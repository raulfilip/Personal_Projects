----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/07/2023 05:28:02 PM
-- Design Name: 
-- Module Name: UC - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UC is
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
end UC;

architecture Behavioral of UC is
signal signal1 : std_logic_vector(10 downto 0);
begin

process(Instr)
begin
case Instr is
when "000"=>signal1<="10000000001" ; 
when "001"=>signal1<="01100001001" ;
when "010"=>signal1<="01100010011" ;
when "011"=>signal1<="01100011100" ;
when "100"=>signal1<="00010100000" ;
when "101"=>signal1<="00100101001" ;
when "110"=>signal1<="00100110001" ;
when others =>signal1<="000010000";
end case;
end process;

process(signal1)
begin
  RegDst <=signal1(10);
  ExtOp <=signal1(9);
  ALUSrc <=signal1(8);
  Branch <=signal1(7);
  Jump <=signal1(6);
  ALUOp <=signal1(5 downto 3);
  MemWrite <=signal1(2);
  MemtoReg <=signal1(1);
  Regwrite <=signal1(0);

end process;
end Behavioral;
