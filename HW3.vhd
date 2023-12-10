LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY HW3 IS
	PORT
	(
		BASYS_clk_100MHz : IN std_logic;
		reset : IN std_logic;
		hsync : OUT std_logic;
		vsync : OUT std_logic;
		rgb : OUT std_logic_vector(11 DOWNTO 0)
	);
END HW3;
ARCHITECTURE Behavioral OF HW3 IS
	COMPONENT Clock_Divider
		PORT
		(
			clk_100MHz : IN std_logic;
			clk_25MHz : OUT std_logic
		);
	END COMPONENT;
	COMPONENT Horizontal_Counter
		PORT
		(
			pclk : IN std_logic;
			rst : IN std_logic;
			en : OUT std_logic;
			hcnt : OUT INTEGER
		);
	END COMPONENT;
	COMPONENT Vertical_Counter
		PORT
		(
			rst : IN std_logic;
			en : IN std_logic;
			vcnt : OUT INTEGER
		);
	END COMPONENT;
	COMPONENT blk_ram_tester
		PORT
		(
			clk : IN std_logic;
			a : IN std_logic_vector(11 DOWNTO 0);
			do : OUT std_logic_vector(7 DOWNTO 0)
		);
	END COMPONENT;
	CONSTANT HA : INTEGER := 640;
	CONSTANT HB : INTEGER := 48;
	CONSTANT HF : INTEGER := 16;
	CONSTANT HS : INTEGER := 96;
	CONSTANT HMAX : INTEGER := HA + HF + HB + HS - 1;
	CONSTANT VA : INTEGER := 480;
	CONSTANT VF : INTEGER := 10;
	CONSTANT VB : INTEGER := 33;
	CONSTANT VS : INTEGER := 2;
	CONSTANT VMAX : INTEGER := VA + VF + VB + VS - 1;
	SIGNAL w_25MHz : std_logic := '0';
	SIGNAL enable : std_logic := '0';
	SIGNAL horcnt : INTEGER := 0;
	SIGNAL vercnt : INTEGER := 0;
	SIGNAL pixelcolor : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL pixeladd : STD_LOGIC_VECTOR(11 DOWNTO 0);
BEGIN
	TIME : Clock_Divider
	PORT MAP
	(
		clk_100MHz => BASYS_clk_100MHz,
		clk_25MHz => w_25MHz
	);
	HCOUNTER : Horizontal_Counter
	PORT MAP
	(
		pclk => w_25MHz,
		rst => reset,
		en => enable,
		hcnt => horcnt
	);
	VCOUNTER : Vertical_Counter
	PORT MAP
	(
		rst => reset,
		en => enable,
		vcnt => vercnt
	);
	OUTPUT_IMAGE_MEM : blk_ram_tester
	PORT MAP
	(
		clk => BASYS_clk_100MHz,
		do => pixelcolor,
		a => pixeladd
	);
	z : PROCESS (horcnt)
	BEGIN
		IF (horcnt <= HA + HF + HS AND horcnt >= HA + HF) THEN
			hsync <= '0';
		ELSE
			hsync <= '1';
		END IF;
	END PROCESS;
	k : PROCESS (vercnt)
	BEGIN
		IF (vercnt <= VA + VF + VS AND vercnt >= VA + VF) THEN
			vsync <= '0';
		ELSE
			vsync <= '1';
		END IF;
	END PROCESS;
	w : PROCESS (horcnt, vercnt)
		VARIABLE j : INTEGER := 0;
	BEGIN
		IF (horcnt >= 287 AND horcnt <= 350 AND vercnt >= 207 AND vercnt <= 270) THEN
			j := (horcnt - 287) + (vercnt - 207) * 64;
			pixeladd <= std_logic_vector(to_unsigned(j, 12));
			rgb(11 DOWNTO 8) <= pixelcolor(7 DOWNTO 4);
			rgb(7 DOWNTO 4) <= pixelcolor(7 DOWNTO 4);
			rgb(3 DOWNTO 0) <= pixelcolor(7 DOWNTO 4);
		ELSE
			pixeladd <= "000000000000";
			rgb(11 DOWNTO 0) <= "000000000000";
		END IF;
	END PROCESS;
END Behavioral;