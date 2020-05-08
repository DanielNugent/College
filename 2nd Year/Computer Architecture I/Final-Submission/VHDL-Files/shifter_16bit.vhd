--Daniel Nugent
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_ARITH.ALL;
USE IEEE.std_logic_UNSIGNED.ALL;

ENTITY shifter_16bit IS
	PORT (
		B : IN std_logic_vector (15 DOWNTO 0);
		FS : IN std_logic_vector (4 DOWNTO 0);
		Lr : IN std_logic;
		Ll : IN std_logic;
		H : OUT std_logic_vector (15 DOWNTO 0)
	);
END shifter_16bit;

ARCHITECTURE Behavioral OF shifter_16bit IS

	COMPONENT shifter
		PORT (
			In0 : IN std_logic;
			In1 : IN std_logic;
			In2 : IN std_logic;
			s : IN std_logic_vector(1 DOWNTO 0);
			Z : OUT std_logic
		);
	END COMPONENT;

	SIGNAL Hsel : std_logic_vector(1 DOWNTO 0);

BEGIN

	Hsel <= "00" WHEN FS = "10000" ELSE
		"01" WHEN FS = "10100" ELSE
		"10" WHEN FS = "11000" ELSE
		"11" AFTER 1ns;

	S0 : shifter PORT MAP(
		In0 => B(0),
		In1 => B(1),
		In2 => Ll,
		s => Hsel,
		Z => H(0)
	);

	S1 : shifter PORT MAP(
		In0 => B(1),
		In1 => B(2),
		In2 => B(0),
		s => Hsel,
		Z => H(1)
	);

	S2 : shifter PORT MAP(
		In0 => B(2),
		In1 => B(3),
		In2 => B(1),
		s => Hsel,
		Z => H(2)
	);

	S3 : shifter PORT MAP(
		In0 => B(3),
		In1 => B(4),
		In2 => B(2),
		s => Hsel,
		Z => H(3)
	);

	S4 : shifter PORT MAP(
		In0 => B(4),
		In1 => B(5),
		In2 => B(3),
		s => Hsel,
		Z => H(4)
	);

	S5 : shifter PORT MAP(
		In0 => B(5),
		In1 => B(6),
		In2 => B(4),
		s => Hsel,
		Z => H(5)
	);

	S6 : shifter PORT MAP(
		In0 => B(6),
		In1 => B(7),
		In2 => B(5),
		s => Hsel,
		Z => H(6)
	);

	S7 : shifter PORT MAP(
		In0 => B(7),
		In1 => B(8),
		In2 => B(6),
		s => Hsel,
		Z => H(7)
	);

	S8 : shifter PORT MAP(
		In0 => B(8),
		In1 => B(9),
		In2 => B(7),
		s => Hsel,
		Z => H(8)
	);

	S9 : shifter PORT MAP(
		In0 => B(9),
		In1 => B(10),
		In2 => B(8),
		s => Hsel,
		Z => H(9)
	);

	S10 : shifter PORT MAP(
		In0 => B(10),
		In1 => B(11),
		In2 => B(9),
		s => Hsel,
		Z => H(10)
	);

	S11 : shifter PORT MAP(
		In0 => B(11),
		In1 => B(12),
		In2 => B(10),
		s => Hsel,
		Z => H(11)
	);

	S12 : shifter PORT MAP(
		In0 => B(12),
		In1 => B(13),
		In2 => B(11),
		s => Hsel,
		Z => H(12)
	);

	S13 : shifter PORT MAP(
		In0 => B(13),
		In1 => B(14),
		In2 => B(12),
		s => Hsel,
		Z => H(13)
	);

	S14 : shifter PORT MAP(
		In0 => B(14),
		In1 => B(15),
		In2 => B(13),
		s => Hsel,
		Z => H(14)
	);

	S15 : shifter PORT MAP(
		In0 => B(15),
		In1 => Lr,
		In2 => B(14),
		s => Hsel,
		Z => H(15)
	);

END Behavioral;