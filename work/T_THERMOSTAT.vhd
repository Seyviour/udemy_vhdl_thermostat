library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity T_THERMOSTAT is
end T_THERMOSTAT;


architecture TEST of T_THERMOSTAT is 

    signal CLK: std_logic := '0';
    
    signal CURRENT_TEMP: std_logic_vector(6 downto 0);  
    signal DESIRED_TEMP: std_logic_vector(6 downto 0);
    
    signal COOL: std_logic;
    signal HEAT: std_logic;
    
    signal DISPLAY_SELECT: std_logic;
    
    signal FURNACE_HOT: std_logic;
    signal AC_READY: std_logic; 

    signal TEMP_DISPLAY: std_logic_vector(6 downto 0);
    signal AC_ON: std_logic;
    signal FURNACE_ON: std_logic;

    procedure waitForClockToFall is
    begin
        wait until(CLK'event AND CLK = '0');
    end waitForClockToFall;

    procedure waitForClockToRise is 
    begin
        wait until (CLK'EVENT and CLK='1');
    end waitForClockToRise;

    component THERMOSTAT is
        port (

            CLK: in std_logic :='0'; 

            CURRENT_TEMP: in std_logic_vector(6 downto 0);
            DESIRED_TEMP: in std_logic_vector(6 downto 0);
            DISPLAY_SELECT: in std_logic;
            COOL: in std_logic;
            HEAT: in std_logic; 
            TEMP_DISPLAY: out std_logic_vector(6 downto 0);

            AC_ON: out std_logic; 
            AC_READY: in std_logic; 

            FURNACE_ON: out std_logic;
            FURNACE_HOT: in std_logic;

            FAN_ON: out std_logic
        );
    end component;

begin
    UUT: THERMOSTAT port map(CURRENT_TEMP => CURRENT_TEMP,
        DESIRED_TEMP => DESIRED_TEMP,
        DISPLAY_SELECT => DISPLAY_SELECT,
        COOL => COOL,
        HEAT => HEAT,
        TEMP_DISPLAY => TEMP_DISPLAY,
        AC_ON => AC_ON,
        AC_READY => AC_READY,
        FURNACE_ON => FURNACE_ON,
        FURNACE_HOT => FURNACE_HOT,
        CLK => CLK);

clock_process:
process
    variable t : time := 0 ps;
begin
    loop
        t := t + 100 ps; 
        wait for 100 ps;
        CLK <= not CLK;
	exit when t >= 10000 ps;
    
    end loop; 
    wait;    
end process;

main_process:
process
    --variable count: integer := 0; 
begin
    -- TEST : loop
    --     exit when count >= 3; 
    -- end loop; -- TEST

    --count := count + 1;
    waitForClockToFall;
    CURRENT_TEMP <= "1111111";
    DESIRED_TEMP <= "0000000";
    DISPLAY_SELECT <= '0';
    HEAT <= '0';
    COOL <= '0';

    --wait for 10 ps;
    -- STATE: IDLE
    waitForClockToFall;
    DISPLAY_SELECT <= '1'; 
    --wait for 10 ps;

    waitForClockToFall;
    COOL <= '1';
    -- STATE: COOL_ON

    waitForClockToFall;
    AC_READY <= '1';
    -- STATE: AC_NOW_READY

    waitForClockToFall;
    DESIRED_TEMP <= "1111111";
    CURRENT_TEMP <= "0000000";
    DISPLAY_SELECT <= '0';
    AC_READY <= '0';
    --wait for 10 ps;

    waitForClockToFall;
    HEAT <= '1';
    
    waitForClockToFall;
    FURNACE_HOT <= '1';


    waitForClockToFall;
    CURRENT_TEMP <= "0000000";
    DESIRED_TEMP <= "1111111";

    --wait for 10 ps;
    waitForClockToFall;
    HEAT <= '0';

    --wait for 10 ps;
    waitForClockToFall;
    FURNACE_HOT <= '0';

    --wait for 10 ps;
    waitForClockToFall;
    CURRENT_TEMP <= "1111111";
    DESIRED_TEMP <= "0000000";
    --wait for 10 ps;

    waitForClockToFall;
    COOL <= '0';
    --wait for 10 ps;
    waitForClockToFall;
    wait;
end process;

end TEST;