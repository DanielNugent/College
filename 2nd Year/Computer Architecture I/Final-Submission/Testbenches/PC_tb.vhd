--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY PC_tb IS
    --  Port ( );
END PC_tb;

ARCHITECTURE Behavioral OF PC_tb IS

    -- declare component to test
    COMPONENT PC IS
        PORT (
            PC_IN : IN std_logic_vector(15 DOWNTO 0);
            PL : IN std_logic;
            PI : IN std_logic;
            RESET : IN std_logic;
            Clk : IN std_logic;
            PC_OUT : OUT std_logic_vector(15 DOWNTO 0)
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs    
    SIGNAL PC_IN : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL PL : std_logic := '0';
    SIGNAL PI : std_logic := '0';
    SIGNAL Clk : std_logic := '0';
    SIGNAL RESET : std_logic := '0';

    --outputs
    SIGNAL PC_OUT : std_logic_vector(15 DOWNTO 0) := x"0000";

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : PC
    PORT MAP(
        PC_IN => PC_IN,
        PL => PL,
        PI => PI,
        RESET => RESET,
        Clk => Clk,
        PC_OUT => PC_OUT
    );

    simulation_process : PROCESS
    BEGIN
        --Test Reset 
        RESET <= '1';
        Clk <= '1';
        WAIT FOR 10ns;

        RESET <= '0';
        Clk <= '0';
        WAIT FOR 10ns;

        --Test passing withour increment PC_IN = 0xFFAB -> PC_OUT = 0xFFAB
        PC_IN <= x"FFAB";
        PL <= '1';
        PI <= '0';
        Clk <= '1';
        WAIT FOR 10ns;

        Clk <= '0';
        WAIT FOR 10ns;

        --Test incrementing with load low - PC_IN = 0xFF01 -> PC_OUT = 0xFFAC
        PC_IN <= x"FF01";
        PL <= '0';
        PI <= '1';
        Clk <= '1';
        WAIT FOR 10ns;

        Clk <= '0';
        WAIT FOR 10ns;

        --Test output when both PL and PI are 1
        PC_IN <= x"0003";
        PL <= '1';
        PI <= '1';
        Clk <= '1';
        WAIT FOR 10ns;

        Clk <= '0';
        WAIT FOR 10ns;

        --Test output when both PL and PI are 0
        PC_IN <= x"ABCD";
        PI <= '0';
        PL <= '0';
        Clk <= '1';
        WAIT FOR 10ns;

        Clk <= '0';
        WAIT FOR 10ns;

        --Test reset again
        RESET <= '1';
        Clk <= '1';
        WAIT FOR 10ns;

    END PROCESS;

END Behavioral;