--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY alu_tb IS

END alu_tb;

ARCHITECTURE Behavioral OF alu_tb IS

    COMPONENT alu IS
        PORT (
            Cin : IN std_logic;
            A : IN std_logic;
            B : IN std_logic;
            S0 : IN std_logic;
            S1 : IN std_logic;
            S2 : IN std_logic;
            G : OUT std_logic;
            Cout : OUT std_logic
        );
    END COMPONENT;
    SIGNAL A : std_logic := '0';
    SIGNAL B : std_logic := '0';
    SIGNAL Cin : std_logic := '0';
    SIGNAL S0 : std_logic := '0';
    SIGNAL S1 : std_logic := '0';
    SIGNAL S2 : std_logic := '0';
    SIGNAL Cout : std_logic := '0';
    SIGNAL G : std_logic := '0';

BEGIN

    UUT : alu
    PORT MAP(
        A => A,
        B => B,
        Cin => Cin,
        S0 => S0,
        S1 => S1,
        S2 => S2,
        Cout => Cout,
        G => G
    );

    simulation_process : PROCESS
    BEGIN

        A <= '0';
        B <= '0';
        Cin <= '0';
        S0 <= '0';
        S1 <= '0';
        WAIT FOR 2ns;
        A <= '1';
        B <= '0';
        Cin <= '0';
        S0 <= '0';
        S1 <= '0';
        S2 <= '0';
        WAIT FOR 2ns;

        A <= '1';
        B <= '0';
        Cin <= '1';
        S0 <= '0';
        S1 <= '0';
        S2 <= '0';
        WAIT FOR 2ns;

        A <= '1';
        B <= '1';
        Cin <= '0';
        S0 <= '1';
        S1 <= '0';
        S2 <= '0';
        WAIT FOR 2ns;

        A <= '1';
        B <= '1';
        Cin <= '1';
        S0 <= '1';
        S1 <= '0';
        S2 <= '0';
        WAIT FOR 2ns;
        A <= '1';
        B <= '0';
        Cin <= '0';
        S0 <= '0';
        S1 <= '1';
        S2 <= '0';
        WAIT FOR 2ns;

        A <= '1';
        B <= '0';
        Cin <= '1';
        S0 <= '0';
        S1 <= '1';
        S2 <= '0';
        WAIT FOR 2ns;

        A <= '1';
        B <= '0';
        Cin <= '0';
        S0 <= '1';
        S1 <= '1';
        S2 <= '0';
        WAIT FOR 2ns;

        A <= '0';
        B <= '0';
        Cin <= '1';
        S0 <= '1';
        S1 <= '1';
        S2 <= '0';
        WAIT FOR 2ns;

        A <= '1';
        B <= '1';
        Cin <= '0';
        S0 <= '0';
        S1 <= '0';
        S2 <= '1';
        WAIT FOR 2ns;
        A <= '1';
        B <= '0';
        Cin <= '0';
        S0 <= '1';
        S1 <= '0';
        S2 <= '1';
        WAIT FOR 2ns;
        A <= '1';
        B <= '0';
        Cin <= '0';
        S0 <= '0';
        S1 <= '1';
        S2 <= '1';
        WAIT FOR 2ns;
        A <= '1';
        B <= '0';
        Cin <= '0';
        S0 <= '1';
        S1 <= '1';
        S2 <= '1';
        WAIT FOR 2ns;

    END PROCESS;

END Behavioral;