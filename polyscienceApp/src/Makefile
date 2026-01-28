TOP = ../..

include $(TOP)/configure/CONFIG

#----------------------------------------
# ADD MACRO DEFINITIONS AFTER THIS LINE
#========================================

# Build an IOC application
PROD_IOC = polyscience-ioc

# polyscience-ioc.dbd will be created and installed
DBD += polyscience-ioc.dbd

# polyscience-ioc.dbd will be made up from these files:
polyscience-ioc_DBD += base.dbd
polyscience-ioc_DBD += stream.dbd
polyscience-ioc_DBD += asyn.dbd
polyscience-ioc_DBD += drvAsynIPPort.dbd

# polyscience-ioc_registerRecordDeviceDriver.cpp will be created
# from polyscience-ioc.dbd
polyscience-ioc_SRCS += polyscience-ioc_registerRecordDeviceDriver.cpp
polyscience-ioc_SRCS += polyscienceMain.cpp

# Add support from base/src/vxWorks if needed
#polyscience-ioc_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Link in the libraries from EPICS BASE, ASYN, and STREAMDEVICE
polyscience-ioc_LIBS += stream
polyscience-ioc_LIBS += asyn
polyscience-ioc_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
# ADD RULES AFTER THIS LINE
