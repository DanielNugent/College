--Daniel Nugent
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux8_16bit is
	Port (
		In0 : in std_logic_vector(15 downto 0);
		In1 : in std_logic_vector(15 downto 0);
		In2 : in std_logic_vector(15 downto 0);
		In3 : in std_logic_vector(15 downto 0); 
		In4 : in std_logic_vector(15 downto 0); 
		In5 : in std_logic_vector(15 downto 0); 
		In6 : in std_logic_vector(15 downto 0); 
		In7 : in std_logic_vector(15 downto 0);
		src : in std_logic_vector(2 downto 0);
		Z : out std_logic_vector(15 downto 0)
	);
end mux8_16bit;

architecture Behavioral of mux8_16bit is
begin
	Z <= In0 after 5ns when src="000" else
		 In1 after 5ns when src="001" else
		 In2 after 5ns when src="010" else
		 In3 after 5ns when src="011" else
		 In4 after 5ns when src="100" else
		 In5 after 5ns when src="101" else
		 In6 after 5ns when src="110" else
		 In7 after 5ns when src="111" else
	     x"0000" after 5ns;
end Behavioral;
