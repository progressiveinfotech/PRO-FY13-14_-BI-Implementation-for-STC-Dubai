TRUNCATE TABLE MYCOM_FACT_PRICE_LEVEL;
COMMIT;

INSERT INTO MYCOM_FACT_PRICE_LEVEL
(
  
  ITEM_CODE           ,
  PRICE_GROUP         ,
  PRICE_LEV           ,
  RETAIL              ,
  MIN_RETAIL          ,
  LEV_TYPE            ,
  RETAIL2             ,
  RETAIL3             ,
  PREV_PRICE1         ,
  PCHANGE_DATE        ,
  PREV_PRICE2         ,
  PACK_ID             ,
  USER_ID             ,
  PROM_PRICE          ,
  VALID_FROM          ,
  VALID_TO            ,
  TIME_FROM           ,
  TIME_TO             ,
  PROMO_TYPE          ,
  PRICE_TYPE          ,
  MRP                 ,
  MORE_INFO1          ,
  MORE_INFO2          ,
  REC                 ,
  EFFECTIVE_DATE      ,
  NEW_PRICE           ,
  OLD_PRICE           ,
  PROG_CR_DT        ,

 --PROG_LOC_ID      ,
  
 DEPARTMENT_ID

,PROD_MAST_ID
,ITEM_ID
,MYCOM_SUPPLIER_ID
,supplier_id 

)
SELECT 
 
  A.item_code
, A.price_group
, A.price_lev
, A.retail
, A.min_retail
, A.lev_type
, A.retail2
, A.retail3
, A.prev_price1
, A.pchange_date
, A.prev_price2
, A.pack_id
, A.user_id
, A.prom_price
, A.valid_from
, A.valid_to
, A.time_from
, A.time_to
, A.promo_type
, A.price_type
, A.mrp
, A.more_info1
, A.more_info2
, A.rec
, A.effective_date
, A.new_price
, A.old_price
, SYSDATE

--,BRANCH.BR_CODE
,STC_DIM_DEPARTMENT.DEPARTMENT_ID

,D.PROD_MAST_ID
,STC_DIM_ITEM.ITEM_ID
,MYCOM_DIM_SUPPLIER.MYCOM_SUPPLIER_ID
,STC_DIM_SUPPLIER.supplier_id

FROM mycom.PRICE_LEV A 

left outer join   STCBI106.MYCOM_DIM_PROD_MAST D ON
(A.item_code = D.ITEM_CODE)

left outer join   STCBI106.STC_DIM_ITEM STC_DIM_ITEM ON
(LTRIM(RTRIM(D.item_ref)) = STC_DIM_ITEM.ITEM_CODE)

left outer join   STCBI106.STC_DIM_DEPARTMENT STC_DIM_DEPARTMENT ON
(STC_DIM_DEPARTMENT.DEPARTMENT_CODE= LTRIM(RTRIM(d.group_code)) AND 
STC_DIM_DEPARTMENT.CLASS_CODE = LTRIM(RTRIM(D.SUB_group)) AND
STC_DIM_DEPARTMENT.SUB_CLASS_CODE = LTRIM(RTRIM(D.SUB_SUBgroup)))

left outer join   STCBI106.STC_DIM_SUPPLIER STC_DIM_SUPPLIER ON
(STC_DIM_SUPPLIER.SUPP_CODE = LTRIM(RTRIM(D.supp_code)))

left outer join   STCBI106.MYCOM_DIM_SUPPLIER MYCOM_DIM_SUPPLIER ON
(MYCOM_DIM_SUPPLIER.SUPP_CODE = LTRIM(RTRIM(D.supp_code)));

--left outer join   MYCOM.BRANCH BRANCH ON
--(BRANCH.PRICE_GROUP = A.PRICE_GROUP);

--WHERE A.entry_no = B.entry_no AND
--B.item_code = D.item_code and
--A.posted= 1 and 
--A.ENTRY_date < TO_DATE('2013-04-30' ,'YYYY-MM-DD');-- AND ROWNUM<10;
--and rownum()>16000
--COMMIT;
--DELETE FROM MYCOM_FACT_ADJ_HD 
--WHERE ENTRY_DATE >= TO_DATE('03/01/2013', 'MM/DD/YYYY'); 
COMMIT;