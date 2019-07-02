#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <dbDefs.h>
#include <registryFunction.h>
#include <subRecord.h>
#include <aSubRecord.h>
#include <epicsExport.h>

struct datapool {
  char cmd_buf[6];
  char param_buf[4];
  char data_buf[7];
  int pdata[800];
} dp;

static long streaminputinit(aSubRecord *precord)
{
   dp.cmd_buf[5]='\0';
   dp.param_buf[3]='\0';
   dp.data_buf[6]='\0';
   //void *memset(void *str, int c, size_t n)
   memset(dp.pdata, 0, sizeof(int)*800);
   return 0;
}

static long streaminput(aSubRecord *precord)
{
   char *buf=precord->a;    // Inputs
   memcpy(dp.cmd_buf, buf, sizeof(char)*5);
   int param, data;

   // input message has data if 5 first characters = 00110
   if(strcmp(dp.cmd_buf, "00110")==0){
     memcpy(dp.param_buf, &buf[5], sizeof(char)*3);
     memcpy(dp.data_buf, &buf[10], sizeof(char)*6);

     //strtonum(const char *nptr, long long minval, long long maxval, const char **errstr);
     param = atoi(dp.param_buf);
     data = atoi(dp.data_buf);

     if(param>=0 && param<800){
       dp.pdata[param]=data;
     }
   }
   return 0;
}

static long readaddr(subRecord *precord){
  int addr = (int)precord->a;
  if(addr>=0 && addr<800){
    precord->val=(double)dp.pdata[addr];
  }
  return 0;
}
/* Register these symbols for use by IOC code: */
epicsRegisterFunction(streaminput);
epicsRegisterFunction(streaminputinit);
epicsRegisterFunction(readaddr);
