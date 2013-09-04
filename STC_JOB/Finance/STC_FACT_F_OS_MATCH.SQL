TRUNCATE TABLE STCBI106.STC_FACT_F_OS_MATCH;
COMMIT;
insert into STCBI106.STC_FACT_F_OS_MATCH
(
  GRP_COMP_ID              ,
  COA_GRP_COMP_ID          ,
  BANK_ID                  ,
  TRAN_ID                  ,
  CURRENCY_ID              ,
  BANK_ACNT_ID             ,
  ACTIVITY_ID              ,
  ACNT_PERIOD_ID           ,
  FOM_SYS_ID               ,
  FOM_BASE_SEQ_NO          ,
  FOM_MATCH_SEQ_NO         ,
  FOM_ORIG_SEQ_NO          ,
  FOM_BASE_FC_AMT          ,
  FOM_BASE_LC_AMT          ,
  FOM_MATCH_DT             ,
  FOM_FLAG                 ,
  FOM_FOREX_GEN_YN         ,
  FOM_FOREX_AMT            ,
  FOM_FOREX_AMT_2          ,
  FOM_FOREX_AMT_3          ,
  FOM_FOREX_GL_FLAG        ,
  FOM_FOREX_SEQ_NO         ,
  FOM_UNP_SEQ_NO           ,
  FOM_PDC_SEQ_NO           ,
  FOM_CR_DT                ,
  FOM_CR_UID               ,
  FOM_SERVICE_CRTAKEN_NUM  ,
  FOM_FOREX_SYS_ID         ,
  PROG_CR_DT               ,
  PROG_FLEX_NUM_01         ,
  PROG_FLEX_NUM_02         ,
  PROG_FLEX_NUM_03         ,
  PROG_FLEX_NUM_04         ,
  PROG_FLEX_NUM_05         ,
  PROG_FLEX_NUM_06         
)
select 
  stc_dim_group_companies.grp_comp_id,
  NULL                     , 
  NULL                     ,
  stc_dim_txn.txn_id       ,
  stc_dim_currency.currency_id
, NULL
, stc_dim_f_activity.activity_id
, stc_dim_f_acnt_period.acnt_period_id 
, FOM_SYS_ID
,FOM_BASE_SEQ_NO
,FOM_MATCH_SEQ_NO
,FOM_ORIG_SEQ_NO
,FOM_BASE_FC_AMT
,FOM_BASE_LC_AMT
,FOM_MATCH_DT
,FOM_FLAG
,FOM_FOREX_GEN_YN
,FOM_FOREX_AMT
,FOM_FOREX_AMT_2
,FOM_FOREX_AMT_3
,FOM_FOREX_GL_FLAG
,FOM_FOREX_SEQ_NO
,FOM_UNP_SEQ_NO
,FOM_PDC_SEQ_NO
,FOM_CR_DT
,FOM_CR_UID
,FOM_SERVICE_CRTAKEN_NUM
,FOM_FOREX_SYS_ID
,SYSDATE,
case A.OST_DRCR_FLAG 
when 'D' then nvl(A.OST_LC_ADJ_AMT,0)
when 'C' then 0 
end OST_LC_ADJ_DR_AMT,
case A.OST_DRCR_FLAG 
when 'D' then 0 
when 'C' then nvl(A.OST_LC_ADJ_AMT,0)
end OST_LC_ADJ_CR_AMT,
case A.OST_DRCR_FLAG 
when 'D' then A.OST_LC_AMT  
when 'C' then 0 
end OST_LC_DR_AMT,
case A.OST_DRCR_FLAG 
when 'D' then 0 
when 'C' then A.OST_LC_AMT
end OST_LC_CR_AMT,
(case A.OST_DRCR_FLAG 
when 'D' then A.OST_LC_AMT  
when 'C' then 0 
end) -
(case A.OST_DRCR_FLAG 
when 'D' then 0 
when 'C' then A.OST_LC_AMT
end) OST_LC_BAL_DR_AMT,
(case A.OST_DRCR_FLAG 
when 'D' then nvl(A.OST_LC_ADJ_AMT,0)
when 'C' then 0 
end)-
(case A.OST_DRCR_FLAG 
when 'D' then 0 
when 'C' then nvl(A.OST_LC_ADJ_AMT,0)
end) OST_LC_BAL_CR_AMT
FROM 
orion106.FT_OS_MATCH@STCBI X,
ORION106.FT_OS@STCBI A
left outer join STCBI106.stc_dim_group_companies stc_dim_group_companies on 
(a.ost_comp_code = stc_dim_group_companies.company_code AND
a.ost_main_acnt_code = stc_dim_group_companies.main_account_code AND 
nvl(a.ost_sub_acnt_code,0) = stc_dim_group_companies.sub_account_code) 
left outer join STCBI106.stc_dim_txn stc_dim_txn on 
(A.ost_tran_code = stc_dim_txn.txn_code)
left outer join   STCBI106.stc_dim_currency stc_dim_currency on 
(A.ost_curr_code = stc_dim_currency.curr_code)
LEFT join   STCBI106.stc_dim_f_activity stc_dim_f_activity on 
(A.ost_acty_code_1 = stc_dim_f_activity.acty_code)
left outer join STCBI106.stc_dim_f_acnt_period stc_dim_f_acnt_period on 
(A.ost_comp_code = stc_dim_f_acnt_period.aper_comp_code AND 
A.ost_acnt_year = stc_dim_f_acnt_period.aper_acnt_year AND
A.ost_DOC_cal_year = stc_dim_f_acnt_period.aper_cal_year AND
A.ost_doc_cal_month = stc_dim_f_acnt_period.aper_cal_month)
where X.FOM_BASE_SEQ_NO = A.OST_KEY_NO AND 
x.fom_CR_DT >= TO_DATE('1/JUL/2000', 'DD/MM/YYYY') AND 
to_date(x.fom_CR_DT,'DD-MM-YYYY') < TO_DATE(SYSDATE, 'DD/MM/YYYY'); 
COMMIT;