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
    Port ( CLK : in  STD_LOGIC;
           SW : in  STD_LOGIC_VECTOR (7 downto 0);
			  Coef : in STD_LOGIC_VECTOR (7 downto 0); 
           Divider : in  STD_LOGIC_VECTOR (7 downto 0);
           Reset : in  STD_LOGIC;
           SetCoeff : in  STD_LOGIC;
           SetDivider : in  STD_LOGIC;
           LED : out  STD_LOGIC_VECTOR (7 downto 0));
end FirFilter;


architecture Behavioral of FirFilter is
signal Coeff : STD_LOGIC_VECTOR(7 downto 0) := X"A3"; 
signal MulOut : STD_LOGIC_VECTOR (15 downto 0);
begin
mulout <= STD_LOGIC_VECTOR(signed(coef) * signed(SW)); 
LED <= mulout (7 downto 0); 
end Behavioral;

