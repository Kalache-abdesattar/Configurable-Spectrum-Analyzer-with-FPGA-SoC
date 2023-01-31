library ieee, ieee_proposed;
use ieee.std_logic_1164.all;
use ieee.math_complex_f.all;
use ieee_proposed.fixed_pkg.all;



entity vec_mux is
	port(x : in COMPLEX_F_array;
		  sel : in std_logic_vector(0 to 3);
		  y : out COMPLEX_F);
end entity;


architecture arc of vec_mux is 
	begin
		process(x, sel)
			begin
				case sel is 
					when x"0" =>
						y <= x(0);
					when x"1" =>
						y <= x(1);
					when x"2" =>
						y <= x(2);
					when x"3" =>
						y <= x(3);
					when x"4" =>
						y <= x(4);
					when x"5" =>
						y <= x(5);
					when x"6" =>
						y <= x(6);
					when x"7" =>
						y <= x(7);
					when x"8" =>
						y <= x(8);
					when x"9" =>
						y <= x(9);
					when x"A" =>
						y <= x(10);
					when x"B" =>
						y <= x(11);
					when x"C" =>
						y <= x(12);
					when x"D" =>
						y <= x(13);
					when x"E" =>
						y <= x(14);
					when x"F" =>
						y <= x(15);
					when others =>
						NULL;
				end case;
		end process;
end;



library ieee, ieee_proposed;
use ieee.std_logic_1164.all;
use ieee.math_complex_f.all;
use ieee_proposed.fixed_pkg.all;



entity state_reg_upper is
	port(x : in COMPLEX_F_array;
		  ena, reset, clk : in std_logic;
		  Q : out COMPLEX_F_array);
end entity;


architecture arc of state_reg_upper is 
	begin
		process(clk, x)
			begin
				if(clk'event and clk='1') then 
					if(reset='1') then
						Q(0) <= COMPLEX_F'((others=>'0'), (others=>'0'));Q(1) <= COMPLEX_F'((others=>'0'), (others=>'0'));
						Q(2) <= COMPLEX_F'((others=>'0'), (others=>'0'));Q(3) <= COMPLEX_F'((others=>'0'), (others=>'0'));
						Q(4) <= COMPLEX_F'((others=>'0'), (others=>'0'));Q(5) <= COMPLEX_F'((others=>'0'), (others=>'0'));
						Q(6) <= COMPLEX_F'((others=>'0'), (others=>'0'));Q(7) <= COMPLEX_F'((others=>'0'), (others=>'0'));
						Q(8) <= COMPLEX_F'((others=>'0'), (others=>'0'));Q(9) <= COMPLEX_F'((others=>'0'), (others=>'0'));
						Q(10) <= COMPLEX_F'((others=>'0'), (others=>'0'));Q(11) <= COMPLEX_F'((others=>'0'), (others=>'0'));
						Q(12) <= COMPLEX_F'((others=>'0'), (others=>'0'));Q(13) <= COMPLEX_F'((others=>'0'), (others=>'0'));
						Q(14) <= COMPLEX_F'((others=>'0'), (others=>'0'));Q(15) <= COMPLEX_F'((others=>'0'), (others=>'0'));
					else
						if(ena = '1') then
							Q <= x;
						end if;
					end if;
				end if;
		end process;
							
end;


library ieee, ieee_proposed;
use ieee.std_logic_1164.all;
use ieee.math_complex_f.all;
use ieee_proposed.fixed_pkg.all;



entity state_reg_lower is
	port(x : in COMPLEX_F_array;
		  ena, reset, clk : in std_logic;
		  Q : out COMPLEX_F_array);
end entity;


architecture arc of state_reg_lower is 
	begin
		process(clk, x)
			begin
				if(clk'event and clk='0') then 
					if(reset='1') then
						Q(0) <= COMPLEX_F'((others=>'0'), (others=>'0'));Q(1) <= COMPLEX_F'((others=>'0'), (others=>'0'));
						Q(2) <= COMPLEX_F'((others=>'0'), (others=>'0'));Q(3) <= COMPLEX_F'((others=>'0'), (others=>'0'));
						Q(4) <= COMPLEX_F'((others=>'0'), (others=>'0'));Q(5) <= COMPLEX_F'((others=>'0'), (others=>'0'));
						Q(6) <= COMPLEX_F'((others=>'0'), (others=>'0'));Q(7) <= COMPLEX_F'((others=>'0'), (others=>'0'));
						Q(8) <= COMPLEX_F'((others=>'0'), (others=>'0'));Q(9) <= COMPLEX_F'((others=>'0'), (others=>'0'));
						Q(10) <= COMPLEX_F'((others=>'0'), (others=>'0'));Q(11) <= COMPLEX_F'((others=>'0'), (others=>'0'));
						Q(12) <= COMPLEX_F'((others=>'0'), (others=>'0'));Q(13) <= COMPLEX_F'((others=>'0'), (others=>'0'));
						Q(14) <= COMPLEX_F'((others=>'0'), (others=>'0'));Q(15) <= COMPLEX_F'((others=>'0'), (others=>'0'));
					else
						if(ena = '1') then
							Q <= x;
						end if;
					end if;
				end if;
		end process;
							
end;



library ieee, ieee_proposed;
use ieee.std_logic_1164.all;
use ieee.math_complex_f.all;
use ieee_proposed.fixed_pkg.all;



entity fsm is
	port(clk, reset, sop : in std_logic;
		  reg_mux_sel, eop, ena : out std_logic;
		  mux00_sel, mux10_sel, mux01_sel, mux11_sel, mux02_sel, mux12_sel, mux03_sel, mux13_sel, mux04_sel, mux14_sel, mux05_sel, mux15_sel, mux06_sel, mux16_sel, mux07_sel, mux17_sel  : out std_logic_vector(0 to 3);
		  twiddle_fact_00, twiddle_fact_10, twiddle_fact_01, twiddle_fact_11, twiddle_fact_02, twiddle_fact_12, twiddle_fact_03, twiddle_fact_13 : out COMPLEX_F);
end entity;


architecture arc of fsm is 
	type state is (idle, lvl1, lvl2, lvl3, lvl4, done);
	signal pr_state, next_state : state; 
	begin
		process(clk, reset)
			begin
				if(clk'event and clk='1') then
					if(reset = '1') then
						pr_state <= idle;
					else pr_state <= next_state;
					end if;
				end if;
		end process;
		
		
		process(pr_state, sop)
			begin
					case pr_state is
						when idle => 
							reg_mux_sel <= '1';
							mux00_sel <= "----";
							mux10_sel <= "----";
							mux01_sel <= "----";
							mux11_sel <= "----";
							mux02_sel <= "----";
							mux12_sel <= "----";
							mux03_sel <= "----";
							mux13_sel <= "----";
							mux04_sel <= "----";
							mux14_sel <= "----";
							mux05_sel <= "----";
							mux15_sel <= "----";
							mux06_sel <= "----";
							mux16_sel <= "----";
							mux07_sel <= "----";
							mux17_sel <= "----";
							twiddle_fact_00 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_10 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_01 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_11 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_02 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_12 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_03 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_13 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							eop <= '0';
							ena <= '0';
							if(sop = '1') then
								next_state <= lvl1;
							else next_state <= idle;
							end if;
						when lvl1 => 
							reg_mux_sel <= '0';
							mux00_sel <= x"0";
							mux10_sel <= x"8";
							mux01_sel <= x"4";
							mux11_sel <= x"C";
							mux02_sel <= x"2";
							mux12_sel <= x"A";
							mux03_sel <= x"6";
							mux13_sel <= x"E";
							mux04_sel <= x"1";
							mux14_sel <= x"9";
							mux05_sel <= x"5";
							mux15_sel <= x"D";
							mux06_sel <= x"3";
							mux16_sel <= x"B";
							mux07_sel <= x"7";
							mux17_sel <= x"F";
							twiddle_fact_00 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_10 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_01 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_11 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_02 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_12 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_03 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_13 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							eop <= '0';
							ena <= '1';
							next_state <= lvl2;
						when lvl2 => 
							reg_mux_sel <= '0';
							mux00_sel <= x"0";
							mux10_sel <= x"2";
							mux01_sel <= x"1";
							mux11_sel <= x"3";
							mux02_sel <= x"4";
							mux12_sel <= x"6";
							mux03_sel <= x"5";
							mux13_sel <= x"7";
							mux04_sel <= x"8";
							mux14_sel <= x"A";
							mux05_sel <= x"9";
							mux15_sel <= x"B";
							mux06_sel <= x"C";
							mux16_sel <= x"E";
							mux07_sel <= x"D";
							mux17_sel <= x"F";
							twiddle_fact_00 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_10 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_01 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_11 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_02 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_12 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_03 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_13 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							eop <= '0';
							ena <= '1';
							next_state <= lvl3;
						when lvl3 => 
							reg_mux_sel <= '0';
							mux00_sel <= x"0";
							mux10_sel <= x"4";
							mux01_sel <= x"2";
							mux11_sel <= x"6";
							mux02_sel <= x"1";
							mux12_sel <= x"5";
							mux03_sel <= x"3";
							mux13_sel <= x"7";
							mux04_sel <= x"8";
							mux14_sel <= x"C";
							mux05_sel <= x"A";
							mux15_sel <= x"E";
							mux06_sel <= x"9";
							mux16_sel <= x"D";
							mux07_sel <= x"B";
							mux17_sel <= x"F";
							twiddle_fact_00 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_10 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_01 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_11 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_02 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_12 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_03 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_13 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							eop <= '0';
							ena <= '1';
							next_state <= lvl4;
						when lvl4 => 
							reg_mux_sel <= '0';
							mux00_sel <= x"0";
							mux10_sel <= x"8";
							mux01_sel <= x"3";
							mux11_sel <= x"A";
							mux02_sel <= x"1";
							mux12_sel <= x"9";
							mux03_sel <= x"4";
							mux13_sel <= x"C";
							mux04_sel <= x"3";
							mux14_sel <= x"B";
							mux05_sel <= x"6";
							mux15_sel <= x"E";
							mux06_sel <= x"5";
							mux16_sel <= x"3";
							mux07_sel <= x"7";
							mux17_sel <= x"F";	
							twiddle_fact_00 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_10 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_01 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_11 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_02 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_12 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_03 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_13 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							eop <= '0';
							ena <= '1';
							next_state <= done;
						when done => 
							reg_mux_sel <= '0';
							mux00_sel <= "----";
							mux10_sel <= "----";
							mux01_sel <= "----";
							mux11_sel <= "----";
							mux02_sel <= "----";
							mux12_sel <= "----";
							mux03_sel <= "----";
							mux13_sel <= "----";
							mux04_sel <= "----";
							mux14_sel <= "----";
							mux05_sel <= "----";
							mux15_sel <= "----";
							mux06_sel <= "----";
							mux16_sel <= "----";
							mux07_sel <= "----";
							mux17_sel <= "----";
							twiddle_fact_00 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_10 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_01 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_11 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_02 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_12 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_03 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							twiddle_fact_13 <= COMPLEX_F'((others=>'1'), (others=>'1'));
							eop <= '1';
							ena <= '0';
							next_state <= idle;
					end case;
		end process;	
end;




library ieee, ieee_proposed;
use ieee.std_logic_1164.all;
use ieee.math_complex_f.all;
use ieee_proposed.fixed_pkg.all;



entity fft_unit is
	port(x : in COMPLEX_F_array;
		  reset, clk, fft_sop : in std_logic;
		  fft_eop : out std_logic;
		  y : out COMPLEX_F_array);
end entity;


architecture arc of fft_unit is 
	signal reg_mux_sel, ena, done : std_logic;
	signal state_reg_upper_in, state_reg_upper_out, state_reg_lower_in, state_reg_lower_out : COMPLEX_F_array;
	signal mux_out00, mux_out10, mux_out01, mux_out11, mux_out02, mux_out12, mux_out03, mux_out13, mux_out04, mux_out14, mux_out05, mux_out15,
			mux_out06, mux_out16, mux_out07, mux_out17 : COMPLEX_F;
	
	signal mux00_sel, mux10_sel, mux01_sel, mux11_sel, mux02_sel, mux12_sel, 
			mux03_sel, mux13_sel, mux04_sel, mux14_sel, mux05_sel, mux15_sel, mux06_sel, 
			mux16_sel, mux07_sel, mux17_sel : std_logic_vector(0 to 3);
	signal twiddle_fact_00, twiddle_fact_01, twiddle_fact_02, twiddle_fact_03, twiddle_fact_04, 
			twiddle_fact_05, twiddle_fact_06, twiddle_fact_07 : COMPLEX_F;
			
	component butterfly is port(Ek, Ok : in COMPLEX_F;
		  twiddle_fact : in COMPLEX_F;
		  Xk0, Xk1 : out COMPLEX_F);
	end component;		
	
	component vec_mux is port(x : in COMPLEX_F_array;
		  sel : in std_logic_vector(0 to 3);
		  y : out COMPLEX_F);
	end component;
	
	component state_reg_upper is port(x : in COMPLEX_F_array;
		  ena, reset, clk : in std_logic;
		  Q : out COMPLEX_F_array);
	end component;
	
	component state_reg_lower is port(x : in COMPLEX_F_array;
		  ena, reset, clk : in std_logic;
		  Q : out COMPLEX_F_array);
	end component;
	
	component fsm is port(clk, reset, sop: in std_logic;
		  reg_mux_sel, eop, ena : out std_logic;
		  mux00_sel, mux10_sel, mux01_sel, mux11_sel, mux02_sel, mux12_sel, mux03_sel, mux13_sel, mux04_sel, mux14_sel, mux05_sel, mux15_sel, mux06_sel, mux16_sel, mux07_sel, mux17_sel  : out std_logic_vector(0 to 3);
		  twiddle_fact_00, twiddle_fact_10, twiddle_fact_01, twiddle_fact_11, twiddle_fact_02, twiddle_fact_12, twiddle_fact_03, twiddle_fact_13 : out COMPLEX_F);
	end component;
	
	signal butout00, butout10, butout01, butout11, butout02, butout12, butout03, butout13, butout04, butout14, butout05, butout15,
			butout06, butout16, butout07, butout17 : COMPLEX_F;
			
	begin

	
		ctrl : fsm port map(clk, reset, fft_sop, reg_mux_sel, fft_eop, ena, mux00_sel, mux10_sel, mux01_sel, mux11_sel, mux02_sel, mux12_sel, 
			mux03_sel, mux13_sel, mux04_sel, mux14_sel, mux05_sel, mux15_sel, mux06_sel, 
			mux16_sel, mux07_sel, mux17_sel, twiddle_fact_00, twiddle_fact_01, twiddle_fact_02, twiddle_fact_03, twiddle_fact_04, 
			twiddle_fact_05, twiddle_fact_06, twiddle_fact_07);
		
		state_reg_upper_in <= x when(reg_mux_sel='1') else state_reg_lower_out;
		
		reg0 : state_reg_upper port map(state_reg_upper_in, ena, reset, clk, state_reg_upper_out);
		
		mux_00 : vec_mux port map(state_reg_upper_out, mux00_sel, mux_out00);
		mux_10 : vec_mux port map(state_reg_upper_out, mux10_sel, mux_out10);
		butf_00 : butterfly port map(mux_out00, mux_out10, twiddle_fact_00, butout00, butout10);
		
		mux_01 : vec_mux port map(state_reg_upper_out, mux01_sel, mux_out01);
		mux_11 : vec_mux port map(state_reg_upper_out, mux11_sel, mux_out11);
		butf_01 : butterfly port map(mux_out01, mux_out11, twiddle_fact_01, butout01, butout11);
		
		mux_02 : vec_mux port map(state_reg_upper_out, mux02_sel, mux_out02);
		mux_12 : vec_mux port map(state_reg_upper_out, mux12_sel, mux_out12);
		butf_02 : butterfly port map(mux_out02, mux_out12, twiddle_fact_02, butout02, butout12);
		
		mux_03 : vec_mux port map(state_reg_upper_out, mux03_sel, mux_out03);
		mux_13 : vec_mux port map(state_reg_upper_out, mux13_sel, mux_out13);
		butf_03 : butterfly port map(mux_out03, mux_out13, twiddle_fact_03, butout03, butout13);
		
		mux_04 : vec_mux port map(state_reg_upper_out, mux04_sel, mux_out04);
		mux_14 : vec_mux port map(state_reg_upper_out, mux14_sel, mux_out14);
		butf_04 : butterfly port map(mux_out04, mux_out14, twiddle_fact_04, butout04, butout14);
		
		mux_05 : vec_mux port map(state_reg_upper_out, mux05_sel, mux_out05);
		mux_15 : vec_mux port map(state_reg_upper_out, mux15_sel, mux_out15);
		butf_05 : butterfly port map(mux_out05, mux_out15, twiddle_fact_05, butout05, butout15);
		
		mux_06 : vec_mux port map(state_reg_upper_out, mux06_sel, mux_out06);
		mux_16 : vec_mux port map(state_reg_upper_out, mux16_sel, mux_out16);
		butf_06 : butterfly port map(mux_out06, mux_out16, twiddle_fact_06, butout06, butout16);
		
		mux_07 : vec_mux port map(state_reg_upper_out, mux07_sel, mux_out07);
		mux_17 : vec_mux port map(state_reg_upper_out, mux17_sel, mux_out17);
		butf_07 : butterfly port map(mux_out07, mux_out17, twiddle_fact_07, butout07, butout17);
		
		state_reg_lower_in(0) <= butout00;state_reg_lower_in(1) <= butout10;
		state_reg_lower_in(2) <= butout01;state_reg_lower_in(3) <= butout11;
		state_reg_lower_in(4) <= butout02;state_reg_lower_in(5) <= butout12;
		state_reg_lower_in(6) <= butout03;state_reg_lower_in(7) <= butout13;
		state_reg_lower_in(8) <= butout04;state_reg_lower_in(9) <= butout14;
		state_reg_lower_in(10) <= butout05;state_reg_lower_in(11) <= butout15;
		state_reg_lower_in(12) <= butout06;state_reg_lower_in(13) <= butout16;
		state_reg_lower_in(14) <= butout07;state_reg_lower_in(15) <= butout17;
		
		reg1 : state_reg_lower port map(state_reg_lower_in, ena, reset, clk, state_reg_lower_out);
		
		y <= state_reg_lower_out;
end;



library ieee, ieee_proposed;
use ieee.std_logic_1164.all;
use ieee.math_complex_f.all;
use ieee_proposed.fixed_pkg.all;


entity fft_16 is 
	port(clk, reset : in std_logic;
		  vec_ready, sample_valid: in std_logic;
		  get_out : in std_logic;
		  sop : in std_logic;
		  eop : out std_logic;
		  real_in, imag_in : in std_logic_vector(0 to 15);
		  real_out, imag_out : out std_logic_vector(0 to 15));
end entity;


architecture arc of fft_16 is
	component fft_unit is port(x : in COMPLEX_F_array;
		  reset, clk, fft_sop : in std_logic;
		  fft_eop : out std_logic;
		  y : out COMPLEX_F_array);
	end component;
	
	signal eop_fft : std_logic;
	signal x_vec, y_vec : std_logic_vector(0 to 511);
	signal x, y : COMPLEX_F_array;
	begin
	
		process(clk, reset, vec_ready, sample_valid)
			begin
				if(clk'event and clk='1') then
					if(sample_valid='1') then
						x_vec <= x_vec(32 to 511) & real_in & imag_in;
					end if;
				end if;
		end process;
		
		
		process(clk, reset, vec_ready)
			begin
				if(clk'event and clk='1') then
					if(vec_ready = '1') then
						for i in 0 to 15 loop
							x(i) <= COMPLEX_F'(to_sfixed(x_vec(32*i to 32*i + 15), 8, -7), to_sfixed(x_vec(32*i + 16 to 32*i + 31), 8, -7));
						end loop;
					end if;
				end if;
		end process;
		
		
		process(clk, reset, eop_fft)
			begin
				if(clk'event and clk='1') then
					if(eop_fft='1') then
						for i in 0 to 15 loop
							y_vec(32*i to 32*i + 15) <= to_slv(y(i).RE);
							y_vec(32*i + 16 to 32*i + 31) <= to_slv(y(i).IM);
						end loop;
					elsif(get_out='1') then
							y_vec <= y_vec(479 to 511) & y_vec(0 to 478);
					end if;
				end if;
		end process;
		
		
		fft_unit00 : fft_unit port map(x, reset, clk, sop, eop_fft, y);
		
		real_out <= y_vec(480 to 495);
		imag_out <= y_vec(496 to 511);
		eop <= eop_fft;
end;