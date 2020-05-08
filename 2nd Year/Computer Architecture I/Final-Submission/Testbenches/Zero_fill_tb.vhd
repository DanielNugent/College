--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Zero_fill_tb IS
    --  Port ( );
END Zero_fill_tb;

ARCHITECTURE Behavioral OF Zero_fill_tb IS

    -- declare component to test
    COMPONENT Zero_fill IS
        PORT (
            SB : IN std_logic_vector(2 DOWNTO 0);
            zeroFill : OUT std_logic_vector(15 DOWNTO 0)
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs    
    SIGNAL SB : std_logic_vector(2 DOWNTO 0) := "000";

    --outputs
    SIGNAL zeroFill : std_logic_vector(15 DOWNTO 0) := x"0000";

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : Zero_fill
    PORT MAP(
        SB => SB,
        zeroFill => zeroFill
    );

    simulation_process : PROCESS
    BEGIN

        --Test non zero value
        SB <= "111";
        WAIT FOR 10ns;

        --Test another value
        SB <= "101";
        WAIT FOR 10ns;

        WAIT;
    END PROCESS;

END Behavioral;