# Entity: THERMOSTAT 

- **File**: vhdl_thermostat.vhd
## Diagram

![Diagram](vhdl_thermostat.svg "Diagram")
## Ports

| Port name      | Direction | Type                         | Description |
| -------------- | --------- | ---------------------------- | ----------- |
| CLK            | in        | std_logic                    |             |
| CURRENT_TEMP   | in        | std_logic_vector(6 downto 0) |             |
| DESIRED_TEMP   | in        | std_logic_vector(6 downto 0) |             |
| DISPLAY_SELECT | in        | std_logic                    |             |
| COOL           | in        | std_logic                    |             |
| HEAT           | in        | std_logic                    |             |
| TEMP_DISPLAY   | out       | std_logic_vector(6 downto 0) |             |
| AC_ON          | out       | std_logic                    |             |
| AC_READY       | in        | std_logic                    |             |
| FURNACE_ON     | out       | std_logic                    |             |
| FURNACE_HOT    | in        | std_logic                    |             |
| FAN_ON         | out       | std_logic                    |             |
## Signals

| Name               | Type                         | Description |
| ------------------ | ---------------------------- | ----------- |
| CURRENT_TEMP_REG   | std_logic_vector(6 downto 0) |             |
| DESIRED_TEMP_REG   | std_logic_vector(6 downto 0) |             |
| COOL_REG           | std_logic                    |             |
| HEAT_REG           | std_logic                    |             |
| DISPLAY_SELECT_REG | std_logic                    |             |
| FURNACE_HOT_REG    | std_logic                    |             |
| AC_READY_REG       | std_logic                    |             |
| CURRENT_STATE      | THERMOSTAT_STATE             |             |
| NEXT_STATE         | THERMOSTAT_STATE             |             |
## Types

| Name             | Type                                                                                                                                                                                                                                                                                                   | Description |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| THERMOSTAT_STATE | (IDLE,<br><span style="padding-left:20px"> COOL_ON,<br><span style="padding-left:20px"> AC_NOW_READY,<br><span style="padding-left:20px"> AC_DONE,<br><span style="padding-left:20px"> HEAT_ON,<br><span style="padding-left:20px"> FURNACE_NOW_HOT,<br><span style="padding-left:20px"> FURNACE_COOL) |             |
## Processes
- unnamed: ( CLK )
- unnamed: ( CLK )
- unnamed: ( CURRENT_STATE, DESIRED_TEMP_REG, CURRENT_TEMP_REG, HEAT_REG, COOL_REG )
## State machines

![Diagram_state_machine_0]( stm_THERMOSTAT_00.svg "Diagram")