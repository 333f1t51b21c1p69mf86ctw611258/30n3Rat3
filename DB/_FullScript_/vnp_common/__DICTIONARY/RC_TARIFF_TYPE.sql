SET DEFINE OFF;
Insert into VNP_COMMON.RC_TARIFF_TYPE
   (RC_TARIFF_TYPE_ID, TYPE_NAME)
 Values
   (1, 'Chia theo số ngày trong tháng');
Insert into VNP_COMMON.RC_TARIFF_TYPE
   (RC_TARIFF_TYPE_ID, TYPE_NAME)
 Values
   (2, 'Chia theo số ngày cố định');
Insert into VNP_COMMON.RC_TARIFF_TYPE
   (RC_TARIFF_TYPE_ID, TYPE_NAME)
 Values
   (3, 'Chia theo tỷ lệ %');
Insert into VNP_COMMON.RC_TARIFF_TYPE
   (RC_TARIFF_TYPE_ID, TYPE_NAME)
 Values
   (4, 'Gán cứng mức tiền');
COMMIT;
