# Polyscience Chiller EPICS IOC

## Overview

This is an EPICS IOC for controlling and monitoring Polyscience chillers using the StreamDevice protocol. The IOC communicates via RS-232 serial commands through an Ethernet-to-Serial converter.

## Features

- Temperature monitoring (internal and external probes)
- Temperature setpoint control
- Pump speed control
- High/Low temperature alarms
- Operation status monitoring
- Compatible with chillerSmc database structure for OPI reuse

## Hardware Configuration

**Ethernet-to-Serial Converter:**
- Host: `scelimxa8001.int.eli-np.ro`
- Port: `4001`
- Baud rate: 9600
- Data bits: 8
- Stop bits: 1
- Parity: None

## Building the IOC

1. Ensure EPICS base and required support modules are installed:
   - EPICS Base (configured in `configure/RELEASE`)
   - ASYN module
   - StreamDevice module

2. Edit `configure/RELEASE` if your EPICS installation paths differ

3. Build the IOC:
   ```bash
   cd /app/IOC-DEVEL/chiller-polyscience
   make clean uninstall
   make
   ```

## Running the IOC

1. Navigate to the IOC boot directory:
   ```bash
   cd iocBoot/polyscience-ioc
   ```

2. Make the startup script executable (if needed):
   ```bash
   chmod +x st.cmd
   ```

3. Run the IOC:
   ```bash
   ./st.cmd
   ```

## PV Structure

The IOC uses the following PV naming convention (prefix: `ELI:CHILLER:POLYSCI`):

### Temperature Monitoring
- `$(P):INT_TEMP_RB` - Internal temperature readback (alias: `TEMP_RB`)
- `$(P):EXT_TEMP_RB` - External temperature readback
- `$(P):TEMP_SETPT_RB` - Temperature setpoint readback
- `$(P):TEMP_SETPT_SP` - Temperature setpoint control (alias: `TEMP_SP`)

### Control
- `$(P):CTR_SP` - Chiller On/Off control (alias: `STATE_SP`)
- `$(P):PUMP_SPEED_SP` - Pump speed setpoint (0-70)
- `$(P):PUMP_SPEED_RB` - Pump speed readback

### Status
- `$(P):STATE_RB` - Decoded state (OFF/RUN/WARNING/ALARM)
- `$(P):OPERATION_STATUS_RB` - Operation status (Standby/Running)
- `$(P):ALARM_STATUS_RB` - Alarm status
- `$(P):POWER_STATUS_RB` - Power status

### Alarms
- `$(P):HIGH_ALARM_SP` - High temperature alarm setpoint
- `$(P):HIGH_ALARM_RB` - High temperature alarm readback
- `$(P):LOW_ALARM_SP` - Low temperature alarm setpoint
- `$(P):LOW_ALARM_RB` - Low temperature alarm readback

### Information
- `$(P):FIRMWARE_RB` - Firmware revision
- `$(P):TEMP_UNITS_RB` - Temperature units (C/F)
- `$(P):LOCKOUT_STATUS_RB` - Local lockout status

## OPI (Operator Interface)

A CS-Studio/Phoebus OPI file is provided in the `opi/` directory:
- `Chiller-polyscience.bob` - Main chiller control screen

The OPI provides:
- Real-time temperature monitoring
- Setpoint control
- On/Off control
- Pump speed control
- Alarm configuration
- Status display

To use the OPI:
1. Open CS-Studio or Phoebus
2. Open the file `opi/Chiller-polyscience.bob`
3. Adjust the macro `P` to match your PV prefix if different from `ELI:CHILLER:POLYSCI`

## Configuration

### Changing the PV Prefix

Edit the PV prefix in `iocBoot/polyscience-ioc/st.cmd`:
```bash
dbLoadRecords("db/polyscience.db", "P=YOUR:PREFIX:HERE,PORT=POLYSCI")
```

### Changing Network Settings

Edit the network configuration in `iocBoot/polyscience-ioc/st.cmd`:
```bash
drvAsynIPPortConfigure("POLYSCI", "your-host:your-port", 0, 0, 0)
```

### Changing Serial Settings

Modify the serial port parameters in `iocBoot/polyscience-ioc/st.cmd`:
```bash
asynSetOption("POLYSCI", 0, "baud", "9600")
asynSetOption("POLYSCI", 0, "bits", "8")
asynSetOption("POLYSCI", 0, "parity", "none")
asynSetOption("POLYSCI", 0, "stop", "1")
```

## Communication Protocol

The IOC uses the Polyscience chiller RS-232 communication protocol. Key commands:

- `RT` - Read internal temperature
- `RR` - Read external temperature
- `RS` - Read setpoint
- `SSxxx.xx` - Set temperature setpoint
- `SO0/1` - Turn chiller off/on
- `RF` - Read alarm status
- `RM` - Read pump speed
- `SMx` - Set pump speed

All commands are terminated with CR (carriage return).

## Troubleshooting

### Enable ASYN Debugging

Uncomment the following lines in `st.cmd` to enable debug traces:
```bash
asynSetTraceMask("POLYSCI", 0, 0x9)   # Enable DRIVER and ERROR traces
asynSetTraceIOMask("POLYSCI", 0, 0x2) # Enable HEX I/O traces
```

### Common Issues

1. **No communication**: Check network connectivity to the Ethernet-to-Serial converter
2. **Invalid responses**: Verify serial port settings match the chiller configuration
3. **PV not found**: Check the PV prefix in st.cmd matches your OPI configuration

## Compatibility

This IOC maintains database compatibility with the chillerSmc IOC structure, allowing reuse of existing OPI screens. The key compatible PV names are:

- `TEMP_RB` (alias for `INT_TEMP_RB`)
- `TEMP_SP` (alias for `TEMP_SETPT_SP`)
- `STATE_SP` (alias for `CTR_SP`)
- `STATE_RB`

## References

- [Polyscience Communications Manual](docs/12118-30manual.pdf)
- [Polyscience Commands](docs/commands.txt)
- EPICS StreamDevice Documentation
- ASYN Module Documentation

## Authors

Created for ELI-NP facility.

## License

EPICS Open License
