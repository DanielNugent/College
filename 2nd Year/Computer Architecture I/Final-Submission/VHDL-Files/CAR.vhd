--Daniel Nugent

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY CAR IS
    PORT (
        A : IN std_logic;
        B : IN std_logic_vector(7 DOWNTO 0);
        RESET : IN std_logic;
        CLK : IN std_logic;
        Z : OUT std_logic_vector(7 DOWNTO 0)
    );
END CAR;

ARCHITECTURE Behavioral OF CAR IS

BEGIN
    PROCESS (RESET, CLK)

        VARIABLE current : std_logic_vector(7 DOWNTO 0);
    BEGIN
        IF (RESET = '1') THEN
            current := x"C0";
        ELSIF (A = '1' AND CLK = '1') THEN
            current := B;
        END IF;
        Z <= current AFTER 10ns;
    END PROCESS;
END Behavioral;