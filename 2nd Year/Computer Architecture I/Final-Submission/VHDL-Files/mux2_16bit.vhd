--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY mux2_16bit IS
	PORT (
		In0 : IN std_logic_vector(15 DOWNTO 0);
		In1 : IN std_logic_vector(15 DOWNTO 0);
		s : IN std_logic;
		Z : OUT std_logic_vector(15 DOWNTO 0)
	);
END mux2_16bit;

ARCHITECTURE Behavioral OF mux2_16bit IS
BEGIN
	Z <= In0 AFTER 5ns WHEN S = '0' ELSE
		In1 AFTER 5ns WHEN S = '1'ELSE
		"0000000000000000" AFTER 1ns;
END Behavioral;