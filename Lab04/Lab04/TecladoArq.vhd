 ----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:35:25 09/10/2018 
-- Design Name: 
-- Module Name:    TecladoArq - Behavioral 
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

entity TecladoArq is
	port( clk, reset : in std_logic;
			row 		  : in std_logic_vector(3 downto 0);
			tecladoOut:  in std_logic_vector(3 downto 0) := "1010";
			col		  : out std_logic_vector(3 downto 0);
			an			  : out std_logic_vector(1 downto 0);
			sseg    	  : out std_logic_vector(7 downto 0) := "00000000");			
end TecladoArq;

architecture Behavioral of TecladoArq is
	
	--Variaveis do contador e debounce
	constant N: integer := 9;
	signal q_reg: unsigned(N-1 downto 0);
	signal q_next: unsigned(N-1 downto 0);
	type eg_state_type is (zero, wait1_1, wait1_2, wait1_3, one, wait0_1, wait0_2, wait0_3);
	signal state_reg, state_next: eg_state_type;
	signal sclk: unsigned(23 downto 0);
	signal sclk_next: unsigned(23 downto 0);
	
	--Variaveis do display de 7-seg
	signal sel: std_logic;
	signal hex: std_logic_vector(3 downto 0);
	signal hex1: std_logic_vector(3 downto 0);
	
	--Variaveis do teclado
	--signal tecladoOut: std_logic_vector(3 downto 0) := "1010";
		
begin

--Processo Sincrono
	process (clk,reset)
	begin
--		if reset = '1' then
--			q_reg <= (others => '0');
		if (clk' event and clk = '1') then
			q_reg <= q_reg + 1;
		end if;
	end process;
	
	--q_next <= q_reg+1;
	
--Processo Display de 7-seg
	process(sel,tecladoOut)
	begin
		case sel is
			when '0' =>
				an <= "10";
				hex <= tecladoOut;
			when '1' =>
				an <= "01";
				--hex <= hex1;
				hex <= tecladoOut;
			when others =>
				an <= "11";
		end case;
	end process;

--Decodificacao do Display de 7-seg	
	sel <= std_logic(q_reg(N-1));
	with hex select
		sseg(6 downto 0) <=
			"0111111" when "0000", --0
			"0000110" when "0001", --1
			"1011011" when "0010", --2
			"1001111" when "0011", --3
			"1100110" when "0100", --4
			"1101101" when "0101", --5
			"1111101" when "0110", --6
			"0000111" when "0111", --7
			"1111111" when "1000", --8
			"1101111" when "1001", --9
			"1110111" when "1010", --A
			"1111100" when "1011", --B
			"0111001" when "1100", --C
			"1011110" when "1101", --D
			"1111001" when "1110", --E
			"1110001" when "1111", --F
			"1111110" when others;
	sseg(7) <= sel;
	
	
end Behavioral;

