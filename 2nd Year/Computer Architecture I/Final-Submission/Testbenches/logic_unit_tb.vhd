--Daniel Nugent

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY logic_unit_tb IS
    --  Port ( );
END logic_unit_tb;

ARCHITECTURE Behavioral OF logic_unit_tb IS
    -- declare component to test
    COMPONENT logic_unit IS
        PORT (
            S0 : IN std_logic;
            S1 : IN std_logic;
            A : IN std_logic;
            B : IN std_logic;
            G : OUT std_logic
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs
    SIGNAL A : std_logic := '0';
    SIGNAL B : std_logic := '0';
    SIGNAL S0 : std_logic := '0';
    SIGNAL S1 : std_logic := '0';

    --outputs
    SIGNAL G : std_logic := '0';

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : logic_unit
    PORT MAP(
        S0 => S0,
        S1 => S1,
        A => A,
        B => B,
        G => G
    );

    simulation_process : PROCESS
    BEGIN
        --Test F= A and B -> G = '1'
        A <= '1';
        B <= '1';
        S0 <= '0';
        S1 <= '0';
        WAIT FOR 1ns;

        --Test F= A or B -> G = '1'
        A <= '1';
        B <= '0';
        S0 <= '1';
        S1 <= '0';
        WAIT FOR 1ns;

        --Test F= A xor B -> G = '1'
        A <= '0';
        B <= '1';
        S0 <= '0';
        S1 <= '1';
        WAIT FOR 1ns;

        --Test F= not A -> G = '0'
        A <= '1';
        B <= '0';
        S0 <= '1';
        S1 <= '1';
        WAIT FOR 1ns;

    END PROCESS;

END Behavioral;