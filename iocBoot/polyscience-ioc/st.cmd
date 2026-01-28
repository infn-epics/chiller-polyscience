#!../../bin/linux-x86_64/polyscience-ioc

#- You may have to change polyscience-ioc to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/polyscience-ioc.dbd"
polyscience_ioc_registerRecordDeviceDriver pdbbase

#=============================================================================
# ASYN Configuration for Ethernet-to-Serial Gateway
#=============================================================================

# Configure ASYN port for TCP/IP connection to ethernet-serial converter
# drvAsynIPPortConfigure("PORT_NAME", "HOST:PORT", priority, disable_auto_connect, no_process_eos)
# HOST: scelimxa8001.int.eli-np.ro
# PORT: 4001
drvAsynIPPortConfigure("POLYSCI", "scelimxa8001.int.eli-np.ro:4001", 0, 0, 0)

# Set trace mask for debugging (comment out for normal operation)
#asynSetTraceMask("POLYSCI", 0, 0x9)   # Enable DRIVER and ERROR traces
#asynSetTraceIOMask("POLYSCI", 0, 0x2) # Enable HEX I/O traces

# NOTE: Serial port parameters (baud, bits, parity, stop) are NOT configurable
# for IP ports. These must be set on the ethernet-to-serial converter device itself.
# Polyscience settings: 9600 baud, 8 data bits, 1 stop bit, no parity

#=============================================================================
# StreamDevice Configuration
#=============================================================================

# Set protocol file path
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/polyscienceApp/Db")

#=============================================================================
# Load Database Records
#=============================================================================

# Load the database with your PV prefix
# Example prefix: "ELI:CHILLER:POLYSCI"
# Change this to match your site's naming convention

# Hardware-specific records (StreamDevice communication)
dbLoadRecords("db/polyscience.db", "P=ELI:CHILLER:POLYSCI,PORT=POLYSCI")

# Unicool interface records (aliases, state calculation, status bits)
dbLoadRecords("db/unicool-poly.db", "P=ELI:CHILLER:POLYSCI")

#=============================================================================
# IOC Initialization
#=============================================================================

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncxxx, "user=mxaHost"
