--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Extend IS
    PORT (
        DR_SB : IN std_logic_vector(5 DOWNTO 0);
        Ext : OUT std_logic_vector(15 DOWNTO 0)
    );
END Extend;

ARCHITECTURE Behavioral OF Extend IS

    SIGNAL ext_sig : std_logic_vector(15 DOWNTO 0);

BEGIN

    ext_sig(5 DOWNTO 0) <= DR_SB;
    ext_sig(15 DOWNTO 6) <= "0000000000" WHEN DR_SB(5) = '0' ELSE
    "1111111111";
    Ext <= ext_sig;

END Behavioral;