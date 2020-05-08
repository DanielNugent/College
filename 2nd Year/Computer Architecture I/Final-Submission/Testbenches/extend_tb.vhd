--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY extend_tb IS
    --  Port ( );
END extend_tb;

ARCHITECTURE Behavioral OF extend_tb IS

    -- declare component to test
    COMPONENT Extend IS
        PORT (
            DR_SB : IN std_logic_vector(5 DOWNTO 0);
            Ext : OUT std_logic_vector(15 DOWNTO 0)
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs    
    SIGNAL DR_SB : std_logic_vector(5 DOWNTO 0) := "000000";

    --outputs
    SIGNAL Ext : std_logic_vector(15 DOWNTO 0) := x"0000";

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : Extend
    PORT MAP(
        DR_SB => DR_SB,
        Ext => Ext
    );

    simulation_process : PROCESS
    BEGIN

        --Test non zero value (non-leading zeros)
        DR_SB <= "011111";
        WAIT FOR 10ns;

        --Test non zero value (leading zero)
        DR_SB <= "111111";
        WAIT FOR 10ns;

        WAIT;
    END PROCESS;

END Behavioral;