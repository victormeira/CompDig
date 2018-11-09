----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:55:08 09/10/2018 
-- Design Name: 
-- Module Name:    tec - Behavioral 
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
use ieee.numeric_std.all;

entity tec is
	port (clk, reset : in std_logic;
			row : in std_logic_vector(3 downto 0);
			an : out std_logic;
			sseg : out std_logic_vector(6 downto 0);
			col : out std_logic_vector(3 downto 0)
			);
end tec;

architecture Behavioral of tec is
	constant N: integer := 18;
	signal q_reg, q_next : unsigned(N-1 downto 0);
	signal sel : std_logic;
	signal hex : std_logic_vector(3 downto 0);
	signal hex0 : std_logic_vector(3 downto 0) := "0000";
	signal zcounter : std_logic_vector(3 downto 0) := "1110";
	signal dummy : std_logic := '0';
begin
	-- register
	process(clk, reset)
	begin
		if reset='1' then
			q_reg <= (others=>'0');
		elsif (clk'event and clk='1') then
			q_reg <= q_next;
		end if;
	end process;
	
	-- next-state logic for the counter
	q_next <= q_reg + 1;
	
	-- 2 MSB to control 4 to 1 mux
	sel <= std_logic(q_reg(N-1));
	
	-- seleção de cada display
	process(sel, hex0)
	begin
		case sel is
			when '0' =>
				an <= '1';
				hex <= hex0;
			when '1' =>
				an <= '0';
				hex <= hex0;
			when others =>
				an <= '1';
		end case;
	end process;
	
	-- contador para as colunas
	process(clk)
	begin
		if rising_edge(clk) then
			zcounter <= zcounter(2 downto 0) & zcounter(3);
		end if;
	end process;
	
	col <= zcounter;
	
	-- identificação do número pressionado
	process(row)
	begin
		case row is
			when "1110" =>
				case zcounter is
					when "1110" =>
						hex0 <= "1010";
					when "1101" =>
						hex0 <= "0011";
					when "1011" =>
						hex0 <= "0010";
					when "0111" =>
						hex0 <= "0001";
					when others =>
						hex0 <= "1111";
				end case;
			when others =>
				dummy <= '1';
		end case;
	end process;
	
	with hex select
		sseg(6 downto 0) <=
			"0111111" when "0000", -- 0
			"0000110" when "0001", -- 1
			"1011011" when "0010", -- 2
			"1001111" when "0011", -- 3
			"1100110" when "0100", -- 4
			"1101101" when "0101", -- 5
			"1111101" when "0110", -- 6
			"0000111" when "0111", -- 7
			"1111111" when "1000", -- 8
			"1101111" when "1001", -- 9
			"1110111" when "1010", -- a
			"1111100" when "1011", -- b
			"0111001" when "1100", -- c
			"1011110" when "1101", -- d
			"1111001" when "1110", -- e
			"1110001" when "1111", -- f
			"1111110" when others;	


end Behavioral;

