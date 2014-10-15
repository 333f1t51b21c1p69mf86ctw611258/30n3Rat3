SET DEFINE OFF;
Insert into VNP_COMMON.RATING_TYPE
   (RATING_TYPE_ID, TYPE_NAME, UNBILL)
 Values
   (1, 'Thuê bao thường', '0');
Insert into VNP_COMMON.RATING_TYPE
   (RATING_TYPE_ID, TYPE_NAME, UNBILL)
 Values
   (2, 'Thuê bao VNP', '1');
COMMIT;
