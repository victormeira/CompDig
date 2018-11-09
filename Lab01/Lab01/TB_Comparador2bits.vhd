--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:19:33 08/20/2018
-- Design Name:   
-- Module Name:   C:/Users/aula.ELE/Lab01/TB_Comparador2bits.vhd
-- Project Name:  Lab01
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: comparador2bits
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_Comparador2bits IS
END TB_Comparador2bits;

-- arquitetura
ARCHITECTURE behavior OF TB_Comparador2bits IS
 
    -- Declaração do componente em teste
    COMPONENT comparador2bits
    Port ( a : in  STD_LOGIC_VECTOR (1 downto 0);
           b : in  STD_LOGIC_VECTOR (1 downto 0);
           z : out  STD_LOGIC);
	end component;
    
   -- Entradas
   signal a : std_logic_vector (1 downto 0):= ("00");
   signal b : std_logic_vector (1 downto 0):= ("00");

 	-- Saída
   signal z : std_logic;
  
BEGIN
 
	-- Instanciando a UUT (Unit Under Test)
   uut: comparador2bits PORT MAP (
          a => a,
          b => b,
          z => z
        );

  -- Roteiro de testes
   processteste :process
   begin
			a<=("00");
			b<=("00");
			wait for 10 ns;
			a<=("00");
			b<=("01");
			wait for 10 ns;	
			a<=("00");
			b<=("10");
			wait for 10 ns;	
			a<=("00");
			b<=("11");
			wait for 10 ns;	
			a<=("01");
			b<=("00");
			wait for 10 ns;	
			a<=("01");
			b<=("01");
			wait for 10 ns;	
			a<=("01");
			b<=("10");
			wait for 10 ns;	
			a<=("01");
			b<=("11");
			wait for 10 ns;	
			a<=("10");
			b<=("00");
			wait for 10 ns;
			a<=("10");
			b<=("01");
			wait for 10 ns;
			a<=("10");
			b<=("10");
			wait for 10 ns;
			a<=("10");
			b<=("11");
			wait for 10 ns;
			a<=("11");
			b<=("00");
			wait for 10 ns;
			a<=("11");
			b<=("01");
			wait for 10 ns;
			a<=("11");
			b<=("10");
			wait for 10 ns;
			a<=("11");
			b<=("11");
			wait for 10 ns;
			wait;
   end process;
END;