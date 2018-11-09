--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:52:20 08/20/2018
-- Design Name:   
-- Module Name:   C:/Users/aula.ELE/Lab01/TB_Lab1_Comp1bit.vhd
-- Project Name:  Lab01
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: comparador
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


--------------------------------------------------------------------------------
-- Computacao Digital
-- ENG 1448
-- Laboratorio 1 - parte 1
-- Comparador de 1 bit
-- Testbench
--------------------------------------------------------------------------------

-- bibliotecas
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- entidade 
ENTITY TB_Lab1_Comp1bit IS
END TB_Lab1_Comp1bit;

-- arquitetura
ARCHITECTURE behavior OF TB_Lab1_Comp1bit IS
 
    -- Declaração do componente em teste
    COMPONENT comparadora
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           z : out  STD_LOGIC);
	end component;
    
   -- Entradas
   signal a : std_logic := '0';
   signal b : std_logic := '0';

 	-- Saída
   signal z : std_logic;
  
BEGIN
 
	-- Instanciando a UUT (Unit Under Test)
   uut: comparadora PORT MAP (
          a => a,
          b => b,
          z => z
        );

  -- Roteiro de testes
   processteste :process
   begin
			a<='0';
			b<='0';
wait for 10 ns;	
			a<='0';
			b<='1';
wait for 10 ns;	
			a<='1';
			b<='1';
      		wait for 10 ns;	
			a<='1';
			b<='0';
		wait;
   end process;
END;
