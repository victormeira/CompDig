----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:51:51 10/08/2018 
-- Design Name: 
-- Module Name:    LCD - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LCD is
PORT(
		clk : IN STD_LOGIC;
		lcd_rw, lcd_rs, lcd_e : OUT STD_LOGIC;			
		sf_d : OUT STD_LOGIC_VECTOR(11 downto 0);
		led_1, led_2, led_3 : out std_logic);
end LCD;

architecture Behavioral of LCD is
signal new_clk : STD_LOGIC;
signal count_clk : INTEGER := 0;
type state_type is (
	ini_0,
	ini_1,
	ini_2,
	ini_3,
	ini_4,
	ini_5,
	ini_6,
	ini_7,
	ini_8,
	conf_1,
	conf_2,
	conf_3,
	conf_4,
	conf_5,
	conf_6,
	conf_7,
	conf_8,
	conf_9,
	conf_10,
	conf_11,
	conf_12,
	conf_13,
	conf_14,
	conf_15,
	conf_16,
	write_1,
	write_2,
	write_3,
	write_4,
	write_5,
	write_6,
	write_7,
	write_8,
	write_9,
	write_10,
	write_11,
	write_12,
	write_13,
	write_14,
	write_15,
	write_16,
	write_17,
	write_18,
	write_19,
	write_20,
	write_21,
	write_22,
	write_23,
	write_24,
	write_25,
	write_26,
	write_27,
	write_28,
	write_29);
signal present_state : state_type := ini_0;

begin

	process (clk)
	begin
		if (falling_edge(clk)) then
			if (count_clk < 62500) then
					new_clk <= '0';
					count_clk <= count_clk + 1;
			elsif (count_clk < 125000) then
					new_clk <= '1';
					count_clk <= count_clk + 1;
			else 
					count_clk <= 0;
			end if;
		end if;
	end process;

	process (new_clk)
	begin
		if (falling_edge(new_clk)) then
			case present_state is 
				when ini_0 =>
					lcd_rw <= '0';
					lcd_rs <= '0';
					lcd_e <= '0';
					present_state <= ini_1;
				when ini_1 =>
					sf_d(11 downto 8) <= "0011";
					lcd_e <= '1';
					present_state <= ini_2;
				when ini_2 =>
					lcd_e <= '0';
					present_state <= ini_3;
				when ini_3 =>
					lcd_e <= '1';
					sf_d(11 downto 8) <= "0011";
					present_state <= ini_4;
				when ini_4 =>
					lcd_e <= '0';
					present_state <= ini_5;
				when ini_5 =>
					lcd_e <= '1';
					sf_d(11 downto 8) <= "0011";
					present_state <= ini_6;
				when ini_6 =>
					lcd_e <= '0';
					present_state <= ini_7;
				when ini_7 =>
					lcd_e <= '1';
					sf_d(11 downto 8) <= "0010";
					present_state <= ini_8;
				when ini_8 =>
					lcd_e <= '0';
					present_state <= conf_1;
					led_1 <= '1';
				



			
				when conf_1 =>
					lcd_e <= '0';
					sf_d(11 downto 8) <= "0010";
					present_state <= conf_2;
				when conf_2 =>
					lcd_e <= '1';
					present_state <= conf_3;
				when conf_3 =>
					lcd_e <= '0';
					sf_d(11 downto 8) <= "1000";
					present_state <= conf_4;
				when conf_4 =>
					lcd_e <= '1';
					present_state <= conf_5;
				when conf_5 =>
					lcd_e <= '0';
					sf_d(11 downto 8) <= "0000";
					present_state <= conf_6;
				when conf_6 =>
					lcd_e <= '1';
					present_state <= conf_7;
				when conf_7 =>
					lcd_e <= '0';
					sf_d(11 downto 8) <= "0110";
					present_state <= conf_8;
				when conf_8 =>
					lcd_e <= '1';
					present_state <= conf_9;
				when conf_9 =>
					lcd_e <= '0';
					sf_d(11 downto 8) <= "0000";
					present_state <= conf_10;
				when conf_10 =>
					lcd_e <= '1';
					present_state <= conf_11;
				when conf_11 => 
					lcd_e <= '0';
					sf_d(11 downto 8) <= "1100";
					present_state <= conf_12;
				when conf_12 =>
					lcd_e <= '1';
					present_state <= conf_13;
				when conf_13 =>
					lcd_e <= '0';
					sf_d(11 downto 8) <= "0000";
					present_state <= conf_14;
				when conf_14 =>
					lcd_e <= '1';
					present_state <= conf_15;
				when conf_15 =>
					lcd_e <= '0';
					sf_d(11 downto 8) <= "0001";
					present_state <= conf_16;
				when conf_16 =>
					lcd_e <= '1';
					present_state <= write_1;
					led_2 <= '1';			
				



				when write_1 =>
					lcd_e <= '0';
					lcd_rs <= '1';
					lcd_rw <= '0';
					present_state <= write_2;
				when write_2 =>
					lcd_e <= '0';
					present_state <= write_3;
				when write_3 =>
					lcd_e <= '0';
					sf_d (11 downto 8) <= "0100";
					present_state <= write_4;
				when write_4 =>
					lcd_e <= '1';
					present_state <= write_5;
				when write_5 =>
					lcd_e <= '0';
					sf_d (11 downto 8) <= "1000";
					present_state <= write_6;
				when write_6 =>
					lcd_e <= '1';
					present_state <= write_7;
				when write_7 =>
					lcd_e <= '0';
					sf_d (11 downto 8) <= "0100";
					present_state <= write_8;
				when write_8 =>
					lcd_e <= '1';
					present_state <= write_9;
				when write_9 =>
					lcd_e <= '0';
					sf_d (11 downto 8) <= "0101";
					present_state <= write_10;
				when write_10 =>
					lcd_e <= '1';
					present_state <= write_11;
				when write_11 =>
					lcd_e <= '0';
					sf_d (11 downto 8) <= "0100";
					present_state <= write_12;
				when write_12 =>
					lcd_e <= '1';
					present_state <= write_13;
				when write_13 =>
					lcd_e <= '0';
					sf_d (11 downto 8) <= "1100";
					present_state <= write_14;
					
				when write_14 =>
					lcd_e <= '1';
					present_state <= write_15;
					
				when write_15 =>
					lcd_e <= '0';
					sf_d (11 downto 8) <= "0100";
					present_state <= write_16;
				when write_16 =>
					lcd_e <= '1';
					present_state <= write_17;
				when write_17 =>
					lcd_e <= '0';
					sf_d (11 downto 8) <= "1100";
					present_state <= write_18;
				when write_18 =>
					lcd_e <= '1';
					present_state <= write_19;
					
				when write_19 =>
					lcd_e <= '1';
					present_state <= write_20;
					
				when write_20 =>
					lcd_e <= '0';
					sf_d (11 downto 8) <= "0100";
					present_state <= write_21;
				when write_21 =>
					lcd_e <= '1';
					present_state <= write_22;
				when write_22 =>
					lcd_e <= '0';
					sf_d (11 downto 8) <= "1111";
					present_state <= write_23;
				when write_23 =>
					lcd_e <= '1';
					present_state <= write_24;									
			
					
				when write_24 =>
					lcd_e <= '1';
					present_state <= write_25;
					
				when write_25 =>
					lcd_e <= '0';
					sf_d (11 downto 8) <= "0010";
					present_state <= write_26;
				when write_26 =>
					lcd_e <= '1';
					present_state <= write_27;
				when write_27 =>
					lcd_e <= '0';
					sf_d (11 downto 8) <= "0001";
					present_state <= write_28;
				when write_28 =>
					lcd_e <= '1';
					present_state <= write_29;
					
				
				
				when write_29 =>
					lcd_e <= '0';
					led_3 <= '1';
				when others =>
						present_state <=  ini_0;
				
			end case;
		end if;
	end process;
end Behavioral;


