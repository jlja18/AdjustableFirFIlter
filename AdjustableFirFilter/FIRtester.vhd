--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:43:00 04/16/2020
-- Design Name:   
-- Module Name:   E:/GitHub/AdjustableFirFIlter/AdjustableFirFilter/FIRtester.vhd
-- Project Name:  AdjustableFirFilter
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FirFilter
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL; 
USE ieee.std_logic_unsigned.ALL; 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY FIRtester IS
END FIRtester;
 
ARCHITECTURE behavior OF FIRtester IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FirFilter
    PORT(
         sync : IN  std_logic;
         clk : IN  std_logic;
         DataIN : IN  std_logic_vector(15 downto 0);
         DataOUT : OUT  std_logic_vector(15 downto 0);
         Reset : IN  std_logic;
         order : IN  std_logic_vector(7 downto 0);
         point : IN  std_logic_vector(4 downto 0);
			LOADCOEFF : IN STD_LOGIC; 
         LED : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal sync : std_logic := '0';
   signal clk : std_logic := '0';
   signal DataIN : std_logic_vector(15 downto 0) := (others => '0');
   signal Reset : std_logic := '0';
   signal order : std_logic_vector(7 downto 0) := (X"0A");
   signal point : std_logic_vector(4 downto 0) := ("01111");
	signal LOADCOEFF : STD_LOGIC := '0'; 

 	--Outputs
   signal DataOUT : std_logic_vector(15 downto 0);
   signal LED : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	constant sync_period : time := 1000 ns; 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FirFilter PORT MAP (
          sync => sync,
          clk => clk,
          DataIN => DataIN,
          DataOUT => DataOUT,
          Reset => Reset,
          order => order,
          point => point,
			 LOADCOEFF => LOADCOEFF,
          LED => LED
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
	Sync_process : process
	begin
		sync <= '0';
		wait for sync_period/2; 
		sync <= '1';
		wait for sync_period/2; 
	end process; 
	

	
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
      wait for clk_period*10;
		wait until rising_edge(sync); 
			LOADCOEFF <= '1'; 
			order <= X"0A"; 
	   wait until falling_edge(sync);
			DataIN <= X"00A7";
         wait until falling_edge(sync);
			DataIN <= X"01A1";
		wait until falling_edge(sync);
			DataIN <= X"0460";
		wait until falling_edge(sync);
			DataIN <= X"082C";
		wait until falling_edge(sync);
			DataIN <= X"0B7D";
		wait until falling_edge(sync);
			DataIN <= X"0CCD";
		wait until falling_edge(sync);
			DataIN <= X"0B7D";
		wait until falling_edge(sync); 
			DataIN <= X"082C";
		wait until falling_edge(sync);
			DataIN <= X"0460";
		wait until falling_edge(sync);
			DataIN <= X"01A1";
		wait until falling_edge(sync);
			DataIN <= X"00A7";
		wait until rising_edge(sync); 
		 LOADCOEFF <= '0'; 
		wait until falling_edge(sync); 
		 dataIN <= X"7FFF"; 
		wait until falling_edge(sync); 
		 dataIN <= X"0000";
		 
		 for i in 0 to 100 loop
		 dataIN <= X"7FFF"; 
		 wait until falling_edge(sync); 
		 dataIN <= ((not X"7FFF") + 1);
		 wait until falling_edge(sync);  
		 end loop; 
      wait;
   end process;

END;
