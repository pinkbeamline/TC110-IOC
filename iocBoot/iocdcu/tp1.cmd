#!../../bin/linux-x86_64/dcu

## You may have to change dcu to something else
## everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/dcu.dbd"
dcu_registerRecordDeviceDriver pdbbase

epicsEnvSet ("STREAM_PROTOCOL_PATH", ".")

drvAsynIPPortConfigure ("TP01", "172.17.10.75:4001")
asynOctetSetInputEos("TP01",0,"\r")

## asynSetTraceIOMask(portName,addr,mask)
#asynSetTraceIOMask("TP01",0, 0xFF)

## Load record instances
#dbLoadRecords("db/xxx.db","user=epics")
#dbLoadRecords("$(ASYN)/db/asynRecord.db","P=PINK:DCU:,R=asyn,PORT=TP1,ADDR=0,OMAX=128,IMAX=128")
dbLoadRecords("db/dcu.db", "BL=PINK,DEV=TP1,PORT=TP01")

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncxxx,"user=epics"
