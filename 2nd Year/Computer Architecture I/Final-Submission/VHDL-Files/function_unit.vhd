--Daniel Nugent
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_ARITH.ALL;
USE IEEE.std_logic_UNSIGNED.ALL;

ENTITY function_unit IS
	PORT (
		A : IN std_logic_vector(15 DOWNTO 0);
		B : IN std_logic_vector(15 DOWNTO 0);
		FS : IN std_logic_vector(4 DOWNTO 0);
		V : OUT std_logic;
		C : OUT std_logic;
		N : OUT std_logic;
		Z : OUT std_logic;
		F : OUT std_logic_vector(15 DOWNTO 0)
	);
END function_unit;

ARCHITECTURE Behavioral OF function_unit IS

	COMPONENT alu_16bit
		PORT (
			A : IN std_logic_vector(15 DOWNTO 0);
			B : IN std_logic_vector(15 DOWNTO 0);
			Gsel : IN std_logic_vector(3 DOWNTO 0);
			F : OUT std_logic_vector(15 DOWNTO 0);
			V : OUT std_logic;
			C : OUT std_logic;
			N : OUT std_logic;
			Z : OUT std_logic
		);
	END COMPONENT;
	COMPONENT shifter_16bit
		PORT (
			B : IN std_logic_vector (15 DOWNTO 0);
			FS : IN std_logic_vector (4 DOWNTO 0);
			Lr : IN std_logic;
			Ll : IN std_logic;
			H : OUT std_logic_vector (15 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT mux2_16bit
		PORT (
			In0 : IN std_logic_vector(15 DOWNTO 0);
			In1 : IN std_logic_vector(15 DOWNTO 0);
			s : IN std_logic;
			Z : OUT std_logic_vector(15 DOWNTO 0)
		);
	END COMPONENT;
	SIGNAL ALU_out, shifter_out, mux_out : std_logic_vector(15 DOWNTO 0);

BEGIN

	alu : alu_16bit
	PORT MAP(
		A => A,
		B => B,
		Gsel(0) => FS(0),
		Gsel(1) => FS(1),
		Gsel(2) => FS(2),
		Gsel(3) => FS(3),
		F => ALU_out,
		V => V,
		C => C,
		N => N,
		Z => Z
	);
	shifter : shifter_16bit
	PORT MAP(
		B => B,
		FS => FS,
		Lr => '0',
		Ll => '0',
		H => shifter_out
	);
	MUXF : mux2_16bit
	PORT MAP(
		In0 => ALU_out,
		In1 => shifter_out,
		s => FS(4),
		Z => F
	);
END Behavioral;