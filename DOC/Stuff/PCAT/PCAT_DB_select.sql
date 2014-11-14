///////////////////
select * from offer_values where display_value like '%CAT-Po%'

-- Lưu thông tin tất cả các version của Offer
select * from offer_ref where offer_id=51004285

SELECT * FROM OFFER_USAGE_PLAN_MAP WHERE OFFER_ID=51004285 AND RESELLER_VERSION_ID=3 --> lay ra cac usage plans
select * from usage_plan_item_map where usage_plan_id=9 --> lay ra cac usage Items trong usage plan
select * from usage_item_ref where usage_item_id=30012 --> lay ra dc FAUT va tariff Plan

--- Cấu hình giá
select * from tariff_plan_ref where tariff_plan_id=30043
select * from tariff_plan_mapping where tariff_plan_id=30043 and reseller_version_id=3 --> lay ra tariff set
select * from tariff_set_member where tariff_set_id=29 and reseller_version_id=3 --> lay ra cac tariff
select * from tariff_values where tariff_id=17 and reseller_version_id=3
select * from tariff_ref where tariff_id=17 and reseller_version_id=3
--
-- => Cấu hình giá: PRICE MODEL
-- TARIFF -> CALENDAR_ID: Giờ rảnh, giờ bận

--- 
select * from offer_balance_map where offer_id in (select offer_id from offer_ref where offer_type=3)
SELECT * FROM OFFER_BALANCE_MAP WHERE OFFER_ID=51000002  and reseller_version_id=3
 
-- /////////////////////offer vs Balance
SELECT * FROM OFFER_BALANCE_MAP WHERE OFFER_ID=51004285 AND RESELLER_VERSION_ID=3 --> CAC BALANCE LIEN QUAN
-- OFFER vs Subscriber compability template---
select * from upsell_template_map --> khai bao caselect * fc PO,SO va cac priority cua Primary Offer 

--Offer va cac Promotion lien quan

 --> promotion_plan
 select * from offer_Rt_promo_plan_map where offer_id=51004294 --> lay ra cac promotion plan
 select * from Rt_Promotion_Plan_Item_Map where rt_promotion_plan_id=24 --lay ra cac bonus item va discount item
 select * from rt_bonus_item_values where bonus_item_id=220
 select * from rt_bonus_item_ref where bonus_item_id=220
 select * from bonus_threshold_values where bonus_threshold_id=215
select * from bonus_threshold_ref where bonus_item_id=220
 select * from bonus_award where bonus_threshold_id=215
 
 select * from rt_promotion_plan_item_map where  rt_promotion_plan_id=18 and reseller_version_id=3
 select * from  rt_promotion_plan_values  where  rt_promotion_plan_id=18
 select * from Rt_Discount_Item_Values where discount_item_id=113
 select * from rt_discount_item_ref  where discount_item_id=113 and reseller_version_id=3
 select * from rt_discount_ref where rt_discount_id=127
 select * from discount_award_ref where rt_discount_id=127
 
 

