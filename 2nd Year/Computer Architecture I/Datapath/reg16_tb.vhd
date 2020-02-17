-- Company: Trinity College
-- Engineer: Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY reg16_tb IS
END reg16_tb;

ARCHITECTURE Behavioral OF reg16_tb IS

    COMPONENT reg16
        PORT (
            d : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            clk : IN STD_LOGIC;
            load : IN STD_LOGIC;
            q : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
    END COMPONENT;

    SIGNAL d : std_logic_vector(15 DOWNTO 0);
    SIGNAL clk, load : std_logic;
    SIGNAL q : std_logic_vector(15 DOWNTO 0);

BEGIN
    uut : reg16 PORT MAP(
        d => d,
        clk => clk,
        load => load,
        q => q
    );

    stim_proc : PROCESS
    BEGIN
        WAIT FOR 10 ns;
        d <= "1111111111111111";
        load <= '0';
        clk <= '0';

        WAIT FOR 10 ns;
        load <= '1';

        WAIT FOR 10 ns;

        clk <= '1';

        WAIT FOR 10 ns;
        d <= "1111111100000000";
        load <= '0';

        WAIT FOR 10 ns;
        clk <= '1';

    END PROCESS;

END Behavioral;