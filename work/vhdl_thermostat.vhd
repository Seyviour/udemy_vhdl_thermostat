library ieee;
use ieee.std_logic_1164.all;

entity THERMOSTAT is
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
end THERMOSTAT;


architecture BEHAVIOUR of THERMOSTAT is

begin
    process(CURRENT_TEMP, DESIRED_TEMP, DISPLAY_SELECT)
    begin
        if DISPLAY_SELECT = '1' then
            TEMP_DISPLAY <= CURRENT_TEMP;
        else
            TEMP_DISPLAY <= DESIRED_TEMP;
        end if; 
    end process;


    AC_ON <= '1' WHEN COOL = '1' AND DESIRED_TEMP < CURRENT_TEMP ELSE '0';

    WITH (HEAT = '1' AND (DESIRED_TEMP < CURRENT_TEMP)) SELECT 
        FURNACE_ON <= '1' WHEN TRUE,
        '0' WHEN OTHERS;

end BEHAVIOUR;