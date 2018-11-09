----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:56:41 09/03/2018 
-- Design Name: 
-- Module Name:    db_fsm - arch 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity db_fsm is
	port(	clk, reset : in std_logic;
			sw			  : in std_logic;
			rotary_b_in: in std_logic;
			rotary_a_in: in std_logic;
			led		  : out std_logic_vector(7 downto 0) := "00000001");
end db_fsm;

architecture arch of db_fsm is
	constant N: integer := 19; --2^N * 20ns = 10ms
	signal counter : unsigned(N-1 downto 0) := (others => '0');
	signal savedState : std_logic;
	signal rotary_in  : std_logic_vector(1 downto 0);
	signal rotary_q1	: std_logic;
	signal rotary_q2	: std_logic;
	signal delay_rotary_q1 : std_logic;
	signal rotary_event : std_logic;
	signal rotary_left : std_logic;
	signal signal_led: UNSIGNED(7 downto 0) := ('0','0','0','0','0','0','0','1');

begin

	-- counter to generate 10ms tick --
	process(clk, reset)
	begin
		if (clk'event and clk='1') then
			if (reset = '1') then
				counter <= (others => '0');
			elsif (sw = '1') and (counter(N-1) = '0') then
				counter <= counter + 1;
			elsif (sw = '0') and (counter(N-1) = '1') then
				savedState <= not(savedState);
				counter <= (others => '0');
			elsif (sw = '0') then
				counter <= (others => '0');
			end if;
		end if;
	end process;

	rotary_filter: process(clk)
	begin
		if (clk'event and clk='1') then
			rotary_in <= rotary_b_in & rotary_a_in;
			case rotary_in is
				when "00" => 
					rotary_q1 <= '0';
					rotary_q2 <= rotary_q2;
				when "01" => 
					rotary_q1 <= rotary_q1;
					rotary_q2 <= '0';
				when "10" => 
					rotary_q1 <= rotary_q1;
					rotary_q2 <= '1';
				when "11" => 
					rotary_q1 <= '1';
					rotary_q2 <= rotary_q2;
				when others => 
					rotary_q1 <= rotary_q1;
					rotary_q2 <= rotary_q2;
			end case;
		end if;
	end process rotary_filter;

	
	direction: process(clk)
	begin
		if (clk'event and clk='1') then
			delay_rotary_q1 <= rotary_q1;
			if rotary_q1='1' and delay_rotary_q1='0' then
				rotary_event <= '1';
				rotary_left <= rotary_q2;
			else
				rotary_event <= '0';
				rotary_left <= rotary_left;
			end if;
		end if;
	end process direction;
	
	process(clk, rotary_event, rotary_left, savedState)
	begin
		if rising_edge(clk) then
			if(rotary_event = '1') then
				if (rotary_left = '1') then
					signal_led <= signal_led rol 1;
				elsif (rotary_left = '0') then
					signal_led <= signal_led ror 1;
				end if;
			end if;
			if (savedState = '1') then
				led <= not (Std_logic_vector(signal_led));
			else
				led <= Std_logic_vector(signal_led);
			end if;
		end if;
	end process;
end arch;

