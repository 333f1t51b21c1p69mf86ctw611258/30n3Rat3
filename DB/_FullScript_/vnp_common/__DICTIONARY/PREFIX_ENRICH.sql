﻿SET DEFINE OFF;
Insert into VNP_COMMON.PREFIX_ENRICH
   (PREFIX, CHANGE, PREFIX_ENRICH_ID)
 Values
   ('+', '00', 1);
Insert into VNP_COMMON.PREFIX_ENRICH
   (PREFIX, PREFIX_ENRICH_ID)
 Values
   ('0084', 2);
Insert into VNP_COMMON.PREFIX_ENRICH
   (PREFIX, CHANGE, PREFIX_ENRICH_ID)
 Values
   ('171700', '17100', 3);
Insert into VNP_COMMON.PREFIX_ENRICH
   (PREFIX, CHANGE, PREFIX_ENRICH_ID)
 Values
   ('84', '0', 4);
COMMIT;
