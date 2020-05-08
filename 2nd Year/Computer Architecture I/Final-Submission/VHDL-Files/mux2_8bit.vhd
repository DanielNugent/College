--Daniel Nugent
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY mux2_8bit IS
	PORT (
		Sel : IN std_logic;
		In0 : IN std_logic_vector(7 DOWNTO 0);
		In1 : IN std_logic_vector(7 DOWNTO 0);
		mux_out : OUT std_logic_vector(7 DOWNTO 0)
	);
END mux2_8bit;

ARCHITECTURE Behavioral OF mux2_8bit IS

BEGIN

	mux_out <= In0 AFTER 1ns WHEN Sel = '0' ELSE
		In1 AFTER 1ns WHEN Sel = '1' ELSE
		x"00" AFTER 1ns;

END Behavioral;