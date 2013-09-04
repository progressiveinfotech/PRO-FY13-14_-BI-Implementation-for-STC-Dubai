TRUNCATE TABLE STCBI106.STC_FACT_F_ACNT_BAL;
COMMIT;
INSERT INTO STCBI106.STC_FACT_F_ACNT_BAL
(
  GRP_COMP_ID             ,
  COA_GRP_COMP_ID         ,
  BANK_ID                 ,
  CURRENCY_ID             ,
  ACTIVITY_ID             ,
  ACNT_PERIOD_ID          ,
  BANK_ACNT_ID            ,
  ABAL_COMP_CODE          ,
  ABAL_ACNT_YEAR          ,
  ABAL_CAL_YEAR           ,
  ABAL_CAL_MONTH          ,
  ABAL_CURR_CODE          ,
  ABAL_MAIN_ACNT_CODE     ,
  ABAL_SUB_ACNT_CODE      ,
  ABAL_DIVN_CODE          ,
  ABAL_DEPT_CODE          ,
  ABAL_ANLY_CODE_1        ,
  ABAL_ANLY_CODE_2        ,
  ABAL_HEAD_NO_1          ,
  ABAL_HEAD_NO_2          ,
  ABAL_ACTY_VALUE_CODE_1  ,
  ABAL_ACTY_VALUE_CODE_2  ,
  ABAL_LC_MTD_DR          ,
  ABAL_LC_MTD_CR          ,
  ABAL_LC_MTD_DR_2        ,
  ABAL_LC_MTD_CR_2        ,
  ABAL_LC_MTD_DR_3        ,
  ABAL_LC_MTD_CR_3        ,
  ABAL_FC_MTD_DR          ,
  ABAL_FC_MTD_CR          ,
  ABAL_LC_UNP_DR          ,
  ABAL_LC_UNP_CR          ,
  ABAL_LC_UNP_DR_2        ,
  ABAL_LC_UNP_CR_2        ,
  ABAL_LC_UNP_DR_3        ,
  ABAL_LC_UNP_CR_3        ,
  ABAL_FC_UNP_DR          ,
  ABAL_FC_UNP_CR          ,
  ABAL_CR_UID             ,
  ABAL_CR_DT              ,
  ABAL_UPD_UID            ,
  ABAL_UPD_DT             ,
  ABAL_OP_BAL_YN          ,
  PROG_CR_DT              ,
  PROG_CR_AMNT            ,
  PROG_DR_AMNT            ,
  PROG_FLEX_DT_01
)
SELECT
  stc_dim_group_companies.grp_comp_id
, NULL
, NULL
, stc_dim_currency.currency_id
, stc_dim_f_activity.activity_id
, stc_dim_f_acnt_period.acnt_period_id
, NULL
, A.ABAL_COMP_CODE
, A.ABAL_ACNT_YEAR
, A.ABAL_CAL_YEAR
, A.ABAL_CAL_MONTH
, A.ABAL_CURR_CODE
, A.ABAL_MAIN_ACNT_CODE
, A.ABAL_SUB_ACNT_CODE
, A.ABAL_DIVN_CODE
, A.ABAL_DEPT_CODE
, A.ABAL_ANLY_CODE_1
, A.ABAL_ANLY_CODE_2
, A.ABAL_HEAD_NO_1
, A.ABAL_HEAD_NO_2
, A.ABAL_ACTY_VALUE_CODE_1
, A.ABAL_ACTY_VALUE_CODE_2
, A.ABAL_LC_MTD_DR
, A.ABAL_LC_MTD_CR
, A.ABAL_LC_MTD_DR_2
, A.ABAL_LC_MTD_CR_2
, A.ABAL_LC_MTD_DR_3
, A.ABAL_LC_MTD_CR_3
, A.ABAL_FC_MTD_DR
, A.ABAL_FC_MTD_CR
, A.ABAL_LC_UNP_DR
, A.ABAL_LC_UNP_CR
, A.ABAL_LC_UNP_DR_2
, A.ABAL_LC_UNP_CR_2
, A.ABAL_LC_UNP_DR_3
, A.ABAL_LC_UNP_CR_3
, A.ABAL_FC_UNP_DR
, A.ABAL_FC_UNP_CR
, A.ABAL_CR_UID
, A.ABAL_CR_DT
, A.ABAL_UPD_UID
, A.ABAL_UPD_DT
, A.ABAL_OP_BAL_YN
,sysdate
,NULL
,NULL
,to_date(1||'-'||(Case a.ABAL_CAL_MONTH
WHEN 0 THEN  7 
ELSE 
a.ABAL_CAL_MONTH
end )||'-'||a.ABAL_cal_YEAR,'DD-MM-YYYY') prog_flex_dt_1
FROM ORION106.FS_CUR_ACNT_BAL@stcbi A
left outer join STCBI106.stc_dim_group_companies stc_dim_group_companies on 
(A.ABAL_comp_code = stc_dim_group_companies.company_code AND
A.ABAL_main_acnt_code = stc_dim_group_companies.main_account_code AND 
NVL(A.ABAL_SUB_ACNT_CODE,0) = stc_dim_group_companies.sub_account_code) 
left outer join   STCBI106.stc_dim_currency stc_dim_currency on 
(A.ABAL_curr_code = stc_dim_currency.curr_code)
LEFT join   STCBI106.stc_dim_f_activity stc_dim_f_activity on 
(A.ABAL_ACTY_VALUE_CODE_1 = stc_dim_f_activity.acty_code)
left outer join STCBI106.stc_dim_f_acnt_period stc_dim_f_acnt_period on
(
stc_dim_f_acnt_period.aper_cal_MONTH = CASE 
WHEN A.ABAL_CAL_MONTH = 0 THEN  7 
ELSE 
A.ABAL_CAL_MONTH end 
and
A.ABAL_CAL_year = stc_dim_f_acnt_period.aper_cal_YEAR and
A.ABAL_comp_code = stc_dim_f_acnt_period.aper_comp_code AND
A.ABAL_acnt_year = stc_dim_f_acnt_period.aper_acnt_year )
where   
to_DATE(A.ABAL_CR_DT,'DD-MM-YYYY')>=TO_DATE('1-JAN-01','DD-MM-YYYY')  and
to_DATE(A.ABAL_CR_DT,'DD-MM-YYYY')<TO_DATE(SYSDATE,'DD-MM-YYYY') 
union all 
SELECT  
  stc_dim_group_companies.grp_comp_id
, NULL
, NULL
, stc_dim_currency.currency_id
, stc_dim_f_activity.activity_id
, stc_dim_f_acnt_period.acnt_period_id
, NULL
, B.ABAL_COMP_CODE
, B.ABAL_ACNT_YEAR
, B.ABAL_CAL_YEAR
, B.ABAL_CAL_MONTH
, B.ABAL_CURR_CODE
, B.ABAL_MAIN_ACNT_CODE
, B.ABAL_SUB_ACNT_CODE
, B.ABAL_DIVN_CODE
, B.ABAL_DEPT_CODE
, B.ABAL_ANLY_CODE_1
, B.ABAL_ANLY_CODE_2
, B.ABAL_HEAD_NO_1
, B.ABAL_HEAD_NO_2
, B.ABAL_ACTY_VALUE_CODE_1
, B.ABAL_ACTY_VALUE_CODE_2
, B.ABAL_LC_MTD_DR
, B.ABAL_LC_MTD_CR
, B.ABAL_LC_MTD_DR_2
, B.ABAL_LC_MTD_CR_2
, B.ABAL_LC_MTD_DR_3
, B.ABAL_LC_MTD_CR_3
, B.ABAL_FC_MTD_DR
, B.ABAL_FC_MTD_CR
, B.ABAL_LC_UNP_DR
, B.ABAL_LC_UNP_CR
, B.ABAL_LC_UNP_DR_2
, B.ABAL_LC_UNP_CR_2
, B.ABAL_LC_UNP_DR_3
, B.ABAL_LC_UNP_CR_3
, B.ABAL_FC_UNP_DR
, B.ABAL_FC_UNP_CR
, B.ABAL_CR_UID
, B.ABAL_CR_DT
, B.ABAL_UPD_UID
, B.ABAL_UPD_DT
, B.ABAL_OP_BAL_YN
,sysdate
,NULL
,NULL
,to_date(1||'-'||(Case B.ABAL_CAL_MONTH
WHEN 0 THEN  7 
ELSE 
B.ABAL_CAL_MONTH
end )||'-'||B.ABAL_cal_YEAR,'DD-MM-YYYY') prog_flex_dt_1
FROM ORION106.FS_PRV_ACNT_BAL@stcbi B
left outer join STCBI106.stc_dim_group_companies stc_dim_group_companies on 
(B.ABAL_comp_code = stc_dim_group_companies.company_code AND
B.ABAL_main_acnt_code = stc_dim_group_companies.main_account_code AND 
NVL(B.ABAL_SUB_ACNT_CODE,0) = stc_dim_group_companies.sub_account_code) 
left outer join   STCBI106.stc_dim_currency stc_dim_currency on 
(B.ABAL_curr_code = stc_dim_currency.curr_code)
LEFT join   STCBI106.stc_dim_f_activity stc_dim_f_activity on 
(B.ABAL_ACTY_VALUE_CODE_1 = stc_dim_f_activity.acty_code)
left outer join STCBI106.stc_dim_f_acnt_period stc_dim_f_acnt_period on
(
stc_dim_f_acnt_period.aper_cal_MONTH = CASE 
WHEN B.ABAL_CAL_MONTH = 0 THEN  7 
ELSE 
B.ABAL_CAL_MONTH end 
and
B.ABAL_CAL_year = stc_dim_f_acnt_period.aper_cal_YEAR and
B.ABAL_comp_code = stc_dim_f_acnt_period.aper_comp_code AND
B.ABAL_acnt_year = stc_dim_f_acnt_period.aper_acnt_year )
where   
to_DATE(B.ABAL_CR_DT,'DD-MM-YYYY')>=TO_DATE('1-JAN-01','DD-MM-YYYY')  and
to_DATE(B.ABAL_CR_DT,'DD-MM-YYYY')< TO_DATE(SYSDATE,'DD-MM-YYYY');
COMMIT;
update  stc_fact_f_acnt_bal set prog_flex_dt_01='01-JAN-08',prog_flex_dt_02 = '01-JAN-08'  
WHERE ABAL_ACNT_YEAR=8 AND ABAL_CAL_MONTH=0 AND ABAL_CAL_YEAR=2008 AND ABAL_COMP_CODE='298';
COMMIT; 
delete from STC_FACT_F_ACNT_BAL WHERE ABAL_COMP_CODE IN ('261','277','278','280','286','287','205','210','213','255','269','283');
commit;
update stc_fact_f_acnt_bal a set a.prog_flex_num_01 = (select b.comp_id from stc_dim_companies b where a.abal_comp_code = b.company_code);
commit;
exit;