library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity T_THERMOSTAT is
end T_THERMOSTAT;


architecture TEST of T_THERMOSTAT is 

    component THERMOSTAT is
        port (
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

    signal CURRENT_TEMP, DESIRED_TEMP, TEMP_DISPLAY: std_logic_vector(6 downto 0);
    signal COOL, HEAT, AC_ON, FURNACE_ON, DISPLAY_SELECT: bit;

begin

    UUT: THERMOSTAT port map(CURRENT_TEMP => CURRENT_TEMP,
        DESIRED_TEMP => DESIRED_TEMP,
        DISPLAY_SELECT => DISPLAY_SELECT,
        COOL => COOL,
        HEAT => HEAT,
        TEMP_DISPLAY => TEMP_DISPLAY,
        AC_ON => AC_ON,
        FURNACE_ON => FURNACE_ON);

process
begin
    CURRENT_TEMP <= "1111111";
    DESIRED_TEMP <= "0000000";
    DISPLAY_SELECT <= '0';
    HEAT <= '0';
    COOL <= '0';
    wait for 10 ns; 
    DISPLAY_SELECT <= '1'; 
    wait for 10 ns;
    HEAT <= '1';
    wait for 10 ns;
    CURRENT_TEMP <= "0000000";
    DESIRED_TEMP <= "1111111";
    wait for 10 ns; 
    HEAT <= '0';
    wait for 10 ns; 
    COOL <= '1';
    wait for 10 ns;
    CURRENT_TEMP <= "1111111";
    DESIRED_TEMP <= "0000000";
    wait for 10 ns; 
    COOL <= '0';
    wait for 10 ns; 
    wait;
end process;
end TEST;

    

