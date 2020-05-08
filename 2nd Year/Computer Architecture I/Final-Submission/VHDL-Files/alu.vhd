--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY alu IS
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
END alu;

ARCHITECTURE Behavioral OF alu IS

    COMPONENT logic_unit
        PORT (
            S0 : IN std_logic;
            S1 : IN std_logic;
            A : IN std_logic;
            B : IN std_logic;
            G : OUT std_logic
        );
    END COMPONENT;

    COMPONENT arithmetic_unit
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

    COMPONENT mux2_1bit
        PORT (
            In0 : IN std_logic;
            In1 : IN std_logic;
            Sel : IN std_logic;
            mux_out : OUT std_logic
        );
    END COMPONENT;

    SIGNAL adder_out, logic_out : std_logic;

BEGIN
    LU : logic_unit
    PORT MAP(
        S0 => S0,
        S1 => S1,
        A => A,
        B => B,
        G => logic_out
    );

    AU : arithmetic_unit
    PORT MAP(
        A => A,
        B => B,
        Cin => Cin,
        Cout => Cout,
        S0 => S0,
        S1 => S1,
        Z => adder_out
    );

    MUX : mux2_1bit
    PORT MAP(
        In0 => adder_out,
        In1 => logic_out,
        Sel => S2,
        mux_out => G
    );

END Behavioral;