--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY IR_tb IS
    --  Port ( );
END IR_tb;

ARCHITECTURE Behavioral OF IR_tb IS

    -- declare component to test
    COMPONENT IR IS
        PORT (
            IR_IN : IN std_logic_vector(15 DOWNTO 0);
            IL : IN std_logic;
            CLK : IN std_logic;
            OPCODE : OUT std_logic_vector(6 DOWNTO 0);
            DR : OUT std_logic_vector(2 DOWNTO 0);
            SA : OUT std_logic_vector(2 DOWNTO 0);
            SB : OUT std_logic_vector(2 DOWNTO 0)
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs    
    SIGNAL IR_IN : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL IL : std_logic := '0';
    SIGNAL CLK : std_logic := '0';

    --outputs
    SIGNAL OPCODE : std_logic_vector(6 DOWNTO 0) := "0000000";
    SIGNAL DR : std_logic_vector(2 DOWNTO 0) := "000";
    SIGNAL SA : std_logic_vector(2 DOWNTO 0) := "000";
    SIGNAL SB : std_logic_vector(2 DOWNTO 0) := "000";

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : IR
    PORT MAP(
        IR_IN => IR_IN,
        IL => IL,
        CLK => CLK,
        OPCODE => OPCODE,
        DR => DR,
        SA => SA,
        SB => SB
    );

    simulation_process : PROCESS
    BEGIN

        --Test loading random IR_IN (0xFFAB)
        -----------------------------------
        --OPCODE = 1111 111 (7F)
        --DR = 110 (6)
        --SA = 101 (5)
        --SB = 011 (3)

        IR_IN <= x"FFAB";
        IL <= '1';
        CLK <= '1';
        WAIT FOR 10ns;

        CLK <= '0';
        WAIT FOR 10ns;

        --Test loading blank IR_IN (0x0000)
        -----------------------------------
        --OPCODE = 0000 000 
        --DR = 000
        --SA = 000
        --SB = 000

        IR_IN <= x"0000";
        IL <= '1';
        CLK <= '1';
        WAIT FOR 10ns;

        CLK <= '0';
        WAIT FOR 10ns;

        --Test IL low (IL = 0) Shouldn't change outputs
        -----------------------------------
        --OPCODE = 0000 000 
        --DR = 000
        --SA = 000
        --SB = 000

        IR_IN <= x"FCDA";
        IL <= '0';
        CLK <= '1';
        WAIT FOR 1ns;

        CLK <= '0';
        WAIT FOR 10ns;

    END PROCESS;

END Behavioral;