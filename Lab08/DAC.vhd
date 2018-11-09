----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:22:07 10/22/2018 
-- Design Name: 
-- Module Name:    DAC - Behavioral 
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

entity DAC is
	port (clk, reset : in std_logic;
			SPI_MOSI : out std_logic;
			SPI_SCK : out std_logic;
			SPI_SS_B : out std_logic;
			AMP_CS : out std_logic;
			AD_CONV : out std_logic;
			SF_CE0 : out std_logic;
			FPGA_INIT_B : out std_logic;
			DAC_CS : out std_logic;
			DAC_CLR : out std_logic
			);
end DAC;

architecture Behavioral of DAC is
	signal counter : unsigned(5 downto 0) := "000000";
	signal dataCounter: unsigned (11 downto 0) := "000000000000";
	signal vector_out : std_logic_vector(31 downto 0);
	signal data_in : std_logic_vector(11 downto 0);
	signal one : std_logic_vector(11 downto 0) := "000000000001";
	
begin

	AMP_CS <= '1';
	SPI_SS_B <= '1';
	AD_CONV <= '0';
	SF_CE0 <= '1';
	FPGA_INIT_B <= '1';
	DAC_CLR <= '1';

	SPI_SCK <= clk;
	data_in <= "100000000000";
	-- contador
	process(clk)
	begin
		if falling_edge(clk) then
			case counter is
				when "100000" =>
					counter <= "000000";
					dataCounter <= dataCounter + 1;
				when others =>
					counter <= counter + 1;
			end case;
		end if;
	end process;
	
	process(clk)
	begin
		if falling_edge(clk) then
			case counter is
				when "000000" => 
					DAC_CS <= '1';
					vector_out <= "00000000" & "0011" & "0000" & std_logic_vector(dataCounter) & "0000";
				when others =>
					DAC_CS <= '0';
					SPI_MOSI <= vector_out(31);
					vector_out <= vector_out(30 downto 0) & "0" ;
				
			end case;
			
--			if(counter = "00000") then
--				dataCounter <= dataCounter + 1;
--				data_in <= std_logic_vector(dataCounter);
--				vector_out <= "00000000001100000000000000010000";
--				--vector_out <= "00000000" & "0011" & "0000" & data_in & "0000";
--				DAC_CLR <= '1';
--			end if;


		end if;
	end process;


end Behavioral;

