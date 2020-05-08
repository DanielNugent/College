--Daniel Nugent
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY mux2_1bit IS
	PORT (
		Sel : IN std_logic;
		In0 : IN std_logic;
		In1 : IN std_logic;
		mux_out : OUT std_logic
	);
END mux2_1bit;

ARCHITECTURE Behavioral OF mux2_1bit IS

BEGIN

	mux_out <= In0 AFTER 1ns WHEN Sel = '0' ELSE
		In1 AFTER 1ns WHEN Sel = '1' ELSE
		'0' AFTER 1ns;

END Behavioral;