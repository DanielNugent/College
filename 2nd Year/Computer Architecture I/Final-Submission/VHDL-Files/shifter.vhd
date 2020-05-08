--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY shifter IS
	PORT (
		In0 : IN std_logic;
		In1 : IN std_logic;
		In2 : IN std_logic;
		s : IN std_logic_vector(1 DOWNTO 0);
		Z : OUT std_logic
	);
END shifter;

ARCHITECTURE Behavioral OF shifter IS

BEGIN

	Z <= In0 AFTER 1ns WHEN S = "00" ELSE
		In1 AFTER 1ns WHEN S = "01" ELSE
		In2 AFTER 1ns WHEN S = "10" ELSE
		'0' AFTER 1ns;

END Behavioral;