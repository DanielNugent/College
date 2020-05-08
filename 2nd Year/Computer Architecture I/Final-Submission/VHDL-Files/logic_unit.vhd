--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY logic_unit IS
    PORT (
        S0 : IN std_logic;
        S1 : IN std_logic;
        A : IN std_logic;
        B : IN std_logic;
        G : OUT std_logic
    );
END logic_unit;

ARCHITECTURE Behavioral OF logic_unit IS

BEGIN

    G <= (A AND B) AFTER 1ns WHEN S1 = '0' AND S0 = '0' ELSE
        (A OR B) AFTER 1ns WHEN S1 = '0' AND S0 = '1' ELSE
        (A XOR B) AFTER 1ns WHEN S1 = '1' AND S0 = '0' ELSE
        (NOT A) AFTER 1ns WHEN S1 = '1' AND S0 = '1';

END Behavioral;