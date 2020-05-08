--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux9_16bit_tb IS
    --  Port ( );
END mux9_16bit_tb;

ARCHITECTURE Behavioral OF mux9_16bit_tb IS
    -- declare component to test
    COMPONENT mux9_16bit IS
        PORT (
            In0 : IN std_logic_vector(15 DOWNTO 0);
            In1 : IN std_logic_vector(15 DOWNTO 0);
            In2 : IN std_logic_vector(15 DOWNTO 0);
            In3 : IN std_logic_vector(15 DOWNTO 0);
            In4 : IN std_logic_vector(15 DOWNTO 0);
            In5 : IN std_logic_vector(15 DOWNTO 0);
            In6 : IN std_logic_vector(15 DOWNTO 0);
            In7 : IN std_logic_vector(15 DOWNTO 0);
            In8 : IN std_logic_vector(15 DOWNTO 0);
            src : IN std_logic_vector(3 DOWNTO 0);
            Z : OUT std_logic_vector(15 DOWNTO 0)
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs    
    SIGNAL In0 : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL In1 : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL In2 : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL In3 : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL In4 : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL In5 : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL In6 : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL In7 : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL In8 : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL src : std_logic_vector(3 DOWNTO 0) := "0000";

    --outputs    
    SIGNAL Z : std_logic_vector(15 DOWNTO 0) := x"0000";

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : mux9_16bit
    PORT MAP(
        In0 => In0,
        In1 => In1,
        In2 => In2,
        In3 => In3,
        In4 => In4,
        In5 => In5,
        In6 => In6,
        In7 => In7,
        In8 => In8,
        src => src,
        Z => Z
    );

    simulation_process : PROCESS
    BEGIN
        --Give inputs unique values
        In0 <= x"00AA";
        In1 <= x"00BB";
        In2 <= x"00CC";
        In3 <= x"00DD";
        In4 <= x"00EE";
        In5 <= x"00FF";
        In6 <= x"0AAA";
        In7 <= x"0BBB";
        In8 <= x"0CCC";

        --Select line 0 and send 0x00AA to output line Z
        src <= "0000";
        WAIT FOR 1ns;

        --Select line 1 and send 0x00BB to output line Z
        src <= "0001";
        WAIT FOR 1ns;

        --Select line 2 and send 0x00CC to output line Z
        src <= "0010";
        WAIT FOR 1ns;

        --Select line 3 and send 0x00DD to output line Z
        src <= "0011";
        WAIT FOR 1ns;

        --Select line 4 and send 0x00EE to output line Z
        src <= "0100";
        WAIT FOR 1ns;

        --Select line 5 and send 0x00FF to output line Z
        src <= "0101";
        WAIT FOR 1ns;

        --Select line 6 and send 0x0AAA to output line Z
        src <= "0110";
        WAIT FOR 1ns;

        --Select line 7 and send 0x0BBB to output line Z
        src <= "0111";
        WAIT FOR 1ns;

        --Select line 8 and send 0x0CCC to output line Z
        src <= "1000";
        WAIT FOR 1ns;

    END PROCESS;

END Behavioral;