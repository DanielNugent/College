--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY decoder_3to8_tb IS
    --  Port ( );
END decoder_3to8_tb;

ARCHITECTURE Behavioral OF decoder_3to8_tb IS
    -- declare component to test
    COMPONENT decoder_3to8 IS
        PORT (
            des : IN std_logic_vector(2 DOWNTO 0);
            Q0 : OUT std_logic;
            Q1 : OUT std_logic;
            Q2 : OUT std_logic;
            Q3 : OUT std_logic;
            Q4 : OUT std_logic;
            Q5 : OUT std_logic;
            Q6 : OUT std_logic;
            Q7 : OUT std_logic
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs    
    SIGNAL des : std_logic_vector(2 DOWNTO 0) := "000";

    --outputs    
    SIGNAL Q0 : std_logic := '0';
    SIGNAL Q1 : std_logic := '0';
    SIGNAL Q2 : std_logic := '0';
    SIGNAL Q3 : std_logic := '0';
    SIGNAL Q4 : std_logic := '0';
    SIGNAL Q5 : std_logic := '0';
    SIGNAL Q6 : std_logic := '0';
    SIGNAL Q7 : std_logic := '0';

BEGIN
    -- instantiate component for test, connect ports to internal signals
    UUT : decoder_3to8
    PORT MAP(
        des => des,
        Q0 => Q0,
        Q1 => Q1,
        Q2 => Q2,
        Q3 => Q3,
        Q4 => Q4,
        Q5 => Q5,
        Q6 => Q6,
        Q7 => Q7
    );
    simulation_process : PROCESS
    BEGIN
        --Select line 0 (Q0 should be high/1)
        des <= "000";
        WAIT FOR 1ns;

        --Select line 1 (Q1 should be high/1)
        des <= "001";
        WAIT FOR 1ns;

        --Select line 2 (Q2 should be high/1)
        des <= "010";
        WAIT FOR 1ns;

        --Select line 3 (Q3 should be high/1)
        des <= "011";
        WAIT FOR 1ns;

        --Select line 4 (Q4 should be high/1)
        des <= "100";
        WAIT FOR 1ns;

        --Select line 5 (Q5 should be high/1)
        des <= "101";
        WAIT FOR 1ns;

        --Select line 6 (Q6 should be high/1)
        des <= "110";
        WAIT FOR 1ns;

        --Select line 7 (Q7 should be high/1)
        des <= "111";
        WAIT FOR 1ns;

    END PROCESS;

END Behavioral;