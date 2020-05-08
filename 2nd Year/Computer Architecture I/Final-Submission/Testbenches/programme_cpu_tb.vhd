--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY programme_cpu_tb IS
    --  Port ( );
END programme_cpu_tb;

ARCHITECTURE Behavioral OF programme_cpu_tb IS

    COMPONENT programme_cpu IS
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
    END COMPONENT;

    SIGNAL clk, reset : std_logic := '0';
    SIGNAL reg0out, reg1out, reg2out, reg3out, reg4out, reg5out, reg6out, reg7out : std_logic_vector(15 DOWNTO 0);

    CONSTANT clk_period : TIME := 40ns;
    CONSTANT cycles : INTEGER := 0;
    CONSTANT max_cycles : INTEGER := 1000;

BEGIN

    UTT : programme_cpu
    PORT MAP(
        clk => clk,
        reset => reset,
        reg0 => reg0out,
        reg1 => reg1out,
        reg2 => reg2out,
        reg3 => reg3out,
        reg4 => reg4out,
        reg5 => reg5out,
        reg6 => reg6out,
        reg7 => reg7out
    );

    PROCESS
    BEGIN
        reset <= '1';
        clk <= '1';
        WAIT FOR 50 ns;
        reset <= '0';
        clk <= '0';
        WHILE cycles < max_cycles LOOP
            clk <= NOT clk;
            WAIT FOR clk_period/2;
        END LOOP;
        WAIT;
    END PROCESS;

END Behavioral;