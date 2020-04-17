----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:06:09 04/14/2020 
-- Design Name: 
-- Module Name:    FirFilter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FirFilter is
    Port ( sync : in  STD_LOGIC;
           clk : in STD_LOGIC; 
			  DataIN : in STD_LOGIC_VECTOR (15 downto 0);  
			  DataOUT : out STD_LOGIC_VECTOR (15 downto 0); 
           Reset : in  STD_LOGIC;
			  order : in STD_LOGIC_VECTOR (7 downto 0);
			  point : in STD_LOGIC_VECTOR (4 downto 0); 
			  LOADCOEFF : in STD_LOGIC; 
			  LED : out STD_LOGIC); 
		
end FirFilter;


architecture Behavioral of FirFilter is
type coefficients is array (0 to 100) of signed (15 downto 0); 
type DataStore is array (0 to 100) of signed (15 downto 0); 

signal coeff : coefficients := (X"00FF",X"00AF",X"00FF",X"00FF",X"00AF",X"00FF",X"00AF",X"00DF",X"00AF",X"00AF",X"00CF", others => X"0000"); 
signal DelayData : DataStore := (X"00FF",X"00FF",X"00FF",X"00FF",X"00FF",X"00FF",X"00FF",X"00FF",X"00FF",X"00FF",X"00FF", others => X"0000");

signal counter : unsigned (7 downto 0) :=  X"00"; 
signal result : signed (31 downto 0) := X"00000000";
signal resultvect : STD_LOGIC_VECTOR (31 downto 0) := X"00000000"; 

signal state : STD_LOGIC_VECTOR (1 downto 0) := "10"; 
signal countCo : integer := 0; 

begin

	LED <= result(0); 
	dataOUT <= resultvect(15 downto 0); 

	process(sync)
	begin
	if (sync'event and sync = '1') then
		if (reset = '1') then 
			countCo <= 0; 
		elsif(LOADCOEFF = '1') then
			coeff(countCo) <= signed(DataIN); 
			countCo <= countCo + 1; 
		end if; 
	end if; 
	end process; 

	process(sync)
	begin
		if (sync'event and sync = '1') then
			if (LOADCOEFF = '0') then 
				for I in 100 downto 1 loop
					DelayData(I) <= DelayData(I - 1); 
				end loop; 
				DelayData(0) <= signed(DataIN); 
			else
				for I in 100 downto 1 loop
					DelayData(I) <= X"0000"; 
				end loop; 
					DelayData(0) <= X"0000";
			end if;
		end if; 
	end process; 
	

	
	process(state, clk, sync) 
	begin
		if (loadcoeff = '0') then
			case state is 
			when "00" =>
				if (clk'event and clk = '1') then 
					counter <= counter + 1; 
					result <= result + DelayData(to_integer(counter)) * coeff(to_integer(counter));
					if (counter = unsigned(order)) then
						state <= "01"; 
						counter <= X"00"; 
					end if; 
				end if; 
			when "01" =>
				if (clk'event and clk = '1') then 
					result <= shift_right(result, 1); 
					counter <= counter + 1; 
					if (counter = (unsigned(point)) - 1) then
						state <= "10"; 
						counter <= X"00"; 
					end if; 
				end if;
			when "10" =>
				resultvect <= STD_LOGIC_VECTOR(result); 
				if (sync'event and sync = '1') then
					state <= "00"; 
					result <= X"00000000"; 
				end if; 
			when others =>
			end case; 
		else 
			result <= X"00000000"; 
			counter <= X"00";
			state <= "10";
		end if; 
	end process; 
	
	
end Behavioral;

