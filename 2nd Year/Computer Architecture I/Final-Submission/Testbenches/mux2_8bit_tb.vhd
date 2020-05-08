--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux2_8bit_tb IS
    --  Port ( );
END mux2_8bit_tb;

ARCHITECTURE Behavioral OF mux2_8bit_tb IS

    -- declare component to test
    COMPONENT mux2_8bit IS
        PORT (
            In0 : IN std_logic_vector(7 DOWNTO 0);
            In1 : IN std_logic_vector(7 DOWNTO 0);
            Sel : IN std_logic;
            mux_out : OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs    
    SIGNAL In0 : std_logic_vector(7 DOWNTO 0) := x"00";
    SIGNAL In1 : std_logic_vector(7 DOWNTO 0) := x"00";
    SIGNAL Sel : std_logic := '0';

    --outputs
    SIGNAL mux_out : std_logic_vector(7 DOWNTO 0) := x"00";

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : mux2_8bit
    PORT MAP(
        In0 => In0,
        In1 => In1,
        Sel => Sel,
        mux_out => mux_out
    );

    simulation_process : PROCESS
    BEGIN

        In0 <= x"FF";
        In1 <= x"AA";

        --Select line 0 (data input) and send 0x00FF to output line Z
        Sel <= '0';
        WAIT FOR 1ns;

        --Select line 1 (register data) and send 0x00AA to output line Z
        Sel <= '1';
        WAIT FOR 1ns;

    END PROCESS;

END Behavioral;