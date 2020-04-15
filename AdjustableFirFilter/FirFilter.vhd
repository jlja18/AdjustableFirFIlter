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
           Divider : in  STD_LOGIC_VECTOR (15 downto 0);
           Reset : in  STD_LOGIC;
			  order : in STD_LOGIC_VECTOR (7 downto 0));
		
end FirFilter;


architecture Behavioral of FirFilter is
type coefficients is array (0 to 100) of signed (15 downto 0); 
type DataStore is array (0 to 100) of signed (15 downto 0); 

signal coeff : coefficients := (X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000", X others => X"0000"); 
signal DelayData : DataStore;

signal state : unsigned (7 downto 0); 
signal result : signed (31 downto 0);

signal stop : STD_LOGIC := '0'; 

begin

	process(clk) -- calculate output and sum
	begin
		if ((clk'event and clk = '1') and stop = '0') then
			state <= state + 1; 
			result <= result + DelayData(to_integer(state)) * coeff(to_integer(state));
			if (state = unsigned(order)) then
				state <= X"00";
				stop <= '1'; 
			end if; 
		end if; 
		
	end process; 
	
	
	
end Behavioral;

