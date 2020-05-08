--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux8_1bit_tb IS
    --  Port ( );
END mux8_1bit_tb;

ARCHITECTURE Behavioral OF mux8_1bit_tb IS
    -- declare component to test
    COMPONENT mux8_1bit IS
        PORT (
            In0 : IN std_logic;
            In1 : IN std_logic;
            In2 : IN std_logic;
            In3 : IN std_logic;
            In4 : IN std_logic;
            In5 : IN std_logic;
            In6 : IN std_logic;
            In7 : IN std_logic;
            S0 : IN std_logic;
            S1 : IN std_logic;
            S2 : IN std_logic;
            Z : OUT std_logic
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs    
    SIGNAL In0 : std_logic := '0';
    SIGNAL In1 : std_logic := '0';
    SIGNAL In2 : std_logic := '0';
    SIGNAL In3 : std_logic := '0';
    SIGNAL In4 : std_logic := '0';
    SIGNAL In5 : std_logic := '0';
    SIGNAL In6 : std_logic := '0';
    SIGNAL In7 : std_logic := '0';
    SIGNAL S0 : std_logic := '0';
    SIGNAL S1 : std_logic := '0';
    SIGNAL S2 : std_logic := '0';

    --outputs    
    SIGNAL Z : std_logic := '0';

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : mux8_1bit
    PORT MAP(
        In0 => In0,
        In1 => In1,
        In2 => In2,
        In3 => In3,
        In4 => In4,
        In5 => In5,
        In6 => In6,
        In7 => In7,
        S0 => S0,
        S1 => S1,
        S2 => S2,
        Z => Z
    );

    simulation_process : PROCESS
    BEGIN
        --Test Select In0
        In0 <= '1';
        S0 <= '0';
        S1 <= '0';
        S2 <= '0';
        WAIT FOR 10ns;

        --Test Select In1
        In0 <= '0';
        In1 <= '1';
        S0 <= '1';
        S1 <= '0';
        S2 <= '0';
        WAIT FOR 10ns;

        --Test Select In2
        In1 <= '0';
        In2 <= '1';
        S0 <= '0';
        S1 <= '1';
        S2 <= '0';
        WAIT FOR 10ns;

        --Test Select In3
        In2 <= '0';
        In3 <= '1';
        S0 <= '1';
        S1 <= '1';
        S2 <= '0';
        WAIT FOR 10ns;

        --Test Select In4
        In3 <= '0';
        In4 <= '1';
        S0 <= '0';
        S1 <= '0';
        S2 <= '1';
        WAIT FOR 10ns;

        --Test Select In5
        In4 <= '0';
        In5 <= '1';
        S0 <= '1';
        S1 <= '0';
        S2 <= '1';
        WAIT FOR 10ns;

        --Test Select In6
        In5 <= '0';
        In6 <= '1';
        S0 <= '0';
        S1 <= '1';
        S2 <= '1';
        WAIT FOR 10ns;

        --Test Select In7
        In6 <= '0';
        In7 <= '1';
        S0 <= '1';
        S1 <= '1';
        S2 <= '1';
        WAIT FOR 10ns;
    END PROCESS;
END Behavioral;