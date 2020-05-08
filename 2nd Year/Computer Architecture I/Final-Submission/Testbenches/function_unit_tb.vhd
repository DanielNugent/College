--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY function_unit_tb IS
    --  Port ( );
END function_unit_tb;

ARCHITECTURE Behavioral OF function_unit_tb IS
    -- declare component to test
    COMPONENT function_unit IS
        PORT (
            A : IN std_logic_vector(15 DOWNTO 0);
            B : IN std_logic_vector(15 DOWNTO 0);
            FS : IN std_logic_vector(4 DOWNTO 0);
            V : OUT std_logic;
            C : OUT std_logic;
            N : OUT std_logic;
            Z : OUT std_logic;
            F : OUT std_logic_vector(15 DOWNTO 0)
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs    
    SIGNAL A : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL B : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL FS : std_logic_vector(4 DOWNTO 0) := "00000";

    --outputs
    SIGNAL F : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL V : std_logic := '0';
    SIGNAL C : std_logic := '0';
    SIGNAL N : std_logic := '0';
    SIGNAL Z : std_logic := '0';

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : function_unit
    PORT MAP(
        A => A,
        B => B,
        FS => FS,
        F => F,
        V => V,
        C => C,
        N => N,
        Z => Z
    );

    simulation_process : PROCESS
    BEGIN
        --Test all of the Opcodes for an ALU

        --**ARITHMETIC UNIT TESTS**--

        --Test FS = 00000 (F=A)= 0x0001 **
        FS <= "00000";
        A <= x"0001";
        B <= x"0041";
        WAIT FOR 16ns;

        --Test FS = 00001 (F=A+1) = 0x0007 **
        FS <= "00001";
        A <= x"0006";
        B <= x"0027";
        WAIT FOR 16ns;

        --Test FS = 00010 (F=A+B) = 0x0005   **
        FS <= "00010";
        A <= x"0002";
        B <= x"0003";
        WAIT FOR 16ns;

        --Test FS = 00011 (F=A+B+1) = 0x000A    **
        FS <= "00011";
        A <= x"0007";
        B <= x"0002";
        WAIT FOR 16ns;

        --Test FS = 00100 (F=A+B') = 0x0003    **
        FS <= "00100";
        A <= x"0001";
        B <= x"FFFD";
        WAIT FOR 16ns;

        --Test FS = 00101 (F=A+B'+1) = 0x0004    **
        FS <= "00101";
        A <= x"0001";
        B <= x"FFFD";
        WAIT FOR 16ns;

        --Test FS = 00101 (F=A-1) = 0x0002    **
        FS <= "00110";
        A <= x"0003";
        B <= x"0128";
        WAIT FOR 16ns;

        --Test FS = 00111 (F=A) = 0x00F7    **
        FS <= "00111";
        A <= x"00F7";
        B <= x"0128";
        WAIT FOR 16ns;

        --**LOGIC**--
        --Test FS = 01000 (F=A^B)= 0x0429    **
        FS <= "01000";
        A <= x"0569";
        B <= x"0EB9";
        WAIT FOR 16ns;

        --Test FS = 01010 (F=AorB) = 0xFF7F    **
        FS <= "01010";
        A <= x"FE63";
        B <= x"013D";
        WAIT FOR 16ns;

        --Test FS = 01100 (F=AxorB) = 0xD736   **
        FS <= "01100";
        A <= x"B59D";
        B <= x"62AB";
        WAIT FOR 16ns;

        --Test FS = 01110 (F=A') = 0xFFF4    **
        FS <= "01110";
        A <= x"000B";
        B <= x"0002";
        WAIT FOR 16ns;

        --**SHIFTER TESTS**--

        --Test FS = 10000 (F=B)= 0x0041    **
        FS <= "10000";
        A <= x"0001";
        B <= x"0041";
        WAIT FOR 16ns;

        --Test FS = 10100 (F= sr B) = 0x0013    **
        FS <= "10100";
        A <= x"0006";
        B <= x"0027";
        WAIT FOR 16ns;

        --Test FS = 11000 (F= sl B) = 0xC556    **
        FS <= "11000";
        A <= x"0002";
        B <= x"62AB";
        WAIT FOR 16ns;
        WAIT;
    END PROCESS;

END Behavioral;