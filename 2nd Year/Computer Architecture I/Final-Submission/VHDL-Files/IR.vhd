--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY IR IS

      PORT (
            IR_IN : IN std_logic_vector(15 DOWNTO 0);
            IL : IN std_logic;
            CLK : IN std_logic;
            OPCODE : OUT std_logic_vector(6 DOWNTO 0);
            DR : OUT std_logic_vector(2 DOWNTO 0);
            SA : OUT std_logic_vector(2 DOWNTO 0);
            SB : OUT std_logic_vector(2 DOWNTO 0)
      );
END IR;

ARCHITECTURE Behavioral OF IR IS

      SIGNAL IR_temp : std_logic_vector(15 DOWNTO 0);

BEGIN

      IR_temp <= IR_IN AFTER 1ns WHEN IL = '1'
            ELSE
            IR_temp AFTER 1ns;

      OPCODE <= IR_temp(15 DOWNTO 9) WHEN CLK = '1';
      DR <= IR_temp(8 DOWNTO 6) WHEN CLK = '1';
      SA <= IR_temp(5 DOWNTO 3) WHEN CLK = '1';
      SB <= IR_temp(2 DOWNTO 0) WHEN CLK = '1';

END Behavioral;