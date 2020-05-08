--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY microprogrammed_control_tb IS
    --  Port ( );
END microprogrammed_control_tb;

ARCHITECTURE Behavioral OF microprogrammed_control_tb IS

    COMPONENT microprogrammed_control
        PORT (
            Vflag, Cflag, Nflag, Zflag : IN std_logic;
            instruction : IN std_logic_vector(15 DOWNTO 0);
            clk : IN std_logic;
            reset : IN std_logic;

            PCout : OUT std_logic_vector(15 DOWNTO 0);

            TD : OUT std_logic;
            TA : OUT std_logic;
            TB : OUT std_logic;
            MB : OUT std_logic;
            FS : OUT std_logic_vector(4 DOWNTO 0);
            MD : OUT std_logic;
            RW : OUT std_logic;
            MM : OUT std_logic;
            MW : OUT std_logic;

            PL : OUT std_logic;
            PI : OUT std_logic;
            IL : OUT std_logic;
            MC : OUT std_logic;
            MS : OUT std_logic_vector(2 DOWNTO 0);
            NA : OUT std_logic_vector(7 DOWNTO 0);

            DR : OUT std_logic_vector(2 DOWNTO 0);
            SA : OUT std_logic_vector(2 DOWNTO 0);
            SB : OUT std_logic_vector(2 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL Vflag, Cflag, Nflag, Zflag : std_logic;
    SIGNAL instruction : std_logic_vector(15 DOWNTO 0);
    SIGNAL clk : std_logic;
    SIGNAL reset : std_logic;
    SIGNAL PC : std_logic_vector(15 DOWNTO 0);
    SIGNAL TD : std_logic;
    SIGNAL TA : std_logic;
    SIGNAL TB : std_logic;
    SIGNAL MB : std_logic;
    SIGNAL FS : std_logic_vector(4 DOWNTO 0);
    SIGNAL MD : std_logic;
    SIGNAL RW : std_logic;
    SIGNAL MM : std_logic;
    SIGNAL MW : std_logic;

    SIGNAL PL : std_logic;
    SIGNAL PI : std_logic;
    SIGNAL IL : std_logic;
    SIGNAL MC : std_logic;
    SIGNAL MS : std_logic_vector(2 DOWNTO 0);
    SIGNAL NA : std_logic_vector(7 DOWNTO 0);

    SIGNAL DR : std_logic_vector(2 DOWNTO 0);
    SIGNAL SA : std_logic_vector(2 DOWNTO 0);
    SIGNAL SB : std_logic_vector(2 DOWNTO 0);

BEGIN

    UTT : microprogrammed_control
    PORT MAP(
        Vflag => Vflag,
        Cflag => Cflag,
        Nflag => Nflag,
        Zflag => Zflag,
        instruction => instruction,
        clk => clk,
        reset => reset,
        PCout => PC,
        TD => TD,
        TA => TA,
        TB => TB,
        MB => MB,
        FS => FS,
        MD => MD,
        RW => RW,
        MM => MM,
        MW => MW,

        PL => PL,
        PI => PI,
        IL => IL,
        MC => MC,
        MS => MS,
        NA => NA,

        DR => DR,
        SA => SA,
        SB => SB
    );

    PROCESS
    BEGIN
        Vflag <= '0';
        Cflag <= '0';
        Nflag <= '0';
        Zflag <= '0';

        --Test RESET
        clk <= '1';
        reset <= '1';
        WAIT FOR 50 ns;
        clk <= '0';
        reset <= '0';
        WAIT FOR 50ns;

        --Pass an empty instruction 
        instruction <= x"0000";

        --Wait three clock cycles, fetch, decode, execute
        clk <= '1';
        WAIT FOR 50ns;
        clk <= '0';
        WAIT FOR 50ns;

        clk <= '1';
        WAIT FOR 50ns;
        clk <= '0';
        WAIT FOR 50ns;
        clk <= '1';
        WAIT FOR 50ns;
        clk <= '0';
        WAIT FOR 50ns;

        --Pass the instruction 0x0400
        instruction <= x"0400";
        --
        --  OPCODE     DR   SA   SB
        --[0000 010][000][000][000]
        ---------------------------------------------- 

        --Wait three clock cycles, fetch, decode, execute
        clk <= '1';
        WAIT FOR 50ns;
        clk <= '0';
        WAIT FOR 50ns;

        clk <= '1';
        WAIT FOR 50ns;
        clk <= '0';
        WAIT FOR 50ns;

        clk <= '1';
        WAIT FOR 50ns;
        clk <= '0';
        WAIT FOR 50ns;
    END PROCESS;

END Behavioral;