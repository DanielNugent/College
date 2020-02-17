-- Company: Trinity College
-- Engineer: Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY register_file IS
    PORT (
        Clk, load_enabled : IN std_logic;
        addr_a, addr_b, dest_d : IN std_logic_vector(2 DOWNTO 0);
        data : IN std_logic_vector(15 DOWNTO 0);
        out_a, out_b : OUT std_logic_vector(15 DOWNTO 0)
    );
END register_file;

ARCHITECTURE Behaviour OF register_file IS

    COMPONENT reg16
        PORT (
            D : IN std_logic_vector(15 DOWNTO 0);
            load0, load1, Clk : IN std_logic;
            Q : OUT std_logic_vector(15 DOWNTO 0));
    END COMPONENT;

    COMPONENT decoder3_8
        PORT (
            s : IN std_logic_vector(2 DOWNTO 0);
            z0 : OUT std_logic;
            z1 : OUT std_logic;
            z2 : OUT std_logic;
            z3 : OUT std_logic;
            z4 : OUT std_logic;
            z5 : OUT std_logic;
            z6 : OUT std_logic;
            z7 : OUT std_logic);
    END COMPONENT;

    COMPONENT multiplexer8_16
        PORT (
            s : IN std_logic_vector (2 DOWNTO 0);
            in0 : IN std_logic_vector (15 DOWNTO 0);
            in1 : IN std_logic_vector (15 DOWNTO 0);
            in2 : IN std_logic_vector (15 DOWNTO 0);
            in3 : IN std_logic_vector (15 DOWNTO 0);
            in4 : IN std_logic_vector (15 DOWNTO 0);
            in5 : IN std_logic_vector (15 DOWNTO 0);
            in6 : IN std_logic_vector (15 DOWNTO 0);
            in7 : IN std_logic_vector (15 DOWNTO 0);
            z : OUT std_logic_vector (15 DOWNTO 0));
    END COMPONENT;

    COMPONENT multiplexer2_16
        PORT (
            s : IN std_logic;
            in1 : IN std_logic_vector(15 DOWNTO 0);
            in2 : IN std_logic_vector (15 DOWNTO 0);
            z : OUT std_logic_vector (15 DOWNTO 0));
    END COMPONENT;

    SIGNAL load_reg0, load_reg1, load_reg3, load_reg2,
    load_reg4, load_reg5, load_reg6, load_reg7 : std_logic;

    SIGNAL reg0_q, reg1_q, reg2_q, reg3_q, reg4_q,
    reg5_q, reg6_q, reg7_q, src_reg : std_logic_vector(15 DOWNTO 0);

BEGIN

    reg000 : reg16 PORT MAP(
        D => data,
        load0 => load_reg0,
        load1 => load_enabled,
        Clk => Clk,
        Q => reg0_q
    );
    reg001 : reg16 PORT MAP(
        D => data,
        load0 => load_reg1,
        load1 => load_enabled,
        Clk => Clk,
        Q => reg1_q
    );
    reg010 : reg16 PORT MAP(
        D => data,
        load0 => load_reg2,
        load1 => load_enabled,
        Clk => Clk,
        Q => reg2_q
    );
    reg011 : reg16 PORT MAP(
        D => data,
        load0 => load_reg3,
        load1 => load_enabled,
        Clk => Clk,
        Q => reg3_q
    );
    reg100 : reg16 PORT MAP(
        D => data,
        load0 => load_reg4,
        load1 => load_enabled,
        Clk => Clk,
        Q => reg4_q
    );
    reg101 : reg16 PORT MAP(
        D => data,
        load0 => load_reg5,
        load1 => load_enabled,
        Clk => Clk,
        Q => reg5_q
    );
    reg110 : reg16 PORT MAP(
        D => data,
        load0 => load_reg6,
        load1 => load_enabled,
        Clk => Clk,
        Q => reg6_q
    );
    reg111 : reg16 PORT MAP(
        D => data,
        load0 => load_reg7,
        load1 => load_enabled,
        Clk => Clk,
        Q => reg7_q
    );

    dest_decoder : decoder3_8 PORT MAP(
        s(0) => dest_d(0),
        s(1) => dest_d(1),
        s(2) => dest_d(2),
        z0 => load_reg0,
        z1 => load_reg1,
        z2 => load_reg2,
        z3 => load_reg3,
        z4 => load_reg4,
        z5 => load_reg5,
        z6 => load_reg6,
        z7 => load_reg7
    );

    inst_multiplexer8_16_a : multiplexer8_16 PORT MAP(
        s(0) => addr_a(0),
        s(1) => addr_a(1),
        s(2) => addr_a(2),
        in0 => reg0_q,
        in1 => reg1_q,
        in2 => reg2_q,
        in3 => reg3_q,
        in4 => reg4_q,
        in5 => reg5_q,
        in6 => reg6_q,
        in7 => reg7_q,
        z => out_a
    );

    inst_multiplexer8_16_b : multiplexer8_16 PORT MAP(
        s(0) => addr_b(0),
        s(1) => addr_b(1),
        s(2) => addr_b(2),
        in0 => reg0_q,
        in1 => reg1_q,
        in2 => reg2_q,
        in3 => reg3_q,
        in4 => reg4_q,
        in5 => reg5_q,
        in6 => reg6_q,
        in7 => reg7_q,
        z => out_b
    );

END Behaviour;