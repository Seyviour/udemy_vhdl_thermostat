library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity T_THERMOSTAT is
end T_THERMOSTAT;


architecture TEST of T_THERMOSTAT is 

    signal CURRENT_TEMP, DESIRED_TEMP, TEMP_DISPLAY: std_logic_vector(6 downto 0);
    signal COOL, HEAT, AC_ON, FURNACE_ON, DISPLAY_SELECT, CLK: bit;

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

            CLK: in bit; 


            CURRENT_TEMP: in std_logic_vector(6 downto 0);
            DESIRED_TEMP: in std_logic_vector(6 downto 0);
            DISPLAY_SELECT: in bit;
            COOL: in bit;
            HEAT: in bit; 
            TEMP_DISPLAY: out std_logic_vector(6 downto 0);
            AC_ON: out bit; 
            FURNACE_ON: out bit
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
        FURNACE_ON => FURNACE_ON,
        CLK => CLK);




clock_process:
process
    variable t : time := 0 ps;
begin
    loop
        t := t + 10 ps; 
        wait for 10 ps;
        CLK <= not CLK;
    
    end loop; 
    wait;    
end process;

main_process:
process
begin
    waitForClockToFall;
    CURRENT_TEMP <= "1111111";
    DESIRED_TEMP <= "0000000";
    DISPLAY_SELECT <= '0';
    HEAT <= '0';
    COOL <= '0';

    wait for 10 ps;
    waitForClockToFall;

    DISPLAY_SELECT <= '1'; 
    wait for 10 ps;
    waitForClockToFall;

    HEAT <= '1';
    wait for 10 ps;
    waitForClockToFall;

    CURRENT_TEMP <= "0000000";
    DESIRED_TEMP <= "1111111";

    wait for 10 ps;
    waitForClockToFall;

    HEAT <= '0';

    wait for 10 ps;
    waitForClockToFall;

    COOL <= '1';

    wait for 10 ps;
    waitForClockToFall;
    
    CURRENT_TEMP <= "1111111";
    DESIRED_TEMP <= "0000000";
    wait for 10 ps;
    waitForClockToFall;

    COOL <= '0';
    wait for 10 ps;
    waitForClockToFall;

    wait;
end process;





end TEST;

    

