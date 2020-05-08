--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY programme_cpu IS
    PORT (
        clk : IN std_logic;
        reset : IN std_logic;
        reg0 : OUT std_logic_vector(15 DOWNTO 0);
        reg1 : OUT std_logic_vector(15 DOWNTO 0);
        reg2 : OUT std_logic_vector(15 DOWNTO 0);
        reg3 : OUT std_logic_vector(15 DOWNTO 0);
        reg4 : OUT std_logic_vector(15 DOWNTO 0);
        reg5 : OUT std_logic_vector(15 DOWNTO 0);
        reg6 : OUT std_logic_vector(15 DOWNTO 0);
        reg7 : OUT std_logic_vector(15 DOWNTO 0)
    );
END programme_cpu;

ARCHITECTURE Behavioral OF programme_cpu IS

    -- Datapath
    COMPONENT datapath
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

            Vflag : OUT std_logic;
            Cflag : OUT std_logic;
            Nflag : OUT std_logic;
            Zflag : OUT std_logic
        );
    END COMPONENT;


    COMPONENT microprogrammed_control
        PORT (
            Vflag : IN std_logic;
            Cflag : IN std_logic;
            Nflag : IN std_logic;
            Zflag : IN std_logic;

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

    COMPONENT memory
        PORT (
            address : IN std_logic_vector(15 DOWNTO 0);
            data_in : IN std_logic_vector(15 DOWNTO 0);
            Clk : IN std_logic;
            MW : IN std_logic;
            data_out : OUT std_logic_vector(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL adr_out : std_logic_vector(15 DOWNTO 0);
    SIGNAL data_out : std_logic_vector(15 DOWNTO 0);

    SIGNAL VFlag : std_logic;
    SIGNAL CFlag : std_logic;
    SIGNAL NFlag : std_logic;
    SIGNAL ZFlag : std_logic;

    SIGNAL PC : std_logic_vector(15 DOWNTO 0);

    SIGNAL DR, SA, SB : std_logic_vector(2 DOWNTO 0);
    SIGNAL TD, TA, TB : std_logic;
    SIGNAL MB, MM, MW, MD : std_logic;

    SIGNAL FS : std_logic_vector(4 DOWNTO 0);

    SIGNAL RW : std_logic;

    SIGNAL memOut : std_logic_vector(15 DOWNTO 0);
    SIGNAL pcOut : std_logic_vector(15 DOWNTO 0);

BEGIN

    MC : microprogrammed_control PORT MAP(

        Vflag => VFlag,
        Cflag => CFlag,
        Nflag => NFlag,
        Zflag => Zflag,

        instruction => memOut,
        clk => clk,
        reset => reset,

        PCout => pcOut,

        MW => MW,
        MM => MM,
        MD => MD,
        MB => MB,

        FS => FS,
        RW => RW,

        TD => TD,
        TA => TA,
        TB => TB,

        DR => DR,
        SA => SA,
        SB => SB
    );

    DP : datapath PORT MAP(

        data_in => memOut,
        PC_in => pcOut,

        SB => SB,

        MB => MB,
        MD => MD,
        MM => MM,

        ASel(2 DOWNTO 0) => SA,
        ASel(3) => TA,
        BSel(2 DOWNTO 0) => SB,
        BSel(3) => TB,
        DSel(2 DOWNTO 0) => DR,
        DSel(3) => TD,

        FS => FS,
        RW => RW,
        Clk => clk,

        adr_out => adr_out,
        data_out => data_out,

        reg_0_data_out => reg0,
        reg_1_data_out => reg1,
        reg_2_data_out => reg2,
        reg_3_data_out => reg3,
        reg_4_data_out => reg4,
        reg_5_data_out => reg5,
        reg_6_data_out => reg6,
        reg_7_data_out => reg7,

        VFlag => VFlag,
        CFlag => CFlag,
        NFlag => NFlag,
        ZFlag => ZFlag
    );

    mem : memory PORT MAP(
        address => adr_out,
        data_in => data_out,
        clk => clk,
        MW => MW,
        data_out => memOut
    );

END Behavioral;