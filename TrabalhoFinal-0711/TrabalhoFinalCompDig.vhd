----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:19:27 11/07/2018 
-- Design Name: 
-- Module Name:    TrabalhoFinalCompDig - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TrabalhoFinalCompDig is
	port(CLK_50MHZ, reset: in std_logic
		  );
end TrabalhoFinalCompDig;

architecture Behavioral of TrabalhoFinalCompDig is
	signal CLK_1HZ: std_logic := '0';
	signal instructionRegister: std_logic_vector(9 downto 0);
	signal programCounter: std_logic_vector(9 downto 0);
	signal registerA: std_logic_vector(9 downto 0);
	signal registerB: std_logic_vector(9 downto 0);
	signal registerC: std_logic_vector(9 downto 0);
	signal registerD: std_logic_vector(9 downto 0);
begin

	-- ONE SECOND CLOCK PROCESS
	oneSecondClock: process(CLK_50MHZ)
		variable oneSecondCounter: integer := 0;
	begin
		if (falling_edge(CLK_50MHZ)) then
			oneSecondCounter := oneSecondCounter + 1; 
			if (oneSecondCounter = 25000000) then
				CLK_1HZ <= '1';
			elsif (oneSecondCounter >= 50000000) then
				CLK_1HZ <= '0';
				oneSecondCounter := 0; 				
			end if;
		end if;
	end process oneSecondClock;
	
	
	-- CONTROL UNIT PROCESS
	controlUnit: process (CLK_1HZ)
		variable opCode:    std_logic_vector(4 downto 0);
		variable opAddress: std_logic_vector(4 downto 0);
	begin
	--Fetch
		--Pegar instrucao da memoria
		
	--Decode
		opCode    := instructionRegister(9 downto 5);
		opAddress := instructionRegister(4 downto 0);
	
	--Execute
		case opCode is
			when "00001" =>
				--MOV A,[end];
			when "00010" =>
				--MOV [end],A;
			when "00011" =>
				--MOV A,B	;			
			when "00100" =>
				--MOV B,A ;
			when "00101" =>
				--ADD A,B;
			when "00110" =>
				--SUB A,B;
			when "00111" =>
				--AND A,B;
			when "01000" =>
				--OR A,B;
			when "01001" =>
				--XOR A,B;
			when "01010" =>
				--NOT A;
			when "01011" =>
				--NAND A,B;
			when "01100" =>
				--JZ [end];
			when "01101" =>
				--JN [end];
			when "01110" =>
				--HALT;
			when others =>
				--"Code"
		end Case;
				
	end process controlUnit;
	
	--ALU PROCESS
	
	--PROGRAM COUNTER UPDATE PROCESS
	
end Behavioral;

