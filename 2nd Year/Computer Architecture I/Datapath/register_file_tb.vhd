-- Company: Trinity College
-- Engineer: Daniel Nugent

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY register_file_tb IS
END register_file_tb;

ARCHITECTURE behaviour OF register_file_tb IS
    COMPONENT register_file
        PORT (
            Clk, load_enabled : IN std_logic;
            addr_a, addr_b, dest_d : IN std_logic_vector(2 DOWNTO 0);
            data : IN std_logic_vector(15 DOWNTO 0);
            out_a, out_b : OUT std_logic_vector(15 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL Clk, load_enabled : std_logic;
    SIGNAL addr_a, addr_b, dest_d : std_logic_vector(2 DOWNTO 0);

    SIGNAL data : std_logic_vector(15 DOWNTO 0);
    --Outputs
    SIGNAL out_a, out_b : std_logic_vector(15 DOWNTO 0);

BEGIN

    uut : register_file PORT MAP(
        Clk => Clk,
        load_enabled => load_enabled,
        addr_a => addr_a,
        addr_b => addr_b,
        dest_d => dest_d,
        data => data,
        out_a => out_a,
        out_b => out_b
    );

    stim_proc : PROCESS

    BEGIN
        dest_d <= "000";
        data <= "1111111100000000";
        Clk <= '0';
        load_enabled <= '1';

        WAIT FOR 10 ns;

        Clk <= '1';

        WAIT FOR 10 ns;

        dest_d <= "001";
        data <= "0000000011111111";
        Clk <= '0';

        WAIT FOR 10 ns;

        Clk <= '1';

        WAIT FOR 10 ns;

        dest_d <= "010";
        data <= "1111000011110000";
        Clk <= '0';

        WAIT FOR 10 ns;

        Clk <= '1';

        WAIT FOR 10 ns;

        dest_d <= "011";
        data <= "0000111100001111";
        Clk <= '0';

        WAIT FOR 10 ns;

        Clk <= '1';

        WAIT FOR 10 ns;

        dest_d <= "100";
        data <= "1100110011001100";
        Clk <= '0';

        WAIT FOR 10 ns;

        Clk <= '1';

        WAIT FOR 10 ns;

        dest_d <= "101";
        data <= "0011001100110011";
        Clk <= '0';

        WAIT FOR 10 ns;

        Clk <= '1';

        WAIT FOR 10 ns;

        dest_d <= "110";
        data <= "1010101010101010";
        Clk <= '0';

        WAIT FOR 10 ns;

        Clk <= '1';

        WAIT FOR 10 ns;
        dest_d <= "111";
        data <= "0101010101010101";
        Clk <= '0';
        WAIT FOR 10 ns;
        Clk <= '1';
        WAIT FOR 10 ns;
        addr_a <= "000";
        addr_b <= "111";
        WAIT FOR 10 ns;
        addr_a <= "001";
        addr_b <= "110";
        WAIT FOR 10 ns;
        addr_a <= "010";
        addr_b <= "101";
        WAIT FOR 10 ns;
        addr_a <= "011";
        addr_b <= "100";
        WAIT FOR 10 ns;
        addr_a <= "100";
        addr_b <= "011";
        WAIT FOR 10 ns;
        addr_a <= "101";
        addr_b <= "010";
        WAIT FOR 10 ns;
        addr_a <= "110";
        addr_b <= "001";
        WAIT FOR 10 ns;
        addr_a <= "111";
        addr_b <= "000";
        WAIT FOR 10 ns;
    END PROCESS;
END;