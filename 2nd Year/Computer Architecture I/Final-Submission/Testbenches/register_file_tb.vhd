--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY register_file_tb IS
    --  Port ( );
END register_file_tb;

ARCHITECTURE Behavioral OF register_file_tb IS

    -- declare component to test
    COMPONENT register_file IS
        PORT (
            DA : IN std_logic_vector(3 DOWNTO 0);
            AA : IN std_logic_vector(3 DOWNTO 0);
            BA : IN std_logic_vector(3 DOWNTO 0);

            Clk : IN std_logic;
            RW : IN std_logic;

            data : IN std_logic_vector(15 DOWNTO 0);

            a_out : OUT std_logic_vector(15 DOWNTO 0);
            b_out : OUT std_logic_vector(15 DOWNTO 0);

            reg0out : OUT std_logic_vector(15 DOWNTO 0);
            reg1out : OUT std_logic_vector(15 DOWNTO 0);
            reg2out : OUT std_logic_vector(15 DOWNTO 0);
            reg3out : OUT std_logic_vector(15 DOWNTO 0);
            reg4out : OUT std_logic_vector(15 DOWNTO 0);
            reg5out : OUT std_logic_vector(15 DOWNTO 0);
            reg6out : OUT std_logic_vector(15 DOWNTO 0);
            reg7out : OUT std_logic_vector(15 DOWNTO 0);
            reg8out : OUT std_logic_vector(15 DOWNTO 0)
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs
    SIGNAL AA : std_logic_vector(3 DOWNTO 0) := "0000";
    SIGNAL BA : std_logic_vector(3 DOWNTO 0) := "0000";
    SIGNAL DA : std_logic_vector(3 DOWNTO 0) := "0000";

    SIGNAL Clk : std_logic := '0';
    SIGNAL RW : std_logic := '0';

    SIGNAL data : std_logic_vector(15 DOWNTO 0) := x"0000";

    --outputs
    SIGNAL a_out : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL b_out : std_logic_vector(15 DOWNTO 0) := x"0000";

    --register values out
    SIGNAL reg0out : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL reg1out : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL reg2out : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL reg3out : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL reg4out : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL reg5out : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL reg6out : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL reg7out : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL reg8out : std_logic_vector(15 DOWNTO 0) := x"0000";

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : register_file
    PORT MAP(
        DA => DA,
        AA => AA,
        BA => BA,

        Clk => Clk,
        RW => RW,

        data => data,

        a_out => a_out,
        b_out => b_out,

        reg0out => reg0out,
        reg1out => reg1out,
        reg2out => reg2out,
        reg3out => reg3out,
        reg4out => reg4out,
        reg5out => reg5out,
        reg6out => reg6out,
        reg7out => reg7out,
        reg8out => reg8out
    );

    simulation_process : PROCESS
    BEGIN
        --Load all registers with values
        RW <= '1';

        --reg0
        data <= x"00FA";
        DA <= "0000";
        WAIT FOR 10ns;
        Clk <= '1';
        WAIT FOR 10ns;
        Clk <= '0';

        --reg1
        data <= x"00FB";
        DA <= "0001";
        WAIT FOR 10ns;
        Clk <= '1';
        WAIT FOR 10ns;
        Clk <= '0';

        --reg2
        data <= x"00FC";
        DA <= "0010";
        WAIT FOR 10ns;
        Clk <= '1';
        WAIT FOR 10ns;
        Clk <= '0';

        --reg3
        data <= x"00FD";
        DA <= "0011";
        WAIT FOR 10ns;
        Clk <= '1';
        WAIT FOR 10ns;
        Clk <= '0';

        --reg4
        data <= x"00FE";
        DA <= "0100";
        WAIT FOR 10ns;
        Clk <= '1';
        WAIT FOR 10ns;
        Clk <= '0';

        --reg5
        data <= x"00FF";
        DA <= "0101";
        WAIT FOR 10ns;
        Clk <= '1';
        WAIT FOR 10ns;
        Clk <= '0';

        --reg6
        data <= x"0FAA";
        DA <= "0110";
        WAIT FOR 10ns;
        Clk <= '1';
        WAIT FOR 10ns;
        Clk <= '0';

        --reg7
        data <= x"0FBB";
        DA <= "0111";
        WAIT FOR 10ns;
        Clk <= '1';
        WAIT FOR 10ns;
        Clk <= '0';

        --reg7
        data <= x"0FCC";
        DA <= "1000";
        WAIT FOR 10ns;
        Clk <= '1';
        WAIT FOR 10ns;
        Clk <= '0';

        --Aout should be reg0 = 0x00FA and Bout should be reg1 = 0x00FB
        AA <= "0000";
        BA <= "0001";
        WAIT FOR 10ns;

        --Aout should be reg2 = 0x00FC and Bout should be reg3 = 0x00FD
        AA <= "0010";
        BA <= "0011";
        WAIT FOR 10ns;

        --Aout should be reg4 = 0x00FE and Bout should be reg5 = 0x00FF
        AA <= "0100";
        BA <= "0101";
        WAIT FOR 10ns;

        --Aout should be reg6 = 0x0FAA and Bout should be reg7 = 0x0FBB
        AA <= "0110";
        BA <= "0111";
        WAIT FOR 10ns;

        --Aout should be reg8 (temp reg) = 0x0FAB and Bout should be reg8 (temp reg) = 0x0FAB
        AA <= "1000";
        BA <= "1000";
        WAIT FOR 10ns;

        WAIT;
    END PROCESS;

END Behavioral;