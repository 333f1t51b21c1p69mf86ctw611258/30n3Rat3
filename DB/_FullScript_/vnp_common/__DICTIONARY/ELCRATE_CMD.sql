SET DEFINE OFF;
Insert into VNP_COMMON.ELCRATE_CMD
   (CMD_CODE, COMMAND)
 Values
   (10, 'Framework:Shutdown=true');
Insert into VNP_COMMON.ELCRATE_CMD
   (CMD_CODE, COMMAND)
 Values
   (20, 'CacheFactory:Reload=true');
COMMIT;
