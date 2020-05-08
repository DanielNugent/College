--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mux9_16bit IS
	PORT (
		In0 : IN std_logic_vector(15 DOWNTO 0);
		In1 : IN std_logic_vector(15 DOWNTO 0);
		In2 : IN std_logic_vector(15 DOWNTO 0);
		In3 : IN std_logic_vector(15 DOWNTO 0);
		In4 : IN std_logic_vector(15 DOWNTO 0);
		In5 : IN std_logic_vector(15 DOWNTO 0);
		In6 : IN std_logic_vector(15 DOWNTO 0);
		In7 : IN std_logic_vector(15 DOWNTO 0);
		In8 : IN std_logic_vector(15 DOWNTO 0);
		src : IN std_logic_vector(3 DOWNTO 0);
		Z : OUT std_logic_vector(15 DOWNTO 0)
	);
END mux9_16bit;

ARCHITECTURE Behavioral OF mux9_16bit IS
BEGIN
	Z <= In0 AFTER 5ns WHEN src = "0000" ELSE
		In1 AFTER 5ns WHEN src = "0001" ELSE
		In2 AFTER 5ns WHEN src = "0010" ELSE
		In3 AFTER 5ns WHEN src = "0011" ELSE
		In4 AFTER 5ns WHEN src = "0100" ELSE
		In5 AFTER 5ns WHEN src = "0101" ELSE
		In6 AFTER 5ns WHEN src = "0110" ELSE
		In7 AFTER 5ns WHEN src = "0111" ELSE
		In8 AFTER 5ns WHEN src = "1000" ELSE
		x"0000" AFTER 5ns;
END Behavioral;