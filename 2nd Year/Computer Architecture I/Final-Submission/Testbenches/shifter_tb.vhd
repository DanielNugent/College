--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY shifter_tb IS
    --  Port ( );
END shifter_tb;

ARCHITECTURE Behavioral OF shifter_tb IS

    -- declare component to test
    COMPONENT shifter IS
        PORT (
            In0 : IN std_logic;
            In1 : IN std_logic;
            In2 : IN std_logic;
            s : IN std_logic_vector(1 DOWNTO 0);
            Z : OUT std_logic
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs    
    SIGNAL In0 : std_logic := '0';
    SIGNAL In1 : std_logic := '0';
    SIGNAL In2 : std_logic := '0';
    SIGNAL s : std_logic_vector(1 DOWNTO 0) := "00";

    --outputs 
    SIGNAL Z : std_logic := '0';

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : shifter
    PORT MAP(
        In0 => In0,
        In1 => In1,
        In2 => In2,
        s => s,
        Z => Z
    );

    simulation_process : PROCESS
    BEGIN
        --Check that select 0 selects line 0 (1)
        In0 <= '1';
        In1 <= '0';
        In2 <= '1';
        s <= "00";
        WAIT FOR 1ns;

        --Check that select 1 selects line 1 (1)
        s <= "01";
        WAIT FOR 1ns;

        ---Check that select 2 selects line 2 (1)
        s <= "10";
        WAIT FOR 1ns;

    END PROCESS;

END Behavioral;