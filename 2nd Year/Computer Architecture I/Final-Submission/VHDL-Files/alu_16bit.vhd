--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- 16-bit alu 
ENTITY alu_16bit IS
    PORT (
        A : IN std_logic_vector(15 DOWNTO 0); 
        B : IN std_logic_vector(15 DOWNTO 0);
        Gsel : IN std_logic_vector(3 DOWNTO 0); 
        F : OUT std_logic_vector(15 DOWNTO 0); 
        V : OUT std_logic;
        C : OUT std_logic; 
        N : OUT std_logic;
        Z : OUT std_logic
    );
END alu_16bit;

ARCHITECTURE Behavioral OF alu_16bit IS

    COMPONENT alu
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

    COMPONENT zero_detect
        PORT (
            I : IN std_logic_vector(15 DOWNTO 0);
            O : OUT std_logic
        );
    END COMPONENT;

    SIGNAL C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, Cout, Zout : std_logic;
    SIGNAL result : std_logic_vector(15 DOWNTO 0);

BEGIN


    alu00 : alu
    PORT MAP(
        Cin => Gsel(0),
        A => A(0),
        B => B(0),
        S0 => Gsel(1),
        S1 => Gsel(2),
        S2 => Gsel(3),
        G => result(0),
        Cout => C1
    );

    alu01 : alu
    PORT MAP(
        Cin => C1,
        A => A(1),
        B => B(1),
        S0 => Gsel(1),
        S1 => Gsel(2),
        S2 => Gsel(3),
        G => result(1),
        Cout => C2
    );

    alu02 : alu
    PORT MAP(
        Cin => C2,
        A => A(2),
        B => B(2),
        S0 => Gsel(1),
        S1 => Gsel(2),
        S2 => Gsel(3),
        G => result(2),
        Cout => C3
    );

    alu03 : alu
    PORT MAP(
        Cin => C3,
        A => A(3),
        B => B(3),
        S0 => Gsel(1),
        S1 => Gsel(2),
        S2 => Gsel(3),
        G => result(3),
        Cout => C4
    );

    alu04 : alu
    PORT MAP(
        Cin => C4,
        A => A(4),
        B => B(4),
        S0 => Gsel(1),
        S1 => Gsel(2),
        S2 => Gsel(3),
        G => result(4),
        Cout => C5
    );

    alu05 : alu
    PORT MAP(
        Cin => C5,
        A => A(5),
        B => B(5),
        S0 => Gsel(1),
        S1 => Gsel(2),
        S2 => Gsel(3),
        G => result(5),
        Cout => C6
    );

    alu06 : alu
    PORT MAP(
        Cin => C6,
        A => A(6),
        B => B(6),
        S0 => Gsel(1),
        S1 => Gsel(2),
        S2 => Gsel(3),
        G => result(6),
        Cout => C7
    );

    alu07 : alu
    PORT MAP(
        Cin => C7,
        A => A(7),
        B => B(7),
        S0 => Gsel(1),
        S1 => Gsel(2),
        S2 => Gsel(3),
        G => result(7),
        Cout => C8
    );

    alu08 : alu
    PORT MAP(
        Cin => C8,
        A => A(8),
        B => B(8),
        S0 => Gsel(1),
        S1 => Gsel(2),
        S2 => Gsel(3),
        G => result(8),
        Cout => C9
    );

    alu09 : alu
    PORT MAP(
        Cin => C9,
        A => A(9),
        B => B(9),
        S0 => Gsel(1),
        S1 => Gsel(2),
        S2 => Gsel(3),
        G => result(9),
        Cout => C10
    );

    alu10 : alu
    PORT MAP(
        Cin => C10,
        A => A(10),
        B => B(10),
        S0 => Gsel(1),
        S1 => Gsel(2),
        S2 => Gsel(3),
        G => result(10),
        Cout => C11
    );

    alu11 : alu
    PORT MAP(
        Cin => C11,
        A => A(11),
        B => B(11),
        S0 => Gsel(1),
        S1 => Gsel(2),
        S2 => Gsel(3),
        G => result(11),
        Cout => C12
    );

    alu12 : alu
    PORT MAP(
        Cin => C12,
        A => A(12),
        B => B(12),
        S0 => Gsel(1),
        S1 => Gsel(2),
        S2 => Gsel(3),
        G => result(12),
        Cout => C13
    );

    alu13 : alu
    PORT MAP(
        Cin => C13,
        A => A(13),
        B => B(13),
        S0 => Gsel(1),
        S1 => Gsel(2),
        S2 => Gsel(3),
        G => result(13),
        Cout => C14
    );

    alu14 : alu
    PORT MAP(
        Cin => C14,
        A => A(14),
        B => B(14),
        S0 => Gsel(1),
        S1 => Gsel(2),
        S2 => Gsel(3),
        G => result(14),
        Cout => C15
    );

    alu15 : alu
    PORT MAP(
        Cin => C15,
        A => A(15),
        B => B(15),
        S0 => Gsel(1),
        S1 => Gsel(2),
        S2 => Gsel(3),
        G => result(15),
        Cout => Cout
    );

    F <= result;

    z_detect : zero_detect
    PORT MAP(
        I => result,
        O => Zout
    );

    V <= (C15 XOR Cout) AFTER 1ns;
    C <= Cout AFTER 1ns;
    N <= result(15) AFTER 1ns;
    Z <= Zout AFTER 1ns;

END Behavioral;