LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY multiplexer8_16_tb IS
END multiplexer8_16_tb;

ARCHITECTURE Behavioral OF multiplexer8_16_tb IS

  COMPONENT multiplexer8_16

    PORT (
      s : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      in0 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      in1 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      in2 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      in3 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      in4 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      in5 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      in6 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      in7 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
      z : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));

  END COMPONENT;

  SIGNAL s : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL in0 : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL in1 : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL in2 : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL in3 : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL in4 : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL in5 : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL in6 : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL in7 : STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL z : STD_LOGIC_VECTOR (15 DOWNTO 0);

BEGIN

  uut : multiplexer8_16 PORT MAP(
    s => s,
    in0 => in0,
    in1 => in1,
    in2 => in2,
    in3 => in3,
    in4 => in4,
    in5 => in5,
    in6 => in6,
    in7 => in7,
    z => z
  );

  stim_proc : PROCESS
  BEGIN
    WAIT FOR 10 ns;

    in0 <= "0000000000000000";
    in1 <= "0000000011111111";
    in2 <= "0000111100001111";
    in3 <= "0011001100110011";
    in4 <= "1111111111111111";
    in5 <= "1110001110001110";
    in6 <= "1111111100000011";
    in7 <= "1101010101010100";

    WAIT FOR 10 ns;
    s <= "000";
    WAIT FOR 10 ns;
    s <= "001";
    WAIT FOR 10 ns;
    s <= "010";
    WAIT FOR 10 ns;
    s <= "011";
    WAIT FOR 10 ns;
    s <= "100";
    WAIT FOR 10 ns;
    s <= "101";
    WAIT FOR 10 ns;
    s <= "110";
    WAIT FOR 10 ns;
    s <= "111";
  END PROCESS;
END Behavioral;