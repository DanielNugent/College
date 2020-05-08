--Daniel Nugent

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY control_memory_tb IS
    --  Port ( );
END control_memory_tb;

ARCHITECTURE Behavioral OF control_memory_tb IS

    -- declare component to test
    COMPONENT control_memory IS
        PORT (
            -- IN_CAR input from CAR
            IN_CAR : IN std_logic_vector(7 DOWNTO 0);

            -- MW to Memory
            MW : OUT std_logic;
            -- MM to Mux M
            MM : OUT std_logic;
            -- MD to Mux D
            MD : OUT std_logic;
            -- MB to Mux B
            MB : OUT std_logic;
            -- MC to Mux C
            MC : OUT std_logic;

            -- MS to Mux S
            MS : OUT std_logic_vector(2 DOWNTO 0);

            -- RW to Register File (Read/Write)
            RW : OUT std_logic;
            -- FS to Function Unit
            FS : OUT std_logic_vector(4 DOWNTO 0);

            -- TB to Register File (Temp B)
            TB : OUT std_logic;
            -- TA to Register File (Temp A)
            TA : OUT std_logic;
            -- TD to Register File (Temp D)
            TD : OUT std_logic;

            -- PL to Program Counter 
            PL : OUT std_logic;
            -- PI to Program Counter
            PI : OUT std_logic;
            -- IL to Instruction Register (IR)
            IL : OUT std_logic;
            -- NA to Mux C (Next Address)
            NA : OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs    
    SIGNAL IN_CAR : std_logic_vector(7 DOWNTO 0) := x"00";

    --outputs
    SIGNAL MW, MM, MD, MB, MC : std_logic := '0';
    SIGNAL MS : std_logic_vector(2 DOWNTO 0) := "000";
    SIGNAL TB, TA, TD : std_logic := '0';
    SIGNAL PI, PL, IL : std_logic := '0';
    SIGNAL RW : std_logic := '0';
    SIGNAL FS : std_logic_vector(4 DOWNTO 0) := "00000";
    SIGNAL NA : std_logic_vector(7 DOWNTO 0) := x"00";

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : control_memory
    PORT MAP(
        IN_CAR => IN_CAR,

        MW => MW,
        MM => MM,
        MD => MD,
        MB => MB,
        MC => MC,
        MS => MS,

        TB => TB,
        TA => TA,
        TD => TD,

        PI => PI,
        PL => PL,
        IL => IL,

        RW => RW,
        FS => FS,
        NA => NA
    );

    simulation_process : PROCESS
    BEGIN
        --Read Value at address 1 (0xC020306)
        ------------------------------------------------------------------------------
        --    NA        MS   MC  IL  PI  PL  TD  TA  TB  MB     FS    MD  RW  MM  MW
        -- |1100 0000 | 001 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 0000 | 0 | 1 | 1 | 0
        ------------------------------------------------------------------------------
        -- NA = 1100 0000 (C0)
        -- MS = 001 
        -- MC = 0
        -- IL = 0
        -- PI = 0 
        -- PL = 0
        -- TD = 0
        -- TA = 0
        -- TB = 0
        -- MB = 1
        -- FS = 1 0000
        -- MD = 0
        -- RW = 1
        -- MM = 0
        -- MW = 0      
        IN_CAR <= "00000000";
        WAIT FOR 10ns;
        IN_CAR <= "00000001";
        WAIT FOR 10ns;
        IN_CAR <= "00000010";
        WAIT FOR 10ns;
        IN_CAR <= "00000011";
        WAIT FOR 10ns;
        IN_CAR <= "00000100";
        WAIT FOR 10ns;

    END PROCESS;

END Behavioral;