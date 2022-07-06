library ieee;
use ieee.std_logic_1164.all;

entity THERMOSTAT is
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
end THERMOSTAT;


architecture BEHAVIOUR of THERMOSTAT is

    signal CURRENT_TEMP_REG, DESIRED_TEMP_REG: std_logic_vector(6 downto 0);
    signal COOL_REG, HEAT_REG, DISPLAY_SELECT_REG: bit;

begin

    process(CLK)
    begin

        if CLK'event and CLK = '1' then
            CURRENT_TEMP_REG <= CURRENT_TEMP;
            DESIRED_TEMP_REG <= DESIRED_TEMP;
            COOL_REG <= COOL;
            HEAT_REG <= HEAT;
            DISPLAY_SELECT_REG <= DISPLAY_SELECT;

            if DISPLAY_SELECT_REG = '1' then
                TEMP_DISPLAY <= CURRENT_TEMP_REG;
            else
                TEMP_DISPLAY <= DESIRED_TEMP_REG;
            end if;


        end if; 
    end process;

    process(CLK)
    begin 
        if CLK'event and CLK = '1' then
            if DESIRED_TEMP_REG < CURRENT_TEMP_REG then
                if COOL_REG = '1' then
                    AC_ON <= '1';
                else
                    AC_ON <= '0';
                end if; 
            
            else
                if DESIRED_TEMP_REG > CURRENT_TEMP_REG then
                    if HEAT_REG = '1' then
                        FURNACE_ON <= '1';
                    else
                        FURNACE_ON <= '0';
                    end if;
                
                else 
                    if DESIRED_TEMP = CURRENT_TEMP then
                        FURNACE_ON <= '0';
                        AC_ON <= '0';
                    end if;
                end if;
            end if; 
        end if; 
        -- LMAO. THIS IS SO NOOBISH. DOG DAYS FR
    end process;

end BEHAVIOUR;