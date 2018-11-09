----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:37:18 10/29/2018 
-- Design Name: 
-- Module Name:    ADC - Behavioral 
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

entity ADC is
	port (clk, reset : in std_logic;
			SPI_MISO : in std_logic;
			SPI_MOSI : out std_logic;
			SPI_SCK : out std_logic;
			SPI_SS_B : out std_logic;
			AMP_CS : out std_logic;
			AD_CONV : out std_logic;
			SF_CE0 : out std_logic;
			FPGA_INIT_B : out std_logic;
			DAC_CS : out std_logic;
			DAC_CLR : out std_logic;
			AMP_SHDN: out std_logic;
			led: out std_logic_vector(7 downto 0) := "10000001"
			);
end ADC;

architecture Behavioral of ADC is
	signal counter : unsigned(5 downto 0) := "001000";
	signal dataCounter: unsigned (11 downto 0) := "000000000000";
	signal vector_out : std_logic_vector(7 downto 0) := "00010001";
	signal data_in : std_logic_vector(33 downto 0) := "0000000000000000000000000000000000";
	signal one : std_logic_vector(11 downto 0) := "000000000001";
	signal ampFlag: std_logic := '0';
	signal ADCresult: std_logic_vector(13 downto 0);
	signal readingData : std_logic := '0';
	type state_type is (reading, amp, waiting);
	signal state_reg : state_type := amp;
	signal state_next : state_type := amp;
	signal slow_clk: std_logic;
	signal clk_counter: unsigned(2 downto 0) :="000";
	signal adcint : integer;
	--integer??
	
begin

	SPI_SS_B <= '1';
	SF_CE0 <= '1';
	FPGA_INIT_B <= '0';
	DAC_CLR <= '1';
	DAC_CS <= '1';
	AMP_SHDN <= '0';
	--led <= "00011000";

	SPI_SCK <= slow_clk;
	slow_clk <= clk_counter(2);
	--vector_out <= "00010001";
	--counter <= "001000";
	
	
	-- cria clock mais lento
	process(clk)
	begin
		if (rising_edge(clk)) then
			clk_counter <= clk_counter + 1;
		end if;
	end process;
	
	-- troca de estado
	process(slow_clk)
	begin
		if (rising_edge(slow_clk)) then
			state_reg <= state_next;
		end if;
	end process;
	
	-- contador
	process(slow_clk)
	begin
		if rising_edge(slow_clk) then
			if(state_reg = reading OR state_reg = amp) then
				counter <= counter - 1;
			else
				counter <= "100010";
			end if;
		end if;
	end process;
	
	process(slow_clk)
	begin				
		if ( falling_edge(slow_clk) ) then
		
			-- AMP GAIN SETUP
			if (state_reg = amp) then
			
				-- Sending Setup Data
				if( not(counter = "000000")) then
					AMP_CS <= '0';
					SPI_MOSI <= vector_out(7);
					vector_out <= vector_out(6 downto 0) & "0" ;
					
				-- Setup is done	
				else
					AMP_CS <= '1';
					AD_CONV <= '1';
					state_next <= waiting;
					--ampFlag <= '1';
				end if;
				
			-- ADC logic
			else
					--Data is coming
					if( state_reg = reading ) then
						--Data finished
						if ( counter = "000000" ) then
							state_next <= waiting;
							AD_CONV <= '1';
							
							--ADCresult <= unsigned(signed(data_in(16 downto 3)) + 8192);
							adcint <= to_integer( signed(data_in(14 downto 1))  );
							ADCresult <= std_logic_vector(  to_unsigned(adcint ,14)  );
							--ADCresult <= data_in(14 downto 1);
							
							--Writing to LEDs
							case ADCresult(12 downto 10) is
								when "000" => led <= "00000001";
								when "001" => led <= "00000011";
								when "010" => led <= "00000111";
								when "011" => led <= "00001111";
								when "100" => led <= "00011111";
								when "101" => led <= "00111111";
								when "110" => led <= "01111111";
								when "111" => led <= "11111111";
								when others => led <= "00111100";
							end case;
							
--							for I in 0 to to_integer(ADCresult(13 downto 10)) loop
--								led(I) <= '1';
--							end loop;

						--Reading Data from current BIT						
						else
							data_in <= data_in(32 downto 0) & SPI_MISO;
						end if;
						
					-- waiting state
					else
						AD_CONV <= '0';
						state_next <= reading;
					end if;
					
			end if;
		end if;
	end process;

end Behavioral;

