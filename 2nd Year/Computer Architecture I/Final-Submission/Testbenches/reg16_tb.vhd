--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY reg16_tb IS
    --  Port ( );
END reg16_tb;

ARCHITECTURE Behavioral OF reg16_tb IS

    -- declare component to test
    COMPONENT reg16 IS
        PORT (
            D : IN std_logic_vector(15 DOWNTO 0);
            load : IN std_logic;
            Clk : IN std_logic;
            Q : OUT std_logic_vector(15 DOWNTO 0)
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs    
    SIGNAL D : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL Clk : std_logic := '0';
    SIGNAL load : std_logic := '0';

    --outputs
    SIGNAL Q : std_logic_vector(15 DOWNTO 0) := x"0000";

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : reg16
    PORT MAP(
        D => D,
        Clk => Clk,
        load => load,
        Q => Q
    );

    simulation_process : PROCESS
    BEGIN
        --check that when load is 0 output stays the same (0x0000)
        D <= x"000A";
        load <= '0';
        Clk <= '0';
        WAIT FOR 10ns;

        --check that when load is 1 & clk is 0 output stays the same
        load <= '1';
        WAIT FOR 10ns;

        --check that when clk is 1 and load is 1 output changes to 0x000A
        Clk <= '1';
        WAIT FOR 10ns;

        --check that when load is 0 remains as 0x000A
        D <= x"00FF";
        load <= '0';
        Clk <= '0';
        WAIT FOR 10ns;

        --check that when load is 1 output changes to 0x00FF
        load <= '1';
        Clk <= '1';
        WAIT FOR 10ns;

    END PROCESS;

END Behavioral;