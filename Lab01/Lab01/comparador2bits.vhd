----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:04:51 08/20/2018 
-- Design Name: 
-- Module Name:    comparador2bits - Behavioral 
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

entity comparador2bits is
	port(
		a: in std_logic_vector(1 downto 0);
		b: in std_logic_vector(1 downto 0);
		z: out std_logic
	);
end comparador2bits;

architecture Behavioral of comparador2bits is
	signal comp0 : std_logic;
   signal comp1 : std_logic;

begin

	CompBit0 : entity work.comparadora(behavioral)
	port map (a=>a(0), b=>b(0), z=>comp0);
	
	CompBit1 : entity work.comparadora(behavioral)
	port map (a=>a(1), b=>b(1), z=>comp1);

	z <= comp0 AND comp1;

end Behavioral;

