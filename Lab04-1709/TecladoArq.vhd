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
			col		  : out std_logic_vector(3 downto 0) := "0111" ;
			an			  : out std_logic_vector(1 downto 0);
			sseg    	  : out std_logic_vector(7 downto 0) := "00000000");			
end TecladoArq;

architecture Behavioral of TecladoArq is
	
	--Variaveis do contador e debounce
	constant N: integer := 9;
	signal q_reg: unsigned(N-1 downto 0);
	signal q_next: unsigned(N-1 downto 0);
	
	constant M: integer := 20;
	signal contadorTeclado: unsigned(M-1 downto 0);
	
	--Variaveis do display de 7-seg
	signal sel: std_logic;
	signal hex: std_logic_vector(3 downto 0);
	signal hex1: std_logic_vector(3 downto 0) :="1010";
	
	--Variaveis do teclado
	signal tecladoOut: std_logic_vector(3 downto 0) := "1111";
	signal colRead: UNSIGNED(3 downto 0) := ('1','1','0','1');
	signal jaTroquei: std_logic := '0';
		
begin

--Processo Sincrono
	process (clk,reset)
	begin
--		if reset = '1' then
--			q_reg <= (others => '0');
		if (clk'event and clk = '1') then
			q_reg <= q_reg + 1;
		end if;
	end process;
	
	--q_next <= q_reg+1;
	
	process (clk, row)
	begin
		if (clk'event and clk = '1') then
			
			if row = "1111" then
				contadorTeclado <= contadorTeclado + 1;
			else
				if jaTroquei <= '0' then
					hex1 <= tecladoOut;
					jaTroquei <= '1';
				end if;
				contadorTeclado <= (others => '0');
			end if;
		
			if contadorTeclado = "11111111111111111111" then
				colRead <= colRead ror 1;
				jaTroquei <= '0';
			end if;
			--col <= Std_logic_vector(colRead);
			case colRead is
				when "1110" => 
					case row is
						when "0111" =>
							tecladoOut <= "0000";
						when "1011" =>
							tecladoOut <= "0111";
						when "1101" => 
							tecladoOut <= "0100";
						when "1110" =>
							tecladoOut <= "0001";
						when others =>
							
					end case;
				when "1101" => 
					case row is
						when "0111" =>
							tecladoOut <= "1111";
						when "1011" =>
							tecladoOut <= "1000";
						when "1101" =>
							tecladoOut <= "0101";
						when "1110" =>
							tecladoOut <= "0010";
						when others =>
							
					end case;
				when "1011" => 
					case row is
						when "0111" =>
							tecladoOut <= "1110";
						when "1011" =>
							tecladoOut <= "1001";
						when "1101" =>
							tecladoOut <= "0110";
						when "1110" =>
							tecladoOut <= "0011";
						when others =>
							
					end case;
				when "0111" => 
					case row is
						when "0111" =>
							tecladoOut <= "1101";
						when "1011" =>
							tecladoOut <= "1100";
						when "1101" =>
							tecladoOut <= "1011";
						when "1110" =>
							tecladoOut <= "1010";
						when others =>
							
					end case;
				when others =>
					--tecladoOut <= "1000";
			end case;
		end if;
	end process;
	
	col <= Std_logic_vector(colRead);
	
	
--Processo Display de 7-seg
	process(sel,tecladoOut)
	begin
		case sel is
			when '0' =>
				an <= "10";
				hex <= tecladoOut;
			when '1' =>
				an <= "01";
				hex <= hex1;
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

