--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY microprogrammed_control IS
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

        --for testing
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
END microprogrammed_control;

ARCHITECTURE Behavioral OF microprogrammed_control IS
    COMPONENT control_memory
        PORT (
            MW : OUT std_logic;
            MM : OUT std_logic;
            RW : OUT std_logic;
            MD : OUT std_logic;
            FS : OUT std_logic_vector(4 DOWNTO 0);
            MB : OUT std_logic;
            TB : OUT std_logic;
            TA : OUT std_logic;
            TD : OUT std_logic;

            PL : OUT std_logic;
            PI : OUT std_logic;
            IL : OUT std_logic;
            MC : OUT std_logic;
            MS : OUT std_logic_vector(2 DOWNTO 0);
            NA : OUT std_logic_vector(7 DOWNTO 0);

            IN_CAR : IN std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT CAR
        PORT (
            A : IN std_logic;
            CLK : IN std_logic;
            RESET : IN std_logic;
            B : IN std_logic_vector(7 DOWNTO 0);
            Z : OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT mux2_8bit
        PORT (
            In0 : IN std_logic_vector(7 DOWNTO 0);
            In1 : IN std_logic_vector(7 DOWNTO 0);
            Sel : IN std_logic;
            mux_out : OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT IR
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

    COMPONENT mux8_1bit
        PORT (
            In0 : IN std_logic;
            In1 : IN std_logic;
            In2 : IN std_logic;
            In3 : IN std_logic;
            In4 : IN std_logic;
            In5 : IN std_logic;
            In6 : IN std_logic;
            In7 : IN std_logic;
            S0 : IN std_logic;
            S1 : IN std_logic;
            S2 : IN std_logic;
            Z : OUT std_logic
        );
    END COMPONENT;

    COMPONENT PC
        PORT (
            PC_IN : IN std_logic_vector(15 DOWNTO 0);
            PL : IN std_logic;
            PI : IN std_logic;
            Clk : IN std_logic;
            RESET : IN std_logic;
            PC_OUT : OUT std_logic_vector(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Extend
        PORT (
            DR_SB : IN std_logic_vector(5 DOWNTO 0);
            Ext : OUT std_logic_vector(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL PL_out, PI_out, IL_out, MC_out : std_logic;
    SIGNAL MS_out : std_logic_vector(2 DOWNTO 0);
    SIGNAL NA_out : std_logic_vector(7 DOWNTO 0);

    SIGNAL MUXS_OUT : std_logic;
    SIGNAL notC : std_logic;
    SIGNAL notZ : std_logic;
    SIGNAL DR_PC : std_logic_vector(2 DOWNTO 0);
    SIGNAL SA_PC : std_logic_vector(2 DOWNTO 0);
    SIGNAL SB_PC : std_logic_vector(2 DOWNTO 0);
    SIGNAL IN_CAR : std_logic_vector(7 DOWNTO 0);
    SIGNAL MUXC_OUT : std_logic_vector(7 DOWNTO 0);
    SIGNAL Opcode : std_logic_vector(6 DOWNTO 0);
    SIGNAL PCin : std_logic_vector(15 DOWNTO 0);

BEGIN

    control_memory0 : control_memory
    PORT MAP(
        IN_CAR => IN_CAR,
        MW => MW,
        MM => MM,
        RW => RW,
        MD => MD,
        FS => FS,
        MB => MB,
        TB => TB,
        TA => TA,
        TD => TD,

        PL => PL_out,
        PI => PI_out,
        IL => IL_out,
        MC => MC_out,
        MS => MS_out,
        NA => NA_out
    );

    car0 : CAR
    PORT MAP(
        A => MUXS_OUT,
        B => MUXC_OUT,
        RESET => reset,
        CLK => clk,
        Z => IN_CAR
    );

    muxc : mux2_8bit
    PORT MAP(
        In1(0) => Opcode(0),
        In1(1) => Opcode(1),
        In1(2) => Opcode(2),
        In1(3) => Opcode(3),
        In1(4) => Opcode(4),
        In1(5) => Opcode(5),
        In1(6) => Opcode(6),
        In1(7) => '0',
        In0 => NA_out,
        Sel => MC_out,
        mux_out => MUXC_OUT
    );

    ir0 : IR
    PORT MAP(
        IR_IN => instruction,
        IL => IL_out,
        CLK => clk,
        OPCODE => Opcode,
        DR => DR_PC,
        SA => SA_PC,
        SB => SB_PC
    );

    muxs : mux8_1bit
    PORT MAP(
        In0 => '0',
        In1 => '1',
        In2 => CFlag,
        In3 => VFlag,
        In4 => ZFlag,
        In5 => NFlag,
        In6 => notC,
        In7 => notZ,
        S0 => MS_out(0),
        S1 => MS_out(1),
        S2 => MS_out(2),
        z => MUXS_OUT
    );

    ext0 : Extend
    PORT MAP(
        DR_SB(2 DOWNTO 0) => SB_PC,
        DR_SB(5 DOWNTO 3) => DR_PC,
        Ext => PCin
    );

    pc0 : PC
    PORT MAP(
        PC_IN => PCin,
        PL => PL_out,
        PI => PI_out,
        RESET => reset,
        Clk => clk,
        PC_OUT => PCout
    );

    PL <= PL_out;
    PI <= PI_out;
    IL <= IL_out;
    MC <= MC_out;
    MS <= MS_out;
    NA <= NA_out;
    DR <= DR_PC;
    SA <= SA_PC;
    SB <= SB_PC;

END Behavioral;