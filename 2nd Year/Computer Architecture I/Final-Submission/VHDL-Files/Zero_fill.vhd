--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Zero_fill IS
    PORT (
        SB : IN std_logic_vector(2 DOWNTO 0);
        zeroFill : OUT std_logic_vector(15 DOWNTO 0)
    );
END Zero_fill;
ARCHITECTURE Behavioral OF Zero_fill IS

    SIGNAL zf : std_logic_vector(15 DOWNTO 0);

BEGIN

    zf(2 DOWNTO 0) <= SB;
    zf(15 DOWNTO 3) <= "0000000000000";

    zeroFill <= zf;

END Behavioral;