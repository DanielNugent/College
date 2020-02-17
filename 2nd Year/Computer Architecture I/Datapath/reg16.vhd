-- Company: Trinity College
-- Engineer: Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY reg16 IS
    PORT (
        D : IN std_logic_vector(15 DOWNTO 0);
        load0, load1, Clk : IN std_logic;
        Q : OUT std_logic_vector(15 DOWNTO 0));
END reg16;

ARCHITECTURE Behaviour OF reg16 IS

BEGIN
    PROCESS (Clk)
    BEGIN
        IF (rising_edge(Clk)) THEN
            IF (load0 = '1' AND load1 = '1') THEN
                Q <= D AFTER 1ns;
            END IF;
        END IF;
    END PROCESS;
END Behaviour;