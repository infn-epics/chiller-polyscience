TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = polyscience-ioc
# polyscience-ioc.dbd will be created and installed
DBD += polyscience-ioc.dbd

# polyscience-ioc.dbd will be made up from these files:
polyscience-ioc_DBD += base.dbd

# Include dbd files from all support applications:
polyscience-ioc_DBD += asyn.dbd
polyscience-ioc_DBD += drvAsynIPPort.dbd
polyscience-ioc_DBD += drvAsynSerialPort.dbd
polyscience-ioc_DBD += stream.dbd

# Add all the support libraries needed by this IOC
polyscience-ioc_LIBS += asyn
polyscience-ioc_LIBS += stream

# polyscience-ioc_registerRecordDeviceDriver.cpp derives from polyscience-ioc.dbd
polyscience-ioc_SRCS += polyscience-ioc_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
polyscience-ioc_SRCS_DEFAULT += polyscience-iocMain.cpp
polyscience-ioc_SRCS_vxWorks += -nil-

# Finally link to the EPICS Base libraries
polyscience-ioc_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE
