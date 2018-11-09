----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:18:40 09/24/2018 
-- Design Name: 
-- Module Name:    tecladops2 - Behavioral 
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

entity tecladops2 is
	port( clk, reset, go, clr : in std_logic;
			serialTeclado: in std_logic;
			display: out std_logic_vector (7 downto 0) := "00000001");
end tecladops2;

architecture Behavioral of tecladops2 is
	signal counter: unsigned(2 downto 0) := (others => '0');
	type state is (idle, start, dataEntry, parity);
	signal present_state: state := idle;
	signal next_state: state := idle;
	signal dataVector: std_logic_vector(7 downto 0) := (others => '0');
	
	--contador
	constant DVSR : integer := 5000000;
	signal  ms_reg, ms_next := unsigned(22 downto 0);
	signal  d1_reg, d1_next := unsigned(3 downto 0);
	signal  d0_reg, d0_next := unsigned(3 downto 0);
	signal ms_tick : std_logic;
begin

	process(clk)
	begin
		if (rising_edge(clk)) then
			ms_reg <= ms_next;
			d1_reg <= d1_next;
			d0_reg <= d0_next;
		end if;
	end process;
	
	-- processo sincrono
	process(clk, reset)
	begin
		if (reset = '1') then
			present_state <= idle;
		elsif (falling_edge(clk)) then
			present_state <= next_state;
		end if;
	end process;
	
	ms_next <= (other => '0') when clr
	
	-- processo assincrono
	process(clk)
	begin
		if (rising_edge(clk)) then
			case present_state is
				when idle =>
					if (serialTeclado = '0') then
						next_state <= dataEntry;
						dataVector <= (others => '0');
						counter <= "000";
					end if;
				when dataEntry =>
					if (counter = "111") then
						next_state <= parity;
						counter <= "000";
					else
						counter <= counter + 1;
					end if;
					dataVector <= serialTeclado & dataVector(7 downto 1);
				when parity =>
					display <= dataVector;
					next_state <= idle;
				when others =>
					--display <= "11111111";
			end case;
		end if;
	end process;
		

end Behavioral;

