--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mux8_1bit IS
	PORT (
		In0 : IN std_logic;
		In1 : IN std_logic;
		In2 : IN std_logic;
		In3 : IN std_logic;
		In4 : IN std_logic;
		In5 : IN std_logic;
		In6 : IN std_logic;
		In7 : IN std_logic;
		S0 : IN std_logic;
		S1 : IN std_logic;
		S2 : IN std_logic;
		Z : OUT std_logic
	);
END mux8_1bit;

ARCHITECTURE Behavioral OF mux8_1bit IS
BEGIN
	Z <= In0 AFTER 5 ns WHEN S0 = '0' AND S1 = '0' AND S2 = '0' ELSE
		In1 AFTER 5 ns WHEN S0 = '1' AND S1 = '0' AND S2 = '0' ELSE
		In2 AFTER 5 ns WHEN S0 = '0' AND S1 = '1' AND S2 = '0' ELSE
		In3 AFTER 5 ns WHEN S0 = '1' AND S1 = '1' AND S2 = '0' ELSE
		In4 AFTER 5 ns WHEN S0 = '0' AND S1 = '0' AND S2 = '1' ELSE
		In5 AFTER 5 ns WHEN S0 = '1' AND S1 = '0' AND S2 = '1' ELSE
		In6 AFTER 5 ns WHEN S0 = '0' AND S1 = '1' AND S2 = '1' ELSE
		In7 AFTER 5 ns WHEN S0 = '1' AND S1 = '1' AND S2 = '1' ELSE
		'0' AFTER 5 ns;
END Behavioral;