--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY zero_detect_tb IS
    --  Port ( );
END zero_detect_tb;

ARCHITECTURE Behavioral OF zero_detect_tb IS

    -- declare component to test
    COMPONENT zero_detect IS
        PORT (
            I : IN std_logic_vector(15 DOWNTO 0);
            O : OUT std_logic
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs    
    SIGNAL I : std_logic_vector(15 DOWNTO 0) := x"0000";

    --outputs
    SIGNAL O : std_logic := '0';

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : zero_detect
    PORT MAP(
        I => I,
        O => O
    );

    simulation_process : PROCESS
    BEGIN

        --Test non zero value
        I <= x"00FF";
        WAIT FOR 1ns;

        --Test zero value
        I <= x"0000";
        WAIT FOR 1ns;

        --Test non zero value
        I <= x"AFFF";
        WAIT FOR 1ns;

        --Test zero value
        I <= x"0000";
        WAIT FOR 1ns;

        WAIT;
    END PROCESS;

END Behavioral;