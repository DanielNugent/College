--Daniel Nugent
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY mux2_1bit_tb IS
    --  Port ( );
END mux2_1bit_tb;

ARCHITECTURE Behavioral OF mux2_1bit_tb IS
    -- declare component to test
    COMPONENT mux2_1bit IS
        PORT (
            Sel, In0, In1 : IN std_logic;
            mux_out : OUT std_logic
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    SIGNAL Sel : std_logic := '0';
    SIGNAL In0 : std_logic := '0';
    SIGNAL In1 : std_logic := '0';
    SIGNAL mux_out : std_logic := '0';

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : mux2_1bit
    PORT MAP(
        Sel => Sel,
        In0 => In0,
        In1 => In1,
        mux_out => mux_out
    );

    simulation_process : PROCESS
    BEGIN

        In0 <= '0';
        In1 <= '1';

        --Select line 1 and send '1' to output line mux_out
        Sel <= '0';
        WAIT FOR 1ns;

        --Select line 0 and send '0' to output line mux_out
        Sel <= '1';
        WAIT FOR 1ns;

    END PROCESS;

END Behavioral;