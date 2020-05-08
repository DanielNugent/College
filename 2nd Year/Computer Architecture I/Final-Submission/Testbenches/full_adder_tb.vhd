--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY full_adder_tb IS
    --  Port ( );
END full_adder_tb;

ARCHITECTURE Behavioral OF full_adder_tb IS
    -- declare component to test
    COMPONENT full_adder IS
        PORT (
            A : IN STD_LOGIC;
            B : IN STD_LOGIC;
            Cin : IN STD_LOGIC;
            S : OUT STD_LOGIC;
            Cout : OUT STD_LOGIC
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs    
    SIGNAL A : std_logic := '0';
    SIGNAL B : std_logic := '0';
    SIGNAL Cin : std_logic := '0';

    --outputs
    SIGNAL S : std_logic := '0';
    SIGNAL Cout : std_logic := '0';

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : full_adder
    PORT MAP(
        A => A,
        B => B,
        Cin => Cin,
        S => S,
        Cout => Cout
    );

    simulation_process : PROCESS
    BEGIN
        --Check that 0+0+ Cin(1)... S=1, Cout=0 **
        WAIT FOR 1ns;
        A <= '0';
        B <= '0';
        Cin <= '1';
        WAIT FOR 1ns;

        --Check that 0+1+ Cin(0)... S=1, Cout=0 **
        A <= '0';
        B <= '1';
        Cin <= '0';
        WAIT FOR 1ns;

        --Check that 0+1+ Cin(1)... S=0, Cout=1 **
        A <= '0';
        B <= '1';
        Cin <= '1';
        WAIT FOR 1ns;

        --Check that 1+0+ Cin(0)... S=1, Cout=0 **
        A <= '1';
        B <= '0';
        Cin <= '0';
        WAIT FOR 1ns;

        --Check that 1+0+ Cin(1)... S=0, Cout=1 **
        A <= '1';
        B <= '0';
        Cin <= '1';
        WAIT FOR 1ns;

        --Check that 1+1+ Cin(0)... S=0, Cout=1 **
        A <= '1';
        B <= '1';
        Cin <= '0';
        WAIT FOR 1ns;

        --Check that 1+1+ Cin(1)... S=1, Cout=1 **
        A <= '1';
        B <= '1';
        Cin <= '1';
        WAIT FOR 1ns;

    END PROCESS;

END Behavioral;