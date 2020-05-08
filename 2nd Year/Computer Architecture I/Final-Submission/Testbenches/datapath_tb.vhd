--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY datapath_tb IS
    --  Port ( );
END datapath_tb;

ARCHITECTURE Behavioral OF datapath_tb IS
    -- declare component to test
    COMPONENT datapath IS
        PORT (
            data_in : IN std_logic_vector(15 DOWNTO 0);

            PC_in : IN std_logic_vector(15 DOWNTO 0);

            SB : IN std_logic_vector(2 DOWNTO 0);

            MB : IN std_logic;
            MD : IN std_logic;
            MM : IN std_logic;

            Dsel : IN std_logic_vector(3 DOWNTO 0);
            Asel : IN std_logic_vector(3 DOWNTO 0);
            Bsel : IN std_logic_vector(3 DOWNTO 0);
            FS : IN std_logic_vector(4 DOWNTO 0);
            RW : IN std_logic;
            Clk : IN std_logic;

            adr_out : OUT std_logic_vector(15 DOWNTO 0);
            data_out : OUT std_logic_vector(15 DOWNTO 0);

            reg_0_data_out : OUT std_logic_vector(15 DOWNTO 0);
            reg_1_data_out : OUT std_logic_vector(15 DOWNTO 0);
            reg_2_data_out : OUT std_logic_vector(15 DOWNTO 0);
            reg_3_data_out : OUT std_logic_vector(15 DOWNTO 0);
            reg_4_data_out : OUT std_logic_vector(15 DOWNTO 0);
            reg_5_data_out : OUT std_logic_vector(15 DOWNTO 0);
            reg_6_data_out : OUT std_logic_vector(15 DOWNTO 0);
            reg_7_data_out : OUT std_logic_vector(15 DOWNTO 0);
            reg_8_data_out : OUT std_logic_vector(15 DOWNTO 0);

            Vflag : OUT std_logic;
            Cflag : OUT std_logic;
            Nflag : OUT std_logic;
            Zflag : OUT std_logic
        );
    END COMPONENT;
    -- signals for tests (initialise to 0)
    --inputs 
    SIGNAL data_in, PC_in : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL Dsel, Asel, Bsel : std_logic_vector(3 DOWNTO 0) := "0000";
    SIGNAL MB, MD, MM, RW, Clk : std_logic := '0';
    SIGNAL SB : std_logic_vector(2 DOWNTO 0) := "000";
    SIGNAL FS : std_logic_vector(4 DOWNTO 0) := "00000";
    --outputs
    SIGNAL Vflag, Cflag, Nflag, Zflag : std_logic := '0';
    SIGNAL adr_out : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL data_out : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL reg_0_data_out : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL reg_1_data_out : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL reg_2_data_out : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL reg_3_data_out : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL reg_4_data_out : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL reg_5_data_out : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL reg_6_data_out : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL reg_7_data_out : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL reg_8_data_out : std_logic_vector(15 DOWNTO 0) := x"0000";

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : datapath
    PORT MAP(
        data_in => data_in,

        PC_in => PC_in,

        SB => SB,

        MB => MB,
        MD => MD,
        MM => MM,

        Dsel => Dsel,
        Asel => Asel,
        Bsel => Bsel,

        FS => FS,
        RW => RW,
        Clk => Clk,

        adr_out => adr_out,
        data_out => data_out,

        reg_0_data_out => reg_0_data_out,
        reg_1_data_out => reg_1_data_out,
        reg_2_data_out => reg_2_data_out,
        reg_3_data_out => reg_3_data_out,
        reg_4_data_out => reg_4_data_out,
        reg_5_data_out => reg_5_data_out,
        reg_6_data_out => reg_6_data_out,
        reg_7_data_out => reg_7_data_out,
        reg_8_data_out => reg_8_data_out,

        Vflag => Vflag,
        Cflag => Cflag,
        Nflag => Nflag,
        Zflag => Zflag
    );

    simulation_process : PROCESS
    BEGIN
        --Test for the entire datapath as a whole

        ------------------------------------------------------------------

        --**LOADING REGISTER TESTS**--

        ------------------------------------------------------------------

        --Load all registers with values
        RW <= '1';
        MM <= '0';
        PC_in <= x"0000";
        MD <= '1';
        MB <= '0';

        --reg0
        data_in <= x"00FA";
        Dsel <= "0000";
        Clk <= '1';
        WAIT FOR 50ns;

        Clk <= '0';
        WAIT FOR 50ns;

        --reg1
        data_in <= x"00FB";
        Dsel <= "0001";
        Clk <= '1';
        WAIT FOR 50ns;

        Clk <= '0';
        WAIT FOR 50ns;

        --reg2
        data_in <= x"00FC";
        Dsel <= "0010";
        Clk <= '1';
        WAIT FOR 50ns;

        Clk <= '0';
        WAIT FOR 50ns;

        --reg3
        data_in <= x"00FD";
        Dsel <= "0011";
        Clk <= '1';
        WAIT FOR 50ns;

        Clk <= '0';
        WAIT FOR 50ns;

        --reg4
        data_in <= x"00FE";
        Dsel <= "0100";
        Clk <= '1';
        WAIT FOR 50ns;

        Clk <= '0';
        WAIT FOR 50ns;

        --reg5
        data_in <= x"00FF";
        Dsel <= "0101";
        Clk <= '1';
        WAIT FOR 50ns;

        Clk <= '0';
        WAIT FOR 50ns;

        --reg6
        data_in <= x"0FAA";
        Dsel <= "0110";
        Clk <= '1';
        WAIT FOR 50ns;

        Clk <= '0';
        WAIT FOR 50ns;

        --reg7
        data_in <= x"0FAB";
        Dsel <= "0111";
        Clk <= '1';
        WAIT FOR 50ns;

        Clk <= '0';
        WAIT FOR 50ns;

        --tempReg
        data_in <= x"0FAC";
        Dsel <= "1000";
        Clk <= '1';
        WAIT FOR 50ns;

        Clk <= '0';
        WAIT FOR 50ns;

        ------------------------------------------------------------------ 

        --**BUS TESTS**--

        ------------------------------------------------------------------

        --Test ABUS, select reg5 (0x00FF);  **
        Asel <= "0101";
        WAIT FOR 50ns;

        --Test BBUS, select reg3 (0x00FD); **
        Bsel <= "0011";
        WAIT FOR 50ns;

        --Test PC Load through
        RW <= '0';
        MM <= '1';
        MD <= '1';
        MB <= '0';

        PC_in <= x"CCCC";
        WAIT FOR 50ns;

        --Test MuxB
        SB <= "101";
        MB <= '1';
        WAIT FOR 50ns;

        WAIT;
    END PROCESS;

END Behavioral;