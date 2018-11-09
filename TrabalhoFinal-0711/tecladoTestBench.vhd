--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:12:01 09/17/2018
-- Design Name:   
-- Module Name:   C:/Users/aula2.ELE/Desktop/teclado/tecladoTestBench.vhd
-- Project Name:  teclado
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: tec
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
 
ENTITY tecladoTestBench IS
END tecladoTestBench;
 
ARCHITECTURE behavior OF tecladoTestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT tec
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         row : IN  std_logic_vector(3 downto 0);
         an : OUT  std_logic;
         sseg : OUT  std_logic_vector(6 downto 0);
         col : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal row : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal an : std_logic;
   signal sseg : std_logic_vector(6 downto 0);
   signal col : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: tec PORT MAP (
          clk => clk,
          reset => reset,
          row => row,
          an => an,
          sseg => sseg,
          col => col
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
