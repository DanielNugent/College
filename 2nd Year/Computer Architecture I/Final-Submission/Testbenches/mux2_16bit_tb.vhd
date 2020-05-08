--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux2_16bit_tb IS
    --  Port ( );
END mux2_16bit_tb;

ARCHITECTURE Behavioral OF mux2_16bit_tb IS

    -- declare component to test
    COMPONENT mux2_16bit IS
        PORT (
            In0 : IN std_logic_vector(15 DOWNTO 0);
            In1 : IN std_logic_vector(15 DOWNTO 0);
            s : IN std_logic;
            Z : OUT std_logic_vector(15 DOWNTO 0)
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs    
    SIGNAL In0 : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL In1 : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL s : std_logic := '0';

    --outputs
    SIGNAL Z : std_logic_vector(15 DOWNTO 0) := x"0000";

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : mux2_16bit
    PORT MAP(
        In0 => In0,
        In1 => In1,
        s => s,
        Z => Z
    );

    simulation_process : PROCESS
    BEGIN

        In0 <= x"00FF";
        In1 <= x"00AA";

        --Select line 0 (data input) and send 0x00FF to output line Z
        s <= '0';
        WAIT FOR 1ns;

        --Select line 1 (register data) and send 0x00AA to output line Z
        s <= '1';
        WAIT FOR 1ns;

    END PROCESS;

END Behavioral;