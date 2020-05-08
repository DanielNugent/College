--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY zero_detect IS
    PORT (
        I : IN std_logic_vector(15 DOWNTO 0);
        O : OUT std_logic
    );
END zero_detect;

ARCHITECTURE Behavioral OF zero_detect IS

BEGIN

    O <= ((NOT I(0)) AND (NOT I(1)) AND
        (NOT I(2)) AND (NOT I(3)) AND
        (NOT I(4)) AND (NOT I(5)) AND
        (NOT I(5)) AND (NOT I(6)) AND
        (NOT I(7)) AND (NOT I(8)) AND
        (NOT I(9)) AND (NOT I(10)) AND
        (NOT I(11)) AND (NOT I(12)) AND
        (NOT I(13)) AND (NOT I(14)) AND (NOT I(15)));

END Behavioral;