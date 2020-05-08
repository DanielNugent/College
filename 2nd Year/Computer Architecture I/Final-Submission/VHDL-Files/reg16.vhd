--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY reg16 IS
	PORT (
		D : IN std_logic_vector(15 DOWNTO 0);
		load : IN std_logic;
		Clk : IN std_logic;
		Q : OUT std_logic_vector(15 DOWNTO 0)
	);
END reg16;

ARCHITECTURE Behavioral OF reg16 IS

BEGIN

	PROCESS (Clk)
	BEGIN
		IF (rising_edge(Clk)) THEN
			IF load = '1' THEN
				Q <= D AFTER 5 ns;
			END IF;
		END IF;
	END PROCESS;

END Behavioral;