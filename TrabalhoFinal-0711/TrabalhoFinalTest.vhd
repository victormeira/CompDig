--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:38:16 11/07/2018
-- Design Name:   
-- Module Name:   C:/Users/aula2.ELE/Desktop/teclado/TrabalhoFinalTest.vhd
-- Project Name:  teclado
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TrabalhoFinalCompDig
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
 
ENTITY TrabalhoFinalTest IS
END TrabalhoFinalTest;
 
ARCHITECTURE behavior OF TrabalhoFinalTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TrabalhoFinalCompDig
    PORT(
         CLK_50MHZ : IN  std_logic;
			CLK_1HZ: OUT std_logic;
         reset : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_50MHZ : std_logic := '0';
   signal reset : std_logic := '0';

   -- Clock period definitions
   constant CLK_50MHZ_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TrabalhoFinalCompDig PORT MAP (
          CLK_50MHZ => CLK_50MHZ,
          reset => reset,
			 CLK_1HZ => CLK_1HZ
        );

   -- Clock process definitions
   CLK_50MHZ_process :process
   begin
		CLK_50MHZ <= '0';
		wait for CLK_50MHZ_period/2;
		CLK_50MHZ <= '1';
		wait for CLK_50MHZ_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_50MHZ_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
