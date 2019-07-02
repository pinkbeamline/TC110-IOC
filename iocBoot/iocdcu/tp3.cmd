#!../../bin/linux-x86_64/dcu

## You may have to change dcu to something else
## everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/dcu.dbd"
dcu_registerRecordDeviceDriver pdbbase

epicsEnvSet ("STREAM_PROTOCOL_PATH", ".")

drvAsynIPPortConfigure ("TP03", "172.17.10.75:4003")
asynOctetSetInputEos("TP03",0,"\r")

## asynSetTraceIOMask(portName,addr,mask)
#asynSetTraceIOMask("TP03",0, 0xFF)

## Load record instances
#dbLoadRecords("db/xxx.db","user=epics")
#dbLoadRecords("$(ASYN)/db/asynRecord.db","P=PINK:DCU:,R=asyn,PORT=TP3,ADDR=0,OMAX=128,IMAX=128")
dbLoadRecords("db/dcu.db", "BL=PINK,DEV=TP3,PORT=TP03")

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncxxx,"user=epics"
