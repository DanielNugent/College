--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY datapath IS
	PORT (
		data_in : IN std_logic_vector(15 DOWNTO 0);

		PC_in : IN std_logic_vector(15 DOWNTO 0);

		SB : IN std_logic_vector(2 DOWNTO 0);

		MB : IN std_logic;
		MD : IN std_logic;
		MM : IN std_logic;

		Dsel : IN std_logic_vector(3 DOWNTO 0);
		Asel : IN std_logic_vector(3 DOWNTO 0);
		Bsel : IN std_logic_vector(3 DOWNTO 0);
		FS : IN std_logic_vector(4 DOWNTO 0);
		RW : IN std_logic;
		Clk : IN std_logic;

		adr_out : OUT std_logic_vector(15 DOWNTO 0);
		data_out : OUT std_logic_vector(15 DOWNTO 0);

		reg_0_data_out : OUT std_logic_vector(15 DOWNTO 0);
		reg_1_data_out : OUT std_logic_vector(15 DOWNTO 0);
		reg_2_data_out : OUT std_logic_vector(15 DOWNTO 0);
		reg_3_data_out : OUT std_logic_vector(15 DOWNTO 0);
		reg_4_data_out : OUT std_logic_vector(15 DOWNTO 0);
		reg_5_data_out : OUT std_logic_vector(15 DOWNTO 0);
		reg_6_data_out : OUT std_logic_vector(15 DOWNTO 0);
		reg_7_data_out : OUT std_logic_vector(15 DOWNTO 0);
		reg_8_data_out : OUT std_logic_vector(15 DOWNTO 0);

		Vflag : OUT std_logic;
		Cflag : OUT std_logic;
		Nflag : OUT std_logic;
		Zflag : OUT std_logic
	);
END datapath;

ARCHITECTURE Behavioral OF datapath IS

	COMPONENT register_file
		PORT (
			DA : IN std_logic_vector(3 DOWNTO 0);
			AA : IN std_logic_vector(3 DOWNTO 0);
			BA : IN std_logic_vector(3 DOWNTO 0);

			Clk : IN std_logic;
			RW : IN std_logic;

			data : IN std_logic_vector(15 DOWNTO 0);

			a_out : OUT std_logic_vector(15 DOWNTO 0);
			b_out : OUT std_logic_vector(15 DOWNTO 0);

			reg0out : OUT std_logic_vector(15 DOWNTO 0);
			reg1out : OUT std_logic_vector(15 DOWNTO 0);
			reg2out : OUT std_logic_vector(15 DOWNTO 0);
			reg3out : OUT std_logic_vector(15 DOWNTO 0);
			reg4out : OUT std_logic_vector(15 DOWNTO 0);
			reg5out : OUT std_logic_vector(15 DOWNTO 0);
			reg6out : OUT std_logic_vector(15 DOWNTO 0);
			reg7out : OUT std_logic_vector(15 DOWNTO 0);
			reg8out : OUT std_logic_vector(15 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT function_unit
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
	END COMPONENT;

	COMPONENT mux2_16bit
		PORT (
			In0 : IN std_logic_vector(15 DOWNTO 0);
			In1 : IN std_logic_vector(15 DOWNTO 0);
			s : IN std_logic;
			Z : OUT std_logic_vector(15 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT Zero_fill
		PORT (
			SB : IN std_logic_vector(2 DOWNTO 0);
			zeroFill : OUT std_logic_vector(15 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL Data, BOut, ABus, BBus, Fsig, ConIn : std_logic_vector(15 DOWNTO 0);

BEGIN

	reg_file : register_file PORT MAP(
		AA => Asel,
		BA => Bsel,
		DA => Dsel,

		RW => RW,
		Clk => Clk,

		data => Data,

		a_out => ABus,
		b_out => BOut,

		reg0out => reg_0_data_out,
		reg1out => reg_1_data_out,
		reg2out => reg_2_data_out,
		reg3out => reg_3_data_out,
		reg4out => reg_4_data_out,
		reg5out => reg_5_data_out,
		reg6out => reg_6_data_out,
		reg7out => reg_7_data_out,
		reg8out => reg_8_data_out
	);

	funct_unit : function_unit PORT MAP(
		A => ABus,
		B => BBus,

		FS => FS,

		V => Vflag,
		C => Cflag,
		N => Nflag,
		Z => Zflag,

		F => Fsig
	);
	mux_b : mux2_16bit PORT MAP(
		In0 => BOut,
		In1 => ConIn,
		s => MB,
		Z => BBus
	);

	mux_d : mux2_16bit PORT MAP(
		In0 => Fsig,
		In1 => data_in,
		s => MD,
		Z => Data
	);
	mux_m : mux2_16bit PORT MAP(
		In0 => ABus,
		In1 => PC_in,
		s => MM,
		Z => adr_out
	);
	z_fill : Zero_fill PORT MAP(
		SB => SB,
		zeroFill => ConIn
	);

	data_out <= BBus;

END Behavioral;