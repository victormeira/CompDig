----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:54:20 08/27/2018 
-- Design Name: 
-- Module Name:    parking - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versionextst: 
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
-- arithmetic functionextst with Signed or Unextstigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if inextsttantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity parking is
	PORT( a, b, clk, reset : in std_logic;
			z	:	out  std_logic_vector(7 downto 0)
	);
end parking;

architecture Behavioral of parking is
	type state_type is (idle, a1);
	signal pres, nextst : state_type;
	signal sum: std_logic_vector(7 downto 0) := (others => '0');
begin

	--sync process
	sync_proc: process(clk, nextst, reset)
	begin
		if (reset='1') then
			pres <= nextst;
		elsif (rising_edge(clk)) then
			pres <= nextst;
		end if;
	end process sync_proc;
	
	comb_proc: process(pres,a,b)
	begin
		case pres is
			when idle =>
				if (a = '1' AND b = '1') then
					nextst <= a1;
				end if;
			when a1 =>
				if (a = '0' AND b = '1') then
					nextst <= idle;
					sum <= sum(6 downto 0) & '1';
				elsif (a = '1' AND b = '0') then
					nextst <= idle;
					sum <= '0' & sum(7 downto 1);
				end if;
		end case;
	end process comb_proc;
	Z <= sum;
	
	--Z <= STD_LOGIC_VECTOR(TO_UNSIGNED(SUM,8));
	
end Behavioral;

