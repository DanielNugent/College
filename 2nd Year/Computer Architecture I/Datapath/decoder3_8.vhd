-- Company: Trinity College
-- Engineer: Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY decoder3_8 IS
    PORT (
        s : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        z0 : OUT std_logic;
        z1 : OUT std_logic;
        z2 : OUT std_logic;
        z3 : OUT std_logic;
        z4 : OUT std_logic;
        z5 : OUT std_logic;
        z6 : OUT std_logic;
        z7 : OUT std_logic);
END decoder3_8;

ARCHITECTURE Behaviour OF decoder3_8 IS
BEGIN
    z0 <= NOT(s(2)) AND NOT(s(1)) AND NOT(s(0)) AFTER 1ns;
    z1 <= NOT(s(2)) AND NOT(s(1)) AND s(0) AFTER 1ns;
    z2 <= NOT(s(2)) AND s(1) AND NOT(s(0)) AFTER 1ns;
    z3 <= NOT(s(2)) AND s(1) AND s(0) AFTER 1ns;
    z4 <= s(2) AND NOT(s(1)) AND NOT(s(0)) AFTER 1ns;
    z5 <= s(2) AND NOT(s(1)) AND s(0) AFTER 1ns;
    z6 <= s(2) AND s(1) AND NOT(s(0)) AFTER 1ns;
    z7 <= s(2) AND s(1) AND s(0) AFTER 1ns;
END Behaviour;