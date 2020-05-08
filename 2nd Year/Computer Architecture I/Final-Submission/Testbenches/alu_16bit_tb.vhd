--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY alu_16bit_tb IS

END alu_16bit_tb;

ARCHITECTURE Behavioral OF alu_16bit_tb IS

    COMPONENT alu_16bit IS
        PORT (
            A : IN std_logic_vector(15 DOWNTO 0);
            B : IN std_logic_vector(15 DOWNTO 0);
            Gsel : IN std_logic_vector(3 DOWNTO 0);
            F : OUT std_logic_vector(15 DOWNTO 0);
            V : OUT std_logic;
            C : OUT std_logic;
            N : OUT std_logic;
            Z : OUT std_logic
        );
    END COMPONENT;

    SIGNAL A : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL B : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL Gsel : std_logic_vector(3 DOWNTO 0) := "0000";

    SIGNAL F : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL V : std_logic := '0';
    SIGNAL C : std_logic := '0';
    SIGNAL N : std_logic := '0';
    SIGNAL Z : std_logic := '0';

BEGIN

    UUT : alu_16bit
    PORT MAP(
        A => A,
        B => B,
        Gsel => Gsel,
        F => F,
        V => V,
        C => C,
        N => N,
        Z => Z
    );

    simulation_process : PROCESS
    BEGIN

        Gsel <= "0000";
        A <= x"0001";
        B <= x"0041";
        WAIT FOR 16ns;

        --Test Gsel = 0001 (F=A+1) = 0x0007 **
        Gsel <= "0001";
        A <= x"0006";
        B <= x"0027";
        WAIT FOR 16ns;

        --Test Gsel = 0010 (F=A+B) = 0x0005 **
        Gsel <= "0010";
        A <= x"0002";
        B <= x"0003";
        WAIT FOR 16ns;

        --Test Gsel = 0011 (F=A+B+1) = 0x000A **
        Gsel <= "0011";
        A <= x"0007";
        B <= x"0002";
        WAIT FOR 16ns;

        --Test Gsel = 0100 (F=A+B') = 0x0003 **
        Gsel <= "0100";
        A <= x"0001";
        B <= x"FFFD";
        WAIT FOR 16ns;

        --Test Gsel = 0101 (F=A+B'+1) = 0x0004 **
        Gsel <= "0101";
        A <= x"0001";
        B <= x"FFFD";
        WAIT FOR 16ns;

        --Test Gsel = 0101 (F=A-1) = 0x0002 ??
        Gsel <= "0110";
        A <= x"0003";
        B <= x"0128";
        WAIT FOR 16ns;

        --Test Gsel = 0111 (F=A) = 0x00F7 **
        Gsel <= "0111";
        A <= x"00F7";
        B <= x"0128";
        WAIT FOR 16ns;

        --**LOGIC**--
        --Test Gsel = 1000 (F=A^B)= 0x0429 **
        Gsel <= "1000";
        A <= x"0569";
        B <= x"0EB9";
        WAIT FOR 16ns;

        --Test Gsel = 1010 (F=AorB) = 0xFF7F **
        Gsel <= "1010";
        A <= x"FE63";
        B <= x"013D";
        WAIT FOR 16ns;

        --Test Gsel = 1100 (F=AxorB) = 0xD736 **
        Gsel <= "1100";
        A <= x"B59D";
        B <= x"62AB";
        WAIT FOR 16ns;

        --Test Gsel = 1110 (F=A') = 0xFFF4 **
        Gsel <= "1110";
        A <= x"000B";
        B <= x"0002";
        WAIT FOR 16ns;

        --**FLAG TESTS**--

        --Test V Flag

        -- 0xFFFF + 0x8000 = 0x7FFF -> V = 1 **
        Gsel <= "0010";
        A <= x"FFFF";
        B <= x"8000";
        WAIT FOR 16ns;

        -- 0xF000 + 0x00BC = 0xF0BC -> V = 0 **
        Gsel <= "0010";
        A <= x"F000";
        B <= x"00BC";
        WAIT FOR 16ns;

        --Test C Flag--

        -- 0xF000 + 0x8000 = 0x7000 -> C = 1 **
        Gsel <= "0010";
        A <= x"F000";
        B <= x"8000";
        WAIT FOR 16ns;

        -- 0x1405 + 0x00BC = 0x14C1 -> C = 0 **
        Gsel <= "0010";
        A <= x"1405";
        B <= x"00BC";
        WAIT FOR 16ns;

        -- Test N Flag --

        -- 0xF405 + 0x00BC = 0xF4C1 -> N = 1 **
        Gsel <= "0010";
        A <= x"F405";
        B <= x"00BC";
        WAIT FOR 16ns;

        -- 0x1405 + 0x00BC = 0x14C1 -> N = 0 **
        Gsel <= "0010";
        A <= x"1405";
        B <= x"00BC";
        WAIT FOR 16ns;

        -- Test Z Flag --

        -- 0x0000 + 0x0000 = 0x0000 -> Z = 1 **
        Gsel <= "0010";
        A <= x"0000";
        B <= x"0000";
        WAIT FOR 16ns;

        -- 0x1405 + 0x00BC = 0x14C1 -> Z = 0 **
        Gsel <= "0010";
        A <= x"1405";
        B <= x"00BC";
        WAIT FOR 16ns;

    END PROCESS;

END Behavioral;