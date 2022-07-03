library ieee;
use ieee.std_logic_1164.all;

entity THERMOSTATDISPLAY is
    port (
        CURRENT_TEMP: in std_logic_vector(6 downto 0);
        DESIRED_TEMP: in std_logic_vector(6 downto 0);
        DISPLAY_SELECT: in bit;
        TEMP_DISPLAY: out std_logic_vector(6 downto 0)
    );
end THERMOSTATDISPLAY;


architecture BEHAVIOUR of THERMOSTATDISPLAY is

begin
    process(CURRENT_TEMP, DESIRED_TEMP, DISPLAY_SELECT)
    begin
        if DISPLAY_SELECT = '1' then
            TEMP_DISPLAY <= CURRENT_TEMP;
        else
            TEMP_DISPLAY <= DESIRED_TEMP;
        end if; 
    end process; 
end BEHAVIOUR;