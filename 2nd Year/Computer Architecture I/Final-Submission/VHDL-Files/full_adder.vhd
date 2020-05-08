--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY full_adder IS
	PORT (
		A : IN std_logic;
		B : IN std_logic;
		Cin : IN std_logic;
		S : OUT std_logic;
		Cout : OUT std_logic
	);
END full_adder;

ARCHITECTURE Behavioral OF full_adder IS

	SIGNAL S0, S1, S2 : std_logic;

BEGIN

	S <= (A XOR B) XOR Cin AFTER 1ns;
	Cout <= ((A XOR B) AND Cin) OR (A AND B) AFTER 1ns;

END Behavioral;