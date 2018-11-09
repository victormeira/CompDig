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
ENTITY Testbench IS
END Testbench;

-- arquitetura
ARCHITECTURE Behavior OF Testbench IS 
 
    -- Declaração do componente em teste
    COMPONENT Testbench
    PORT(
         a : IN  std_logic;
         b : IN  std_logic;
         z : OUT  std_logic
        );
    END COMPONENT;
    
   -- Entradas
   signal a : std_logic := '0';
   signal b : std_logic := '0';

 	-- Saída
   signal z : std_logic;
  
BEGIN
 
	-- Instanciando a UUT (Unit Under Test)
   uut: Testbench PORT MAP (
          a => a,
          b => b,
          z => z
        );

  -- Roteiro de testes
   processteste :process
   begin
			a<='0';
			b<='0';

			a<='0';
			b<='1';

			a<='1';
			b<='1';

			a<='1';
			b<='0';
		   wait;
   end process;
END;
