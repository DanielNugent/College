-- Company: Trinity College
-- Engineer: Daniel Nugent

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY multiplexer8_16 IS
    PORT (
        s : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        in0 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        in1 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        in2 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        in3 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        in4 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        in5 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        in6 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        in7 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        z : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END multiplexer8_16;

ARCHITECTURE Behavioral OF multiplexer8_16 IS

BEGIN

    PROCESS (s, in1, in2, in3, in4)
    BEGIN
        CASE s IS
            WHEN "000" => z <= in0;
            WHEN "001" => z <= in1;
            WHEN "010" => z <= in2;
            WHEN "011" => z <= in3;
            WHEN "100" => z <= in4;
            WHEN "101" => z <= in5;
            WHEN "110" => z <= in6;
            WHEN "111" => z <= in7;
            WHEN OTHERS => z <= in1;
        END CASE;
    END PROCESS;

END Behavioral;