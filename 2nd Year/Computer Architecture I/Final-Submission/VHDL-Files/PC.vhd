--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY PC IS
    PORT (
        PC_IN : IN std_logic_vector(15 DOWNTO 0);
        PL : IN std_logic;
        PI : IN std_logic;
        RESET : IN std_logic;
        Clk : IN std_logic;
        PC_OUT : OUT std_logic_vector(15 DOWNTO 0)
    );
END PC;

ARCHITECTURE Behavioral OF PC IS

BEGIN

    PROCESS (Clk)
        VARIABLE pc : std_logic_vector(15 DOWNTO 0);
        VARIABLE temp_pc : INTEGER;
        VARIABLE temp_inc_pc : std_logic_vector(15 DOWNTO 0);

    BEGIN
        IF (reset = '1' AND clk = '1') THEN
            pc := x"0000";

        ELSIF (PL = '1' AND clk = '1') THEN
            pc := pc + PC_IN;

        ELSIF (PI = '1' AND clk = '1') THEN
            temp_pc := conv_integer(pc);
            temp_pc := temp_pc + conv_integer(1);
            temp_inc_pc := conv_std_logic_vector(temp_pc, 16);
            pc := temp_inc_pc;

        END IF;
        PC_OUT <= pc AFTER 10ns;
    END PROCESS;
END Behavioral;