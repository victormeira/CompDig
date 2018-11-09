--------------------------------------------------------------------------------
-- Lab 02
-- Parking
-- Testbench
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY TB_Parking IS
END TB_Parking;
 
ARCHITECTURE behavior OF TB_Parking IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT parking
    PORT(
         clk 	: IN  std_logic;
         reset	 : IN  std_logic;
         a 		: IN  std_logic;
         b 		: IN  std_logic;
         z 		: OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk 		: std_logic := '0';
   signal reset 		: std_logic := '0';
   signal a 		: std_logic := '0';
   signal b 		: std_logic := '0';

 	--Outputs
   signal z : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: parking PORT MAP (
          clk => clk,
          reset => reset,
          a => a,
          b => b,
          z => z
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
