library ieee;
use ieee.std_logic_1164.all;

entity THERMOSTAT is
    port (

        CLK: in std_logic; 

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
end THERMOSTAT;


architecture BEHAVIOUR of THERMOSTAT is

    type THERMOSTAT_STATE is (IDLE,
                            COOL_ON,
                            AC_NOW_READY,
                            AC_DONE,
                            HEAT_ON,
                            FURNACE_NOW_HOT,
                            FURNACE_COOL);


    signal CURRENT_TEMP_REG, DESIRED_TEMP_REG: std_logic_vector(6 downto 0);
    
    signal COOL_REG: std_logic; 
    signal HEAT_REG: std_logic;  
    signal DISPLAY_SELECT_REG: std_logic;  
    signal FURNACE_HOT_REG: std_logic;  
    signal AC_READY_REG: std_logic;

    signal CURRENT_STATE, NEXT_STATE: THERMOSTAT_STATE; 

begin

    -- INPUT INGESTION
    process(CLK)
    begin
        if CLK'event and CLK = '1' then
            CURRENT_TEMP_REG <= CURRENT_TEMP;
            DESIRED_TEMP_REG <= DESIRED_TEMP;
            COOL_REG <= COOL;
            HEAT_REG <= HEAT;
            DISPLAY_SELECT_REG <= DISPLAY_SELECT;
            FURNACE_HOT_REG <= FURNACE_HOT;
            AC_READY_REG <= AC_READY;

            if DISPLAY_SELECT_REG = '1' then
                TEMP_DISPLAY <= CURRENT_TEMP_REG;
            else
                TEMP_DISPLAY <= DESIRED_TEMP_REG;
            end if;
        end if; 
    end process;


    -- STATE MACHINE OUTPUT
    -- I GUESS IT'S A MATTER OF STYLE TO MAKE THE OUTPUT SIGNAL OR THE STATE THE HEADER OF EACH BLOCK
    -- I FIND THIS TO BE PLENTY READABLE BUT REALLY STRESSFUL TO WRITE
    process(CLK)
    begin 
        CURRENT_STATE <= NEXT_STATE;
        if CLK'event and CLK = '1' then
            case NEXT_STATE is  
                when IDLE =>
                    FURNACE_ON <= '0';
                    AC_ON <= '0';
                    FAN_ON <= '0';
                
                when COOL_ON =>
                    FURNACE_ON <= '0';
                    AC_ON <= '1';
                    FAN_ON <= '0';
                
                when AC_NOW_READY => 
                    FURNACE_ON <= '0';
                    AC_ON <= '1';
                    FAN_ON <= '1';
                
                when AC_DONE =>
                    FURNACE_ON <= '0';
                    AC_ON <= '0';
                    FAN_ON <= '1';
                
                when HEAT_ON =>
                    FURNACE_ON <= '1';
                    AC_ON <= '0';
                    FAN_ON <= '0';
                
                when FURNACE_NOW_HOT =>
                    FURNACE_ON <= '1';
                    AC_ON <= '0';
                    FAN_ON <= '1';
                
                when FURNACE_COOL =>
                    FURNACE_ON <= '0';
                    AC_ON <= '0';
                    FAN_ON <= '1';    
            end case; 
        end if; 
    end process; 
    

    -- NEXT STATE COMPUTATION
    process (CURRENT_STATE, DESIRED_TEMP_REG, CURRENT_TEMP_REG, HEAT_REG, COOL_REG, AC_READY_REG, FURNACE_HOT_REG)
    begin
        NEXT_STATE <= CURRENT_STATE;
        case CURRENT_STATE is  
            when IDLE =>
            if COOL_REG = '1' and CURRENT_TEMP_REG > DESIRED_TEMP_REG then
                NEXT_STATE <= COOL_ON; 
            elsif HEAT_REG = '1' and CURRENT_TEMP_REG < DESIRED_TEMP_REG then
                NEXT_STATE <= HEAT_ON;
            end if; 

            when COOL_ON => 
            if AC_READY_REG = '1' then
                NEXT_STATE <= AC_NOW_READY;
            end if; 
            
            when AC_NOW_READY => 
            if COOL_REG = '0' or CURRENT_TEMP_REG <= DESIRED_TEMP_REG then
                NEXT_STATE <= AC_DONE;
            end if; 

            when AC_DONE => 
            if AC_READY_REG = '0' then
                NEXT_STATE <= IDLE;
            end if; 
            
            when HEAT_ON => 
            if FURNACE_HOT_REG = '1' then
                NEXT_STATE <= FURNACE_NOW_HOT;
            end if; 

            when FURNACE_NOW_HOT => 
            if HEAT_REG = '0' or CURRENT_TEMP_REG >= DESIRED_TEMP_REG then
                NEXT_STATE <= FURNACE_COOL;
            elsif FURNACE_HOT_REG = '0' then
                NEXT_STATE <= IDLE; 
            end if;

            when FURNACE_COOL =>
            if FURNACE_HOT_REG = '0' then
                NEXT_STATE <= IDLE;
            end if;
            
            when others =>
                NEXT_STATE <= IDLE;
        end case; 
        -- WITH VHDL, IT IS WAY MORE IMPORTANT TO PRIORITIZE DESCRIPTIVENES OVER (SOFTWARE) EFFICIENCY
        -- NESTED IFS CAN BE DIFFICULT TO READ. ME SEF, I FEEL AM AS I DEY WRITE AM
        -- LMAO. THIS IS SO NOOBISH. DOG DAYS FR
    end process;

end BEHAVIOUR;