--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY arithmetic_unit IS
    PORT (
        A : IN std_logic;
        B : IN std_logic;
        Cin : IN std_logic;
        Cout : OUT std_logic;
        S0 : IN std_logic;
        S1 : IN std_logic;
        Z : OUT std_logic
    );
END arithmetic_unit;

ARCHITECTURE Behavioral OF arithmetic_unit IS

    COMPONENT full_adder
        PORT (
            A : IN std_logic;
            B : IN std_logic;
            Cin : IN std_logic;
            Cout : OUT std_logic;
            S : OUT std_logic
        );
    END COMPONENT;

    SIGNAL newInput : std_logic;

BEGIN

    newInput <= (B AND S0) OR ((NOT B) AND S1);

    AC : full_adder
    PORT MAP(
        A => A,
        B => newInput,
        Cin => Cin,
        Cout => Cout,
        S => Z
    );

END Behavioral;