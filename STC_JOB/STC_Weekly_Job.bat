E:\DW\Incremental_ETL\STC_ETL_ORION_JOB.bat
start cmd /c E:\DW\Incremental_ETL\STC_ETL_PAYROLL_JOB.bat
start cmd /c E:\DW\Incremental_ETL\Finance\STC_FACT_F_ACNT_BAL.bat
start cmd /c E:\DW\Incremental_ETL\STC_ETL_WMS_JOB.bat
start cmd /c E:\DW\Incremental_ETL\STC_ETL_WMS_IBN_JOB.bat
start cmd /c E:\DW\Incremental_ETL\STC_ETL_WMS_OBN_JOB.bat
start cmd /c E:\DW\Incremental_ETL\STC_ETL_WMS_WAVE_JOB.bat
start cmd /c E:\DW\Incremental_ETL\STC_ETL_MYCOM_JOB.bat
start cmd /c E:\DW\Incremental_ETL\STC_ETL_WMS_WORK_ORDER_JOB.bat
update PROG_ETL_LOG set etl_date = etl_date-1 where etl_name like '%RPRO%';
COMMIT;
start cmd /c E:\DW\Incremental_ETL\STC_ETL_RPRO_JOB.bat
start cmd /c E:\DW\Incremental_ETL\WMS\POSITION_NEW.bat
start cmd /c E:\DW\Incremental_ETL\WMS\POSITION_batch.bat
start cmd /c E:\DW\Incremental_ETL\Inventory\STC_FACT_COST_GROUP_CURR_VAL.bat
start cmd /c E:\DW\Incremental_ETL\Inventory\locn_curr_stk.bat