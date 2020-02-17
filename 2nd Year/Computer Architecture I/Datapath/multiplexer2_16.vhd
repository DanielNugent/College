--------------------------------------------------------------------------------
-- Company: Trinity College
-- Engineer: Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY multiplexer2_16 IS
    PORT (
        s : IN std_logic;
        in1 : IN std_logic_vector(15 DOWNTO 0);
        in2 : IN std_logic_vector (15 DOWNTO 0);
        z : OUT std_logic_vector (15 DOWNTO 0));
END multiplexer2_16;

ARCHITECTURE Behavioral OF multiplexer2_16 IS
BEGIN
    PROCESS (s, in1, in2)
    BEGIN
        CASE s IS
            WHEN '0' => z <= in1;
            WHEN '1' => z <= in2;
            WHEN OTHERS => z <= in1;
        END CASE;
    END PROCESS;
END Behavioral;