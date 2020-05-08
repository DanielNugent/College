--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CAR_tb IS
    --  Port ( );
END CAR_tb;

ARCHITECTURE Behavioral OF CAR_tb IS

    -- declare component to test
    COMPONENT CAR IS
        PORT (
            A : IN std_logic;
            B : IN std_logic_vector(7 DOWNTO 0);

            RESET : IN std_logic;
            CLK : IN std_logic;

            Z : OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs    
    SIGNAL A : std_logic := '0';
    SIGNAL B : std_logic_vector(7 DOWNTO 0) := x"00";

    SIGNAL RESET : std_logic := '0';
    SIGNAL CLK : std_logic := '0';

    --outputs
    SIGNAL Z : std_logic_vector(7 DOWNTO 0) := x"00";

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : CAR
    PORT MAP(
        A => A,
        B => B,
        RESET => RESET,
        CLK => CLK,
        Z => Z
    );

    simulation_process : PROCESS
    BEGIN
        --RESET First, reset address is 0xC0
        A <= '0';
        B <= x"00";
        RESET <= '1';
        CLK <= '1';
        WAIT FOR 10ns;

        CLK <= '0';
        RESET <= '0';
        WAIT FOR 10ns;

        --Test no passing (FLAGS_IN = 0) Z Should be 0xC0
        A <= '0';
        B <= x"FF";
        CLK <= '1';
        WAIT FOR 10ns;

        CLK <= '0';
        WAIT FOR 10ns;

        --Test CAR_IN (FLAGS_IN = 1) Z should be 0x01
        A <= '1';
        B <= x"01";
        CLK <= '1';
        WAIT FOR 10ns;

        --Test RESET, Z shoudl be 0xC0 (first instruction in memory)
        A <= '1';
        B <= x"FF";
        RESET <= '1';
        CLK <= '1';
        WAIT FOR 10ns;

        CLK <= '0';
        WAIT FOR 10ns;

    END PROCESS;

END Behavioral;