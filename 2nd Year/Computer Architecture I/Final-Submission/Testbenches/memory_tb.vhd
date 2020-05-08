--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY memory_tb IS
    --  Port ( );
END memory_tb;

ARCHITECTURE Behavioral OF memory_tb IS

    -- declare component to test
    COMPONENT memory IS
        PORT (
            address : IN std_logic_vector(15 DOWNTO 0);
            data_in : IN std_logic_vector(15 DOWNTO 0);
            Clk : IN std_logic;
            MW : IN std_logic;
            data_out : OUT std_logic_vector(15 DOWNTO 0)
        );
    END COMPONENT;

    -- signals for tests (initialise to 0)

    --inputs    
    SIGNAL address : std_logic_vector(15 DOWNTO 0) := x"0000";
    SIGNAL data_in : std_logic_vector(15 DOWNTO 0) := x"0000";

    SIGNAL Clk : std_logic := '0';
    SIGNAL MW : std_logic := '0';

    --outputs
    SIGNAL data_out : std_logic_vector(15 DOWNTO 0) := x"0000";

BEGIN

    -- instantiate component for test, connect ports to internal signals
    UUT : memory
    PORT MAP(
        address => address,
        data_in => data_in,
        Clk => Clk,
        MW => MW,
        data_out => data_out
    );

    simulation_process : PROCESS
    BEGIN
        --Read Value at address 2 (0x0045)
        address <= x"0002";
        data_in <= x"0000";
        MW <= '0';
        Clk <= '1';
        WAIT FOR 10ns;

        Clk <= '0';
        WAIT FOR 10ns;
        --Write to address F 
        address <= x"00FF";
        data_in <= x"ABCD";
        MW <= '1';
        Clk <= '1';
        WAIT FOR 10ns;

        Clk <= '0';
        WAIT FOR 10ns;

        --Read Value at address 9 (0x0020)
        address <= x"0009";
        data_in <= x"0000";
        MW <= '0';
        Clk <= '1';
        WAIT FOR 10ns;

        Clk <= '0';
        WAIT FOR 10ns;

        --Read Value just written to address F (0xABCD)
        address <= x"00FF";
        data_in <= x"0000";
        MW <= '0';
        Clk <= '1';
        WAIT FOR 10ns;

        Clk <= '0';
        WAIT FOR 10ns;

    END PROCESS;

END Behavioral;