library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity printer is

	port(
		clk	: in	std_logic;
		i	: in	std_logic; -- 1-> ON 0-> OFF
		a	: in	std_logic; -- add 1 page 
		c	: in	std_logic; -- start printing 
		d	: in	std_logic; -- sub 1 page 
		p 	: out	std_logic; 
		V 	: out std_logic_vector(7 downto 0)
	);

end entity;

architecture rtl of printer is

	signal tot_reg : unsigned(7 downto 0):= "00000001"; -- total pages register
	signal p_reg : unsigned(7 downto 0):= "00000000";
	signal V_reg : unsigned(7 downto 0):= "00000000"; -- 8bit output displaying numer of pages

	signal s : std_logic_vector(2 downto 0):="000";
	signal N : std_logic_vector(2 downto 0);
	signal tot	: std_logic;
	signal time	: std_logic;
	
begin
	
	tot<= '1' when(0<tot_reg and tot_reg<200) else '0';
	time<= '1' when(p_reg>=50) else '0';
	
	N(0)<=(not(s(2)) and not(s(1)) and not(s(0)) and i) or (not(s(2)) and not(s(1)) and s(0) and not(a) and d and not(c) and tot) or (s(2) and not(s(1)) and not(s(0)) and not(time) and tot) or (s(2) and not(s(1)) and not(s(0)) and not(tot)) or (not(s(2)) and s(1) and not(s(0))) or (not(s(2)) and s(1) and s(0));
	
	N(1)<=(not(s(2)) and not(s(1)) and s(0) and not(d) and a and not(c) and tot) or (not(s(2)) and not(s(1)) and s(0) and not(a) and d and not(c) and tot) or (s(2) and not(s(1)) and not(s(0)) and time and tot);
	
	N(2)<=(not(s(2)) and not(s(1)) and s(0) and c) or (s(2) and not(s(1)) and not(s(0)) and not(time) and tot) or (s(2) and not(s(1)) and not(s(0)) and time and tot) or (s(2) and not(s(1)) and s(0)) or (s(2) and s(1) and not(s(0)));
	
	p<=(s(2) and not(s(1)) and not(s(0)) and not(time) and tot);

	process (clk, i)
	begin
		if i = '0' then
			s<="000";
		elsif (rising_edge(clk)) then
			s <= N;
			case s is
				when "010" =>
					tot_reg <= tot_reg + 1;
					V_reg <= V_reg + 1;
				when "011" =>
					tot_reg <= tot_reg - 1;
					V_reg <= V_reg - 1;
				when "101" =>
					p_reg <= p_reg + 1;
				when "110" =>
					tot_reg <= tot_reg - 1;
					V_reg <= V_reg - 1;
					p_reg <= "00000000";
				when others => 
					null;
			end case;
		end if;
	end process;
	V <= std_logic_vector(V_reg);
end rtl;
