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
			AD_CONV : in std_logic;
			SF_CE0 : out std_logic;
			FPGA_INIT_B : out std_logic;
			DAC_CS : out std_logic;
			DAC_CLR : out std_logic;
			AMP_SHDN: out std_logic;
			led: out std_logic_vector(7 downto 0)
			);
end ADC;

architecture Behavioral of ADC is
	signal counter : unsigned(5 downto 0) := "000000";
	signal dataCounter: unsigned (11 downto 0) := "000000000000";
	signal vector_out : std_logic_vector(7 downto 0);
	signal data_in : std_logic_vector(33 downto 0) := "0000000000000000000000000000000000";
	signal one : std_logic_vector(11 downto 0) := "000000000001";
	signal ampFlag: std_logic := '0';
	signal ADCresult: unsigned(13 downto 0);
	signal readingData : std_logic := '0';
	--integer??
	
begin

	SPI_SS_B <= '1';
	SF_CE0 <= '1';
	FPGA_INIT_B <= '0';
	DAC_CLR <= '1';
	DAC_CS <= '1';
	AMP_SHDN <= '0';
	led <= "00011000";

	SPI_SCK <= clk;
	vector_out <= "00010001";
	counter <= "001000";
	
	process(clk) -- ADCONV??
		variable I: integer := 0;
	begin
		if ( falling_edge(clk) )then
			-- AMP GAIN SETUP
			if (ampFlag = '0') then
				if( not(counter = "000000")) then
					AMP_CS <= '0';
					SPI_MOSI <= vector_out(7);
					vector_out <= vector_out(6 downto 0) & "0" ;
				else
					AMP_CS <= '1';
					ampFlag <= '1';
				end if;
			--ADC logic
			else
					--Data is coming
					if( readingData = '1' ) then
						--Data finished
						if ( counter = "000000" ) then
							--readingData <= '0';
							ADCresult <= unsigned(signed(data_in(31 downto 18)) + 8192);
							
							--Writing to LEDs
							--led <= "00000000";
							for I in 0 to to_integer(ADCresult(13 downto 10)) loop
								led(I) <= '1';
							end loop;
						--Reading Data from current BIT
						else
							data_in <= data_in(32 downto 0) & SPI_MISO;
						end if;						
					end if;
			end if;
		end if;
	end process;
	
	-- contador
	process(clk)
	begin
		if falling_edge(clk) then
			if(readingData = '1' OR ampFlag = '0') then
				counter <= counter - 1;
			else
				counter <= "100010";
			end if;
		end if;
	end process;

	process(AD_CONV)
	begin
		if falling_edge(AD_CONV)then
			readingData <= '1';
		end if;
	end process;

end Behavioral;

