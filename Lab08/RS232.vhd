----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:18:40 09/24/2018 
-- Design Name: 
-- Module Name:    RS232 - Behavioral 
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

entity RS232 is
	port( clk : in std_logic;
			data: in std_logic;
			display: out std_logic_vector (7 downto 0) := "00000001"
			);
end RS232;

architecture Behavioral of RS232 is
	signal counter: unsigned(2 downto 0) := (others => '0');
	type state is (idle, dataEntry, parity);
	signal present_state: state := idle;
	signal dataVector: std_logic_vector(7 downto 0) := (others => '0');
	constant MBIT : unsigned (12 downto 0) := to_unsigned(434, 13); -- Meio bit
	signal timer : unsigned (12 downto 0) := MBIT;
begin

	-- processo assincrono
	process(clk)
	begin
		if (rising_edge(clk)) then
			case present_state is
				when idle =>
					if ( data = '0' ) then
						if (timer >= 217) then
							timer <= timer - 1;
						else
							present_state <= dataEntry;
							timer <= MBIT;
						end if;
					else
						timer <= MBIT;
					end if;
				when dataEntry =>			
					if (timer = 0) then
						dataVector <= data & dataVector(7 downto 1);
						if (counter = "111") then
							present_state <= parity;
							counter <= "000";
						else
							counter <= counter + 1;
						end if;
						timer <= MBIT;
					else
						timer <= timer - 1;
					end if;
					
				when parity =>
					display <= dataVector;
					present_state <= idle;
					
				when others =>
					present_state <= idle;
			end case;
		end if;
	end process;
		

end Behavioral;

