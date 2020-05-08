--Daniel Nugent
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY register_file IS
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
END register_file;

ARCHITECTURE Behavioral OF register_file IS

	COMPONENT reg16
		PORT (
			D : IN std_logic_vector(15 DOWNTO 0);
			load : IN std_logic;
			Clk : IN std_logic;
			Q : OUT std_logic_vector(15 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT decoder_4to9
		PORT (
			des : IN std_logic_vector(3 DOWNTO 0);
			RW : IN std_logic;
			Q0 : OUT std_logic;
			Q1 : OUT std_logic;
			Q2 : OUT std_logic;
			Q3 : OUT std_logic;
			Q4 : OUT std_logic;
			Q5 : OUT std_logic;
			Q6 : OUT std_logic;
			Q7 : OUT std_logic;
			Q8 : OUT std_logic
		);
	END COMPONENT;

	COMPONENT mux9_16bit
		PORT (
			In0 : IN std_logic_vector(15 DOWNTO 0);
			In1 : IN std_logic_vector(15 DOWNTO 0);
			In2 : IN std_logic_vector(15 DOWNTO 0);
			In3 : IN std_logic_vector(15 DOWNTO 0);
			In4 : IN std_logic_vector(15 DOWNTO 0);
			In5 : IN std_logic_vector(15 DOWNTO 0);
			In6 : IN std_logic_vector(15 DOWNTO 0);
			In7 : IN std_logic_vector(15 DOWNTO 0);
			In8 : IN std_logic_vector(15 DOWNTO 0);
			src : IN std_logic_vector(3 DOWNTO 0);
			Z : OUT std_logic_vector(15 DOWNTO 0)
		);
	END COMPONENT;
	SIGNAL d_out0, d_out1, d_out2, d_out3, d_out4, d_out5, d_out6, d_out7, d_out8 : std_logic;

	SIGNAL reg0_out, reg1_out, reg2_out, reg3_out, reg4_out, reg5_out,
	reg6_out, reg7_out, reg8_out : std_logic_vector(15 DOWNTO 0);

BEGIN

	reg00 : reg16 PORT MAP(
		D => data,
		Clk => Clk,
		load => d_out0,
		Q => reg0_out
	);
	reg01 : reg16 PORT MAP(
		D => data,
		Clk => Clk,
		load => d_out1,
		Q => reg1_out
	);
	reg02 : reg16 PORT MAP(
		D => data,
		Clk => Clk,
		load => d_out2,
		Q => reg2_out
	);
	reg03 : reg16 PORT MAP(
		D => data,
		Clk => Clk,
		load => d_out3,
		Q => reg3_out
	);
	reg04 : reg16 PORT MAP(
		D => data,
		Clk => Clk,
		load => d_out4,
		Q => reg4_out
	);
	reg05 : reg16 PORT MAP(
		D => data,
		Clk => Clk,
		load => d_out5,
		Q => reg5_out
	);
	reg06 : reg16 PORT MAP(
		D => data,
		Clk => Clk,
		load => d_out6,
		Q => reg6_out
	);
	reg07 : reg16 PORT MAP(
		D => data,
		Clk => Clk,
		load => d_out7,
		Q => reg7_out
	);
	reg08 : reg16 PORT MAP(
		D => data,
		Clk => Clk,
		load => d_out8,
		Q => reg8_out
	);
	des_decoder_4to9 : decoder_4to9 PORT MAP(
		des => DA,
		RW => RW,
		Q0 => d_out0,
		Q1 => d_out1,
		Q2 => d_out2,
		Q3 => d_out3,
		Q4 => d_out4,
		Q5 => d_out5,
		Q6 => d_out6,
		Q7 => d_out7,
		Q8 => d_out8
	);

	A_mux9_16bit : mux9_16bit PORT MAP(
		In0 => reg0_out,
		In1 => reg1_out,
		In2 => reg2_out,
		In3 => reg3_out,
		In4 => reg4_out,
		In5 => reg5_out,
		In6 => reg6_out,
		In7 => reg7_out,
		In8 => reg8_out,
		src => AA,
		Z => a_out
	);

	B_mux9_16bit : mux9_16bit PORT MAP(
		In0 => reg0_out,
		In1 => reg1_out,
		In2 => reg2_out,
		In3 => reg3_out,
		In4 => reg4_out,
		In5 => reg5_out,
		In6 => reg6_out,
		In7 => reg7_out,
		In8 => reg8_out,
		src => BA,
		Z => b_out
	);

	reg0out <= reg0_out;
	reg1out <= reg1_out;
	reg2out <= reg2_out;
	reg3out <= reg3_out;
	reg4out <= reg4_out;
	reg5out <= reg5_out;
	reg6out <= reg6_out;
	reg7out <= reg7_out;
	reg8out <= reg8_out;
END Behavioral;