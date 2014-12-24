/* Formatted on 29/04/2014 13:55:29 (QP5 v5.227.12220.39754) */
CREATE OR REPLACE TRIGGER RC_TARIFF_TRG
   BEFORE INSERT
   ON VNP_COMMON.RC_TARIFF
   REFERENCING NEW AS New OLD AS Old
   FOR EACH ROW
BEGIN
   -- For Toad:  Highlight column TARIFF_ID
   :new.TARIFF_ID := SUBSCRIBER_SEQ.NEXTVAL;
END RC_TARIFF_TRG;
/