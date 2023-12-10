LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY blk_ram IS
	PORT
	(
		clk : IN std_logic;
		a : IN std_logic_vector(11 DOWNTO 0);
		do : OUT std_logic_vector(7 DOWNTO 0)
	);
END blk_ram;
ARCHITECTURE Behavioral OF blk_ram IS
	COMPONENT blk_mem_gen_0
		PORT
		(
			clka : IN STD_LOGIC;
			wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
			dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT blk_mem_gen_1
		PORT
		(
			clka : IN STD_LOGIC;
			wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			addra : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;
	component blk_mem_gen_2
	  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
  end component;
	SIGNAL i : INTEGER := 0;
	SIGNAL j : INTEGER := 0;
	SIGNAL g0 : signed(7 DOWNTO 0) := "00000000";
	SIGNAL g1 : signed(7 DOWNTO 0) := "00000000";
	SIGNAL g2 : signed(7 DOWNTO 0) := "00000000";
	SIGNAL g3 : signed(7 DOWNTO 0) := "00000000";
	SIGNAL g4 : signed(7 DOWNTO 0) := "00000000";
	SIGNAL g5 : signed(7 DOWNTO 0) := "00000000";
	SIGNAL g6 : signed(7 DOWNTO 0) := "00000000";
	SIGNAL g7 : signed(7 DOWNTO 0) := "00000000";
	SIGNAL g8 : signed(7 DOWNTO 0) := "00000000";
	SIGNAL done : std_logic := '0';
	SIGNAL done_1 : std_logic := '0';
	SIGNAL done_2 : std_logic := '0';
	SIGNAL done_3 : std_logic := '0';
	SIGNAL is_req : std_logic := '0';
	SIGNAL write_en_rom : std_logic_vector(0 DOWNTO 0) := "0";
	SIGNAL write_en_kernel : std_logic_vector (0 DOWNTO 0) := "0";
	SIGNAL romadd : std_logic_vector(11 DOWNTO 0) := (OTHERS => '0');
	SIGNAL romd : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL wromd : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL kromadd : std_logic_vector(3 DOWNTO 0) := (OTHERS => '0');
	SIGNAL kromd : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL wkromd : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL ramadd : std_logic_vector(11 DOWNTO 0) := (OTHERS => '0');
	signal write_en_ram:std_logic_vector (0 DOWNTO 0) := "1";
	SIGNAL wramd : std_logic_vector(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL ramd : std_logic_vector(15 DOWNTO 0) := (OTHERS => '0');	
	SIGNAL n9 : INTEGER := 0;
	SIGNAL d9 : INTEGER := 0;
	SIGNAL div : INTEGER := 0;
	CONSTANT W : INTEGER := 63;
	CONSTANT L : INTEGER := 63;
	--TYPE ram_type IS ARRAY (4095 DOWNTO 0) OF INTEGER;
	--SIGNAL RAM : ram_type;
	SIGNAL min : INTEGER := 32386;
	SIGNAL max : INTEGER := - 32641;
BEGIN
	ROM : blk_mem_gen_0
	PORT MAP
	(
		clka => clk,
		wea => write_en_rom,
		addra => romadd,
		dina => wromd,
		douta => romd
	);
	KERNEL : blk_mem_gen_1
	PORT MAP
	(
		clka => clk,
		wea => write_en_kernel,
		addra => kromadd,
		dina => wkromd,
		douta => kromd
	);
	blk_ram : blk_mem_gen_2
	PORT MAP
	(
		clka => clk,
		wea => write_en_ram,
		addra => ramadd,
		dina => wramd,
		douta => ramd
	);	
	pr1 : PROCESS (clk)
		VARIABLE count : INTEGER := 0;
	BEGIN
		IF (rising_edge(clk)) THEN
			IF (done = '0') THEN
				IF (count = 0) THEN
					kromadd <= "0000";
					count := 1;
				ELSIF (count = 1) THEN
					count := 2;
				ELSIF (count = 2) THEN
					count := 3;
				ELSIF (count = 3) THEN
					g0 <= signed(kromd);
					kromadd <= "0001";
					count := 4;
				ELSIF (count = 4) THEN
					count := 5;
				ELSIF (count = 5) THEN
					count := 6;
				ELSIF (count = 6) THEN
					g3 <= signed(kromd);
					kromadd <= "0010";
					count := 7;
				ELSIF (count = 7) THEN
					count := 8;
				ELSIF (count = 8) THEN
					count := 9;
				ELSIF (count = 9) THEN
					g6 <= signed(kromd);
					kromadd <= "0011";
					count := 10;
				ELSIF (count = 10) THEN
					count := 11;
				ELSIF (count = 11) THEN
					count := 12;
				ELSIF (count = 12) THEN
					g1 <= signed(kromd);
					kromadd <= "0100";
					count := 13;
				ELSIF (count = 13) THEN
					count := 14;
				ELSIF (count = 14) THEN
					count := 15;
				ELSIF (count = 15) THEN
					g4 <= signed(kromd);
					kromadd <= "0101";
					count := 16;
				ELSIF (count = 16) THEN
					count := 17;
				ELSIF (count = 17) THEN
					count := 18;
				ELSIF (count = 18) THEN
					g7 <= signed(kromd);
					kromadd <= "0110";
					count := 19;
				ELSIF (count = 19) THEN
					count := 20;
				ELSIF (count = 20) THEN
					count := 21;
				ELSIF (count = 21) THEN
					g2 <= signed(kromd);
					kromadd <= "0111";
					count := 22;
				ELSIF (count = 22) THEN
					count := 23;
				ELSIF (count = 23) THEN
					count := 24;
				ELSIF (count = 24) THEN
					g5 <= signed(kromd);
					kromadd <= "1000";
					count := 25;
				ELSIF (count = 25) THEN
					count := 26;
				ELSIF (count = 26) THEN
					count := 27;
				ELSIF (count = 27) THEN
					g8 <= signed(kromd);
					count := 28;
					done <= '1';
				END IF;
			END IF;
		END IF;
	END PROCESS;
	pr2 : PROCESS (clk, done)
		VARIABLE p0 : unsigned(7 DOWNTO 0) := "00000000";
		VARIABLE p1 : unsigned(7 DOWNTO 0) := "00000000";
		VARIABLE p2 : unsigned(7 DOWNTO 0) := "00000000";
		VARIABLE p3 : unsigned(7 DOWNTO 0) := "00000000";
		VARIABLE p4 : unsigned(7 DOWNTO 0) := "00000000";
		VARIABLE p5 : unsigned(7 DOWNTO 0) := "00000000";
		VARIABLE p6 : unsigned(7 DOWNTO 0) := "00000000";
		VARIABLE p7 : unsigned(7 DOWNTO 0) := "00000000";
		VARIABLE p8 : unsigned(7 DOWNTO 0) := "00000000";
		VARIABLE k0 : INTEGER := 0;
		VARIABLE k1 : INTEGER := 0;
		VARIABLE k2 : INTEGER := 0;
		VARIABLE k3 : INTEGER := 0;
		VARIABLE k4 : INTEGER := 0;
		VARIABLE k5 : INTEGER := 0;
		VARIABLE k6 : INTEGER := 0;
		VARIABLE k7 : INTEGER := 0;
		VARIABLE k8 : INTEGER := 0;
		VARIABLE j0 : INTEGER := 0;
		VARIABLE j1 : INTEGER := 0;
		VARIABLE j2 : INTEGER := 0;
		VARIABLE j3 : INTEGER := 0;
		VARIABLE j4 : INTEGER := 0;
		VARIABLE j5 : INTEGER := 0;
		VARIABLE j6 : INTEGER := 0;
		VARIABLE j7 : INTEGER := 0;
		VARIABLE j8 : INTEGER := 0;
		VARIABLE count : INTEGER := 0;
		VARIABLE sum : INTEGER := 0;
		VARIABLE k9 : INTEGER := 0;
		VARIABLE i9 : INTEGER := 0;
		VARIABLE j9 : INTEGER := 0;
		VARIABLE cnt : INTEGER := 0;
		VARIABLE num : INTEGER := 0;
		VARIABLE den : INTEGER := 0;
		VARIABLE quotient : INTEGER := 0;
		variable ct:Integer:=0;
	    variable temp:Integer:=0;
	BEGIN
		k0 := i - 1;
		j0 := j - 1;
		k1 := i - 1;
		j1 := j;
		k2 := i - 1;
		j2 := j + 1;
		k3 := i;
		j3 := j - 1;
		k4 := i;
		j4 := j;
		k5 := i;
		j5 := j + 1;
		k6 := i + 1;
		j6 := j - 1;
		k7 := i + 1;
		j7 := j;
		k8 := i + 1;
		j8 := j + 1;
		IF (rising_edge (clk) AND done = '1') THEN
		IF(done_3='0') then
			IF (i = 0 AND j = 0) THEN
				IF (count = 0) THEN
					romadd <= (OTHERS => '0');
					ramadd <= (OTHERS => '0');
					count := 1;
				ELSIF (count = 1) THEN
					count := 2;
				ELSIF (count = 2) THEN
					count := 3;
				ELSIF (count = 3) THEN
					p4 := unsigned(romd);
					sum := to_integer(p4) * to_integer(g4);
					romadd <= "000000000001";
					count := 4;
				ELSIF (count = 4) THEN
					count := 5;
				ELSIF (count = 5) THEN
					count := 6;
				ELSIF (count = 6) THEN
					p7 := unsigned(romd);
					sum := sum + to_integer(p7) * to_integer(g7);
					romadd <= "000001000000";
					count := 7;
				ELSIF (count = 7) THEN
					count := 8;
				ELSIF (count = 8) THEN
					count := 9;
				ELSIF (count = 9) THEN
					p5 := unsigned(romd);
					sum := sum + to_integer(p5) * to_integer(g5);
					romadd <= "000001000001";
					count := 10;
				ELSIF (count = 10) THEN
					count := 11;
				ELSIF (count = 11) THEN
					count := 12;
				ELSIF (count = 12) THEN
					p8 := unsigned(romd);
					sum := sum + to_integer(p8) * to_integer(g8);
					romadd <= (OTHERS => '0');
					count := 13;
					IF (sum < min) THEN
						min <= sum;
					END IF;
					IF (sum > max) THEN
						max <= sum;
					END IF;
					wramd <=std_logic_vector(to_signed(sum,16));
				elsif(count=13)then
				count:=14;
				elsif(count=14) then
				count:=15;
				elsif(count=15)then
				count:=0;
					i <= 1;
				END IF;
			ELSIF (i > 0 AND i < W AND j = 0) THEN
				IF (count = 0) THEN
					p1 := p4;
					p4 := p7;
					romadd <= std_logic_vector(to_unsigned((64 * j7) + k7, 12));
					ramadd <= std_logic_vector(to_unsigned((64 * j4) + k4, 12));
					count := 1;
				ELSIF (count = 1) THEN
					count := 2;
				ELSIF (count = 2) THEN
					count := 3;
				ELSIF (count = 3) THEN
					p7 := unsigned (romd);
					sum := to_integer(p7) * to_integer(g7) + to_integer(p4) * to_integer(g4) + to_integer(p1) * to_integer(g1);
					p2 := p5;
					p5 := p8;
					romadd <= std_logic_vector(to_unsigned((64 * j8) + k8, 12));
					count := 4;
				ELSIF (count = 4) THEN
					count := 5;
				ELSIF (count = 5) THEN
					count := 6;
				ELSIF (count = 6) THEN
					p8 := unsigned (romd);
					romadd <= (OTHERS => '0');
					sum := sum + to_integer(p8) * to_integer(g8) + to_integer(p5) * to_integer(g5) + to_integer(p2) * to_integer(g2);
					IF (sum < min) THEN
						min <= sum;
					END IF;
					IF (sum > max) THEN
						max <= sum;
					END IF;
					wramd <=std_logic_vector(to_signed(sum,16));
					count:=7;
					elsif(count=7)then
					count:=8;
					elsif(count=8)then
					count:=9;
					elsif(count=9)then					
					i <= i + 1;
					count := 0;
				END IF;
			ELSIF (i = W AND j = 0) THEN
				IF (count = 0) THEN
					romadd <= "000000111111";
					ramadd<="000000111111";
					count := 1;
				ELSIF (count = 1) THEN
					count := 2;
				ELSIF (count = 2) THEN
					count := 3;
				ELSIF (count = 3) THEN
					p4 := unsigned(romd);
					sum := to_integer(p4) * to_integer(g4);
					romadd <= "000000111110";
					count := 4;
				ELSIF (count = 4) THEN
					count := 5;
				ELSIF (count = 5) THEN
					count := 6;
				ELSIF (count = 6) THEN
					p1 := unsigned(romd);
					sum := sum + to_integer(p1) * to_integer(g1);
					romadd <= "000001111111";
					count := 7;
				ELSIF (count = 7) THEN
					count := 8;
				ELSIF (count = 8) THEN
					count := 9;
				ELSIF (count = 9) THEN
					p5 := unsigned(romd);
					sum := sum + to_integer(p5) * to_integer(g5);
					romadd <= "000001111110";
					count := 10;
				ELSIF (count = 10) THEN
					count := 11;
				ELSIF (count = 11) THEN
					count := 12;
				ELSIF (count = 12) THEN
					p2 := unsigned(romd);
					sum := sum + to_integer(p2) * to_integer(g2);
                    wramd <=std_logic_vector(to_signed(sum,16));					
					romadd <= (OTHERS => '0');
					count := 13;
					IF (sum < min) THEN
						min <= sum;
					END IF;
					IF (sum > max) THEN
						max <= sum;
					END IF;
				elsif(count=13)then
				count:=14;
				elsif(count=14)then
				count:=15;
				elsif(count=15)then
				count:=0;
					i <= 0;
					j <= j + 1;
				END IF;
			ELSIF (i = W AND j > 0 AND j < L) THEN
				IF (count = 0) THEN
					romadd <= std_logic_vector(to_unsigned((64 * j3) + k3, 12));
					ramadd<=std_logic_vector(to_unsigned((64 * j4) + k4, 12));
					count := 1;
				ELSIF (count = 1) THEN
					count := 2;
				ELSIF (count = 2) THEN
					count := 3;
				ELSIF (count = 3) THEN
					p3 := unsigned (romd);
					romadd <= std_logic_vector(to_unsigned((64 * j4) + k4, 12));
					count := 4;
				ELSIF (count = 4) THEN
					count := 5;
				ELSIF (count = 5) THEN
					count := 6;
				ELSIF (count = 6) THEN
					p4 := unsigned (romd);
					romadd <= std_logic_vector(to_unsigned((64 * j5) + k5, 12));
					count := 7;
				ELSIF (count = 7) THEN
					count := 8;
				ELSIF (count = 8) THEN
					count := 9;
				ELSIF (count = 9) THEN
					p5 := unsigned (romd);
					romadd <= std_logic_vector(to_unsigned((64 * j0) + k0, 12));
					count := 10;
				ELSIF (count = 10) THEN
					count := 11;
				ELSIF (count = 11) THEN
					count := 12;
				ELSIF (count = 12) THEN
					p0 := unsigned (romd);
					romadd <= std_logic_vector(to_unsigned((64 * j1) + k1, 12));
					count := 13;
				ELSIF (count = 13) THEN
					count := 14;
				ELSIF (count = 14) THEN
					count := 15;
				ELSIF (count = 15) THEN
					p1 := unsigned (romd);
					romadd <= std_logic_vector(to_unsigned((64 * j2) + k2, 12));
					count := 16;
				ELSIF (count = 16) THEN
					count := 17;
				ELSIF (count = 17) THEN
					count := 18;
				ELSIF (count = 18) THEN
					romadd <= (OTHERS => '0');
					p2 := unsigned (romd);
					sum := to_integer(p3) * to_integer(g3) + to_integer(p4) * to_integer(g4) + to_integer(p5) * to_integer(g5) + to_integer(p0) * to_integer(g0) + to_integer(p1) * to_integer(g1) + to_integer(p2) * to_integer(g2);
					IF (sum < min) THEN
						min <= sum;
					END IF;
					IF (sum > max) THEN
						max <= sum;
					END IF;
					wramd <=std_logic_vector(to_signed(sum,16));
					count := 19;
				elsif(count=19)then
				count:=20;
				elsif(count=20)then
				count:=21;
				elsif(count=21) then
				count:=0;
					i <= 0;
					j <= j + 1;

				END IF;
			ELSIF (i = W AND j = L) THEN
				IF (count = 0) THEN
					p0 := p3;
					p3 := p6;
					p1 := p4;
					p4 := p7;
					count := 1;
					ramadd<=std_logic_vector(to_unsigned((64 * j4) + k4, 12));
				ELSIF (count = 1) THEN
					count := 2;
					sum := to_integer(p0) * to_integer(g0) + to_integer(p3) * to_integer(g3) + to_integer(p1) * to_integer(g1) + to_integer(p4) * to_integer(g4);
					IF (sum < min) THEN
						min <= sum;
					END IF;
					IF (sum > max) THEN
						max <= sum;
					END IF;
					wramd <=std_logic_vector(to_signed(sum,16));					
				ELSIF (count = 2) THEN
					count := 3;
				ELSIF (count = 3) THEN
					count := 4;					
				ELSIF (count = 4) THEN
					write_en_ram<="0";
					count := 20;
					i <= W + 1;
					j <= L + 1;
					done_1 <= '1';
				END IF;
			ELSIF (i > 0 AND i < W AND j = L) THEN
				IF (count = 0) THEN
					p0 := p3;
					p3 := p6;
					romadd <= std_logic_vector(to_unsigned((64 * j6) + k6, 12));
					ramadd <= std_logic_vector(to_unsigned((64 * j4) + k4, 12));
					count := 1;
				ELSIF (count = 1) THEN
					count := 2;
				ELSIF (count = 2) THEN
					count := 3;
				ELSIF (count = 3) THEN
					p6 := unsigned (romd);
					sum := to_integer(p6) * to_integer(g6) + to_integer(p3) * to_integer(g3) + to_integer(p0) * to_integer(g0);
					p1 := p4;
					p4 := p7;
					romadd <= std_logic_vector(to_unsigned((64 * j7) + k7, 12));
					count := 4;
				ELSIF (count = 4) THEN
					count := 5;
				ELSIF (count = 5) THEN
					count := 6;
				ELSIF (count = 6) THEN
					p7 := unsigned (romd);
					sum := sum + to_integer(p7) * to_integer(g7) + to_integer(p4) * to_integer(g4) + to_integer(p1) * to_integer(g1);
					romadd <= (OTHERS => '0');
					IF (sum < min) THEN
						min <= sum;
					END IF;
					IF (sum > max) THEN
						max <= sum;
					END IF;
					wramd <=std_logic_vector(to_signed(sum,16));
					count:=7;
					elsif(count=7)then
					count:=8;
					elsif(count=8)then
					count:=9;
					elsif(count=9)then
					i <= i + 1;
					count := 0;
				END IF;
			ELSIF (i = 0 AND j = L) THEN
				IF (count = 0) THEN
					romadd <= std_logic_vector(to_unsigned((64 * j3) + k3, 12));
					ramadd <= std_logic_vector(to_unsigned((64 * j4) + k4, 12));
					count := 1;
				ELSIF (count = 1) THEN
					count := 2;
				ELSIF (count = 2) THEN
					count := 3;
				ELSIF (count = 3) THEN
					p3 := unsigned (romd);
					romadd <= std_logic_vector(to_unsigned((64 * j4) + k4, 12));
					count := 4;
				ELSIF (count = 4) THEN
					count := 5;
				ELSIF (count = 5) THEN
					count := 6;
				ELSIF (count = 6) THEN
					p4 := unsigned (romd);
					romadd <= std_logic_vector(to_unsigned((64 * j6) + k6, 12));
					count := 7;
				ELSIF (count = 7) THEN
					count := 8;
				ELSIF (count = 8) THEN
					count := 9;
				ELSIF (count = 9) THEN
					p6 := unsigned (romd);
					romadd <= std_logic_vector(to_unsigned((64 * j7) + k7, 12));
					count := 10;
				ELSIF (count = 10) THEN
					count := 11;
				ELSIF (count = 11) THEN
					count := 12;
				ELSIF (count = 12) THEN
					p7 := unsigned (romd);
					romadd <= (OTHERS => '0');
					count := 13;
					sum := to_integer(p3) * to_integer(g3) + to_integer(p4) * to_integer(g4) + to_integer(p6) * to_integer(g6) + to_integer(p7) * to_integer(g7);
					IF (sum < min) THEN
						min <= sum;
					END IF;
					IF (sum > max) THEN
						max <= sum;
					END IF;
					wramd <=std_logic_vector(to_signed(sum,16));
				elsif(count=13)then
				count:=14;
				elsif(count=14)then
				count:=15;
				elsif(count=15)then
				count:=0;
					i <= i + 1;
				END IF;
			ELSIF (i = 0 AND j > 0 AND j < L) THEN
				IF (count = 0) THEN
					romadd <= std_logic_vector(to_unsigned((64 * j3) + k3, 12));
					ramadd <= std_logic_vector(to_unsigned((64 * j4) + k4, 12));
					count := 1;
				ELSIF (count = 1) THEN
					count := 2;
				ELSIF (count = 2) THEN
					count := 3;
				ELSIF (count = 3) THEN
					p3 := unsigned (romd);
					romadd <= std_logic_vector(to_unsigned((64 * j4) + k4, 12));
					count := 4;
				ELSIF (count = 4) THEN
					count := 5;
				ELSIF (count = 5) THEN
					count := 6;
				ELSIF (count = 6) THEN
					p4 := unsigned (romd);
					romadd <= std_logic_vector(to_unsigned((64 * j6) + k6, 12));
					count := 7;
				ELSIF (count = 7) THEN
					count := 8;
				ELSIF (count = 8) THEN
					count := 9;
				ELSIF (count = 9) THEN
					p6 := unsigned (romd);
					romadd <= std_logic_vector(to_unsigned((64 * j7) + k7, 12));
					count := 10;
				ELSIF (count = 10) THEN
					count := 11;
				ELSIF (count = 11) THEN
					count := 12;
				ELSIF (count = 12) THEN
					p7 := unsigned (romd);
					romadd <= std_logic_vector(to_unsigned((64 * j5) + k5, 12));
					count := 13;
				ELSIF (count = 13) THEN
					count := 14;
				ELSIF (count = 14) THEN
					count := 15;
				ELSIF (count = 15) THEN
					p5 := unsigned (romd);
					romadd <= std_logic_vector(to_unsigned((64 * j8) + k8, 12));
					count := 16;
				ELSIF (count = 16) THEN
					count := 17;
				ELSIF (count = 17) THEN
					count := 18;
				ELSIF (count = 18) THEN
					p8 := unsigned (romd);
					romadd <= (OTHERS => '0');
					count := 19;
					sum := to_integer(p3) * to_integer(g3) + to_integer(p4) * to_integer(g4) + to_integer(p6) * to_integer(g6) + to_integer(p7) * to_integer(g7) + to_integer(p8) * to_integer(g8) + to_integer(p5) * to_integer(g5);
					IF (sum < min) THEN
						min <= sum;
					END IF;
					IF (sum > max) THEN
						max <= sum;
					END IF;
					wramd <=std_logic_vector(to_signed(sum,16));
				elsif(count=19)then
				count:=20;
				elsif(count=20)then
				count:=21;
				elsif(count=21)then
				count:=0;
					i <= i + 1;
				END IF;
			ELSE
				IF (count = 0) THEN
					p0 := p3;
					p3 := p6;
					romadd <= std_logic_vector(to_unsigned((64 * j6) + k6, 12));
					ramadd <= std_logic_vector(to_unsigned((64 * j4) + k4, 12));
					count := 1;
				ELSIF (count = 1) THEN
					count := 2;
				ELSIF (count = 2) THEN
					count := 3;
				ELSIF (count = 3) THEN
					p6 := unsigned (romd);
					sum := to_integer(p6) * to_integer(g6) + to_integer(p3) * to_integer(g3) + to_integer(p0) * to_integer(g0);
					p1 := p4;
					p4 := p7;
					romadd <= std_logic_vector(to_unsigned((64 * j7) + k7, 12));
					count := 4;
				ELSIF (count = 4) THEN
					count := 5;
				ELSIF (count = 5) THEN
					count := 6;
				ELSIF (count = 6) THEN
					p7 := unsigned (romd);
					sum := sum + to_integer(p7) * to_integer(g7) + to_integer(p4) * to_integer(g4) + to_integer(p1) * to_integer(g1);
					p2 := p5;
					p5 := p8;
					romadd <= std_logic_vector(to_unsigned((64 * j8) + k8, 12));
					count := 7;
				ELSIF (count = 7) THEN
					count := 8;
				ELSIF (count = 8) THEN
					count := 9;
				ELSIF (count = 9) THEN
					p8 := unsigned (romd);
					romadd <= (OTHERS => '0');
					sum := sum + to_integer(p8) * to_integer(g8) + to_integer(p5) * to_integer(g5) + to_integer(p2) * to_integer(g2);
					IF (sum < min) THEN
						min <= sum;
					END IF;
					IF (sum > max) THEN
						max <= sum;
					END IF;
                    wramd <=std_logic_vector(to_signed(sum,16));
                    count:=10;
                   elsif(count=10)then
                   count:=11;
                   elsif(count=11)then
                   count:=12;
                   elsif(count=12)then					
					i <= i + 1;
					count := 0;
				END IF;
			END IF;
			IF (done_1 = '1') THEN
			     if(cnt=0) then
			     ramadd<=std_logic_vector(to_unsigned((64 * j9) + i9, 12));
			     cnt:=1;
			     elsif(cnt=1) then
			     cnt:=2;
			     elsif(cnt=2) then
			     cnt:=3;
				elsIF (cnt = 3) THEN
					k9 := to_integer(signed(ramd)); 
					cnt := 4;
				ELSIF (cnt = 4) THEN
					cnt := 5;
				ELSIF (cnt = 5) THEN
					cnt := 6;
				ELSIF (cnt = 6) THEN
					n9 <= (k9 - min) * 255;
					d9 <= max - min;
					cnt := 7;
				ELSIF (cnt = 7) THEN
					is_req <= '1';
					cnt := 8;
				ELSE
					IF (done_2 = '1') THEN
						IF (cnt = 8) THEN
                            wramd <=std_logic_vector(to_signed(div,16));
							cnt := 9;
						ELSIF (cnt = 9) THEN
							cnt := 10;
						ELSIF (cnt = 10) THEN
							cnt := 11;
						ELSIF (cnt = 11) THEN
							cnt := 0;
							done_2 <= '0';
							write_en_ram<="0";
							div <= 0;
							IF (i9 < w) THEN
								i9 := i9 + 1;
							ELSIF (i9 = W) THEN
								IF (j9 < L) THEN
									i9 := 0;
									j9 := j9 + 1;
									done_3 <= '0';
								ELSIF (j9 = L) THEN
									done_3 <= '1';
									write_en_ram<="0";
									i9 := 64;
									j9 := 64;
									cnt := 12;
								END IF;
							END IF;
						END IF;
					END IF;
				END IF;
			END IF;
			IF (is_req = '1') THEN
				IF (n9 >= d9) THEN
					n9 <= n9 - d9;
					div <= div + 1;
				ELSE
					done_2 <= '1';
					write_en_ram<="1";
					is_req <= '0';
				END IF;
			END IF;
--			end if;
--		iF(done_3='1') then
else
	       if(ct=0)then
	       ct:=1;
	       write_en_ram<="0";
	       ramadd<=a;
	       elsif(ct=1) then
	       temp:=to_integer(signed(ramd));
		do <= std_logic_vector(to_signed(temp, 8));
		ct:=0;
	       --elsif(ct=2) then
	       --ct:=3;
	       --elsif(ct=3) then
	      -- ct:=0;		
		end if;		
		end if;
		END IF;
	END PROCESS;
--	pr3 : PROCESS (done_3, a)
--	variable ct:Integer:=0;
--	variable temp:Integer:=0;
--	BEGIN
--	       if(ct=0)then
--	       ct:=1;
--	       ramadd<=a;
--	       elsif(ct=1) then
--	       ct:=2;
--	       elsif(ct=2) then
--	       ct:=3;
--	       elsif(ct=3) then
--	       temp:=to_integer(signed(ramd));
--		do <= std_logic_vector(to_signed(temp, 8));
--		ct:=0;
--		end if;
--	END PROCESS;
END Behavioral;
