#!../../bin/linux-x86_64/polyscience-ioc

#----------------------------------------------------------------------
# Polyscience Chiller IOC - Startup Script
#----------------------------------------------------------------------
# Connection: Ethernet-to-Serial converter
# Server: scelimxa8001.int.eli-np.ro
# Port: 4001
# Protocol: Serial ASCII over TCP (transparent converter)
#----------------------------------------------------------------------

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/polyscience-ioc.dbd"
polyscience_ioc_registerRecordDeviceDriver pdbbase

# Set protocol file path
epicsEnvSet("STREAM_PROTOCOL_PATH", "${TOP}/iocBoot/${IOC}/")

#----------------------------------------------------------------------
# GLOBAL CONFIGURATION
#----------------------------------------------------------------------
epicsEnvSet("IOC_PREFIX", "LEL:CHL")
epicsEnvSet("SERVER", "scelimxa8001.int.eli-np.ro")
epicsEnvSet("TCP_PORT", "4001")
epicsEnvSet("ASYN_PORT", "POLYSCI_Asyn")

#======================================================================
# CHILLER: Polyscience (Port 4001)
#======================================================================
epicsEnvSet("DEV", "$(IOC_PREFIX):POLYSCI:01")

# Configure IP connection to ethernet-to-serial converter
# Format: drvAsynIPPortConfigure(portName, hostInfo, priority, noAutoConnect, noProcessEos)
drvAsynIPPortConfigure("$(ASYN_PORT)", "$(SERVER):$(TCP_PORT)", 0, 0, 0)

# Set terminators for Polyscience protocol (CR only)
asynOctetSetInputEos("$(ASYN_PORT)", 0, "\r")
asynOctetSetOutputEos("$(ASYN_PORT)", 0, "\r")

# Enable asyn trace for debugging (comment out in production)
#asynSetTraceMask("$(ASYN_PORT)", 0, 0x9)
#asynSetTraceIOMask("$(ASYN_PORT)", 0, 0x2)

# Load device database
dbLoadRecords("db/polyscience.db", "P=$(DEV), PORT=$(ASYN_PORT)")
dbLoadRecords("db/polyscience-compat.db", "P=$(DEV)")

#----------------------------------------------------------------------
# IOC INITIALIZATION
#----------------------------------------------------------------------
cd "${TOP}/iocBoot/${IOC}"
iocInit

#----------------------------------------------------------------------
# POST-INITIALIZATION
#----------------------------------------------------------------------
epicsThreadSleep 2

# Query device ID at startup
dbpf "$(DEV):ID_RB.PROC" 1

# Print IOC info
echo "============================================"
echo "  Polyscience Chiller IOC Started"
echo "  Device: $(DEV)"
echo "  Server: $(SERVER):$(TCP_PORT)"
echo "============================================"
