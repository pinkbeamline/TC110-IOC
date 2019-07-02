TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = dcu
# dcu.dbd will be created and installed
DBD += dcu.dbd

# dcu.dbd will be made up from these files:
dcu_DBD += base.dbd

# Include dbd files from all support applications:
#dcu_DBD += stream.dbd
dcu_DBD += asyn.dbd
dcu_DBD += drvAsynIPPort.dbd
dcu_DBD += calc.dbd
dcu_DBD += stream-base.dbd
dcu_DBD += dcu_extra.dbd

# Add all the support libraries needed by this IOC
#dcu_LIBS += stream
dcu_LIBS += asyn
dcu_LIBS += calc
dcu_LIBS += stream

# dcu_registerRecordDeviceDriver.cpp derives from dcu.dbd
dcu_SRCS += dcu_registerRecordDeviceDriver.cpp
dcu_SRCS += dcu_extra.c

# Build the main IOC entry point on workstation OSs.
dcu_SRCS_DEFAULT += dcuMain.cpp
dcu_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#dcu_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
dcu_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE
