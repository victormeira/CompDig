--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:25:23 09/03/2018
-- Design Name:   
-- Module Name:   D:/Lab03/debounce_text.vhd
-- Project Name:  Lab03
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: db_fsm
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
 
ENTITY debounce_text IS
END debounce_text;
 
ARCHITECTURE behavior OF debounce_text IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT db_fsm
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         sw : IN  std_logic;
         db : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal sw : std_logic := '0';

 	--Outputs
   signal db : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: db_fsm PORT MAP (
          clk => clk,
          reset => reset,
          sw => sw,
          db => db
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
      reset <='1';
      wait for 100 ns;	
		reset <='0';
      wait for clk_period*10;
		a <='0'; b <='0'; wait until rising_edge(clk);
		a <='1'; b <='0'; wait until rising_edge(clk);
		a <='1'; b <='1'; wait until rising_edge(clk);
		a <='0'; b <='1'; wait until rising_edge(clk);
		a <='0'; b <='0'; wait until rising_edge(clk);
		-- 1o carro entrou
		--
		wait for 100 ns;
		a <='0'; b <='0'; wait until rising_edge(clk);
		a <='1'; b <='0'; wait until rising_edge(clk);
		a <='1'; b <='1'; wait until rising_edge(clk);
		a <='0'; b <='1'; wait until rising_edge(clk);
		a <='0'; b <='0'; wait until rising_edge(clk);
		-- 2o carro entrou
		--
		wait for 100 ns;
		a <='0'; b <='0'; wait until rising_edge(clk);
		a <='0'; b <='1'; wait until rising_edge(clk);
		a <='1'; b <='1'; wait until rising_edge(clk);
		a <='1'; b <='0'; wait until rising_edge(clk);
		a <='0'; b <='0'; wait until rising_edge(clk);
		a <='0'; b <='0'; wait until rising_edge(clk);
      -- 1o carro saiu
		--
		wait for 100 ns;
		a <='0'; b <='0'; wait until rising_edge(clk);
		a <='0'; b <='1'; wait until rising_edge(clk);
		a <='1'; b <='1'; wait until rising_edge(clk);
		a <='1'; b <='0'; wait until rising_edge(clk);
		a <='0'; b <='0'; wait until rising_edge(clk);
		a <='0'; b <='0'; wait until rising_edge(clk);
      -- 2o carro saiu
		--
      wait;
   end process;

END;
