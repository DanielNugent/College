LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY decoder3_8_tb IS
END decoder3_8_tb;
ARCHITECTURE Behavioral OF decoder3_8_tb IS
    COMPONENT decoder3_8
        PORT (
            s : IN std_logic_vector(2 DOWNTO 0);
            z0 : OUT std_logic;
            z1 : OUT std_logic;
            z2 : OUT std_logic;
            z3 : OUT std_logic;
            z4 : OUT std_logic;
            z5 : OUT std_logic;
            z6 : OUT std_logic;
            z7 : OUT std_logic);
    END COMPONENT;
    SIGNAL s : std_logic_vector(2 DOWNTO 0);
    SIGNAL z0 : std_logic;
    SIGNAL z1 : std_logic;
    SIGNAL z2 : std_logic;
    SIGNAL z3 : std_logic;
    SIGNAL z4 : std_logic;
    SIGNAL z5 : std_logic;
    SIGNAL z6 : std_logic;
    SIGNAL z7 : std_logic;
BEGIN
    uut : decoder3_8 PORT MAP(
        s => s,
        z0 => z0,
        z1 => z1,
        z2 => z2,
        z3 => z3,
        z4 => z4,
        z5 => z5,
        z6 => z6,
        z7 => z7
    );
    stim_proc : PROCESS
    BEGIN
        WAIT FOR 10 ns;
        s <= "000";
        WAIT FOR 10 ns;
        s <= "001";
        WAIT FOR 10 ns;
        s <= "010";
        WAIT FOR 10 ns;
        s <= "011";
        WAIT FOR 10 ns;
        s <= "100";
        WAIT FOR 10 ns;
        s <= "101";
        WAIT FOR 10 ns;
        s <= "110";
        WAIT FOR 10 ns;
        s <= "111";
    END PROCESS;
END;