--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY arithmetic_unit_tb IS
    --  Port ( );
END arithmetic_unit_tb;

ARCHITECTURE Behavioral OF arithmetic_unit_tb IS
    -- declare component to test
    COMPONENT arithmetic_unit IS
        PORT (
            A : IN std_logic;
            B : IN std_logic;
            Cin : IN std_logic;
            Cout : OUT std_logic;
            S0 : IN std_logic;
            S1 : IN std_logic;
            Z : OUT std_logic
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs
    SIGNAL A : std_logic := '0';
    SIGNAL B : std_logic := '0';
    SIGNAL Cin : std_logic := '0';
    SIGNAL S0 : std_logic := '0';
    SIGNAL S1 : std_logic := '0';

    --outputs
    SIGNAL Cout : std_logic := '0';
    SIGNAL Z : std_logic := '0';

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : arithmetic_unit
    PORT MAP(
        A => A,
        B => B,
        Cin => Cin,
        S0 => S0,
        S1 => S1,
        Cout => Cout,
        Z => Z
    );

    simulation_process : PROCESS
    BEGIN
        --Test F=A -> Z = '1', Cout = '0' **
        A <= '1';
        B <= '0';
        Cin <= '0';
        S0 <= '0';
        S1 <= '0';
        WAIT FOR 1ns;

        --Test F=A+1 -> Z = '0', Cout = '1' **
        A <= '1';
        B <= '0';
        Cin <= '1';
        S0 <= '0';
        S1 <= '0';
        WAIT FOR 1ns;

        --Test F=A+B -> Z = '0', Cout = '1' **
        A <= '1';
        B <= '1';
        Cin <= '0';
        S0 <= '1';
        S1 <= '0';
        WAIT FOR 1ns;

        --Test F=A+B+1 -> Z = '1', Cout = '1' **
        A <= '1';
        B <= '1';
        Cin <= '1';
        S0 <= '1';
        S1 <= '0';
        WAIT FOR 1ns;

        --Test F=A+B' -> Z = '1', Cout = '0' **
        A <= '1';
        B <= '1';
        Cin <= '0';
        S0 <= '0';
        S1 <= '1';
        WAIT FOR 1ns;

        --Test F=A+B'+1 -> Z = '0', Cout = '1'  **
        A <= '1';
        B <= '1';
        Cin <= '1';
        S0 <= '0';
        S1 <= '1';
        WAIT FOR 1ns;

        --Test F=A-1 -> Z = '0', Cout = '1' **
        A <= '1';
        B <= '0';
        Cin <= '0';
        S0 <= '1';
        S1 <= '1';
        WAIT FOR 1ns;

        --Test F=A -> Z = '1', Cout = '1' **
        A <= '1';
        B <= '0';
        Cin <= '1';
        S0 <= '1';
        S1 <= '1';
        WAIT FOR 1ns;

        --Test all 0's -> Z = '0', Cout = '0' **
        A <= '0';
        B <= '0';
        Cin <= '0';
        S0 <= '0';
        S1 <= '0';
        WAIT FOR 1ns;

    END PROCESS;

END Behavioral;