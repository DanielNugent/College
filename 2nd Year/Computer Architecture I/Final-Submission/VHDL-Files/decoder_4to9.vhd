--Daniel Nugent

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY decoder_4to9 IS
	PORT (
		des : IN std_logic_vector(3 DOWNTO 0);
		RW : IN std_logic;
		Q0 : OUT std_logic;
		Q1 : OUT std_logic;
		Q2 : OUT std_logic;
		Q3 : OUT std_logic;
		Q4 : OUT std_logic;
		Q5 : OUT std_logic;
		Q6 : OUT std_logic;
		Q7 : OUT std_logic;
		Q8 : OUT std_logic
	);
END decoder_4to9;

ARCHITECTURE Behavioral OF decoder_4to9 IS
BEGIN
	Q0 <= '1' AFTER 5ns WHEN des = "0000" AND RW = '1' ELSE
		'0' AFTER 5ns;
	Q1 <= '1' AFTER 5ns WHEN des = "0001" AND RW = '1' ELSE
		'0' AFTER 5ns;
	Q2 <= '1' AFTER 5ns WHEN des = "0010" AND RW = '1' ELSE
		'0' AFTER 5ns;
	Q3 <= '1' AFTER 5ns WHEN des = "0011" AND RW = '1' ELSE
		'0' AFTER 5ns;
	Q4 <= '1' AFTER 5ns WHEN des = "0100" AND RW = '1' ELSE
		'0' AFTER 5ns;
	Q5 <= '1' AFTER 5ns WHEN des = "0101" AND RW = '1' ELSE
		'0' AFTER 5ns;
	Q6 <= '1' AFTER 5ns WHEN des = "0110" AND RW = '1' ELSE
		'0' AFTER 5ns;
	Q7 <= '1' AFTER 5ns WHEN des = "0111" AND RW = '1' ELSE
		'0' AFTER 5ns;
	Q8 <= '1' AFTER 5ns WHEN des = "1000" AND RW = '1' ELSE
		'0' AFTER 5ns;
END Behavioral;