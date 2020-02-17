LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY multiplexer2_16_tb IS
END multiplexer2_16_tb;

ARCHITECTURE Behavioral OF multiplexer2_16_tb IS
    COMPONENT multiplexer2_16
        PORT (
            s : IN std_logic;
            in1 : IN std_logic_vector(15 DOWNTO 0);
            in2 : IN std_logic_vector (15 DOWNTO 0);
            z : OUT std_logic_vector (15 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL s : std_logic;
    SIGNAL in1 : std_logic_vector(15 DOWNTO 0);
    SIGNAL in2 : std_logic_vector(15 DOWNTO 0);
    SIGNAL z : std_logic_vector(15 DOWNTO 0);
BEGIN
    uut : multiplexer2_16 PORT MAP(
        s => s,
        in1 => in1,
        in2 => in2,
        z => z
    );

    stim_proc : PROCESS
    BEGIN
        WAIT FOR 10 ns;

        in1 <= "0101010101010101";
        in2 <= "1010101010101010";

        WAIT FOR 10 ns;
        s <= '0';
        WAIT FOR 10 ns;
        s <= '1';
    END PROCESS;

END;