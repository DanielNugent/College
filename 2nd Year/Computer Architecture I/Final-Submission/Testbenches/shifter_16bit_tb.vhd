--Daniel Nugent
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY shifter_16bit_tb IS
    --  Port ( );
END shifter_16bit_tb;

ARCHITECTURE Behavioral OF shifter_16bit_tb IS

    -- declare component to test
    COMPONENT shifter_16bit IS
        PORT (
            B : IN std_logic_vector (15 DOWNTO 0);
            FS : IN std_logic_vector (4 DOWNTO 0);
            Lr : IN std_logic;
            Ll : IN std_logic;
            H : OUT std_logic_vector (15 DOWNTO 0)
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs    
    SIGNAL B : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL FS : std_logic_vector(4 DOWNTO 0) := "00000";
    SIGNAL Lr : std_logic := '0';
    SIGNAL Ll : std_logic := '0';

    --outputs 
    SIGNAL H : std_logic_vector(15 DOWNTO 0) := x"0000";

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : shifter_16bit
    PORT MAP(
        B => B,
        FS => FS,
        Lr => Lr,
        Ll => Ll,
        H => H
    );

    simulation_process : PROCESS
    BEGIN
        --Check that incorrect FS code doesn't perform shift (H = 0x0000)
        B <= x"0FF0";
        FS <= "01100";
        WAIT FOR 1ns;

        --Check that FS = 10000 passes B (H = 0x0FF0)
        FS <= "10000";
        WAIT FOR 1ns;

        --Check that LSR works correctly... 0x0FF0 >> = 0x7F8
        FS <= "10100";
        WAIT FOR 1ns;

        --Check that LSL works correctly... 0x0FF0 << = 0x1FE0
        FS <= "11000";
        WAIT FOR 1ns;

    END PROCESS;

END Behavioral;