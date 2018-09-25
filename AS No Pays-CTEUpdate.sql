WITH DATE_DETAILS AS (
SELECT trade_Date
, BA_ID
, max(messageheaderid) messageheaderid 
FROM messageheader
WHERE ba_id = '5057'
	AND trade_date BETWEEN '01-Jan-2017' AND '31-Jan-2017'
	AND file_type = 'DETERMINANTS'
	AND run_description NOT LIKE 'MONTHLY%'
GROUP BY trade_Date, BA_ID
)
SELECT trade_date
, attributevalue2
, run_group_name
, hour
, interval

, ROUND(NVL(LEAST(SPIN_PRICE*LEAST(GREATEST((1-AGC_Flag)*LEAST(SPIN_RT_Cleared_Qty,SPIN_MAIN_CALC),SPIN_AS_Test),SPIN_Awarded_Qty),SPIN_No_Pay_AMT_Total),0)
        +NVL(LEAST(NSPN_PRICE*LEAST(GREATEST((1-AGC_Flag)*LEAST(NSPN_RT_Cleared_Qty,NSPN_MAIN_CALC),NSPN_AS_Test),NSPN_Awarded_Qty),NSPN_No_Pay_AMT_Total),0)
        +NVL(LEAST(LEAST(REGUP_Awarded_Qty,REGUP_MAIN_CALC_Qty)*REGUP_PRICE,REGUP_No_Pay_AMT_Total),0)
        +NVL(LEAST(LEAST(REGDW_Awarded_Qty,REGDW_MAIN_CALC_Qty)*REGDW_PRICE,REGDW_No_Pay_AMT_Total),0),2) AS Total_CP_NoPay

, ROUND(NVL(SPIN_Awarded_Qty,0),2) AS SPIN_Awarded_Qty
, ROUND(NVL(SPIN_No_Pay_QTY_Total,0),2) AS SPIN_No_Pay_QTY_Total
, ROUND(NVL(SPIN_No_Pay_AMT_Total,0),2) AS SPIN_No_Pay_AMT_Total
, NVL(SPIN_PRICE,0) AS SPIN_PRICE
, ROUND(NVL(LEAST(GREATEST((1-AGC_Flag)*LEAST(SPIN_RT_Cleared_Qty,SPIN_MAIN_CALC),SPIN_AS_Test),SPIN_Awarded_Qty),0),2) AS SPIN_CP_Qty
, ROUND(NVL(LEAST(SPIN_PRICE*LEAST(GREATEST((1-AGC_Flag)*LEAST(SPIN_RT_Cleared_Qty,SPIN_MAIN_CALC),SPIN_AS_Test),SPIN_Awarded_Qty),SPIN_No_Pay_AMT_Total),0),2) AS SPIN_CP_NoPay

, ROUND(NVL(NSPN_Awarded_Qty,0),2) AS NSPN_Awarded_Qty
, ROUND(NVL(NSPN_No_Pay_QTY_Total,0),2) AS NSPN_No_Pay_QTY_Total
, ROUND(NVL(NSPN_No_Pay_AMT_Total,0),2) AS NSPN_No_Pay_AMT_Total
, NVL(NSPN_PRICE,0) AS NSPN_PRICE
, ROUND(NVL(LEAST(GREATEST((1-AGC_Flag)*LEAST(NSPN_RT_Cleared_Qty,NSPN_MAIN_CALC),NSPN_AS_Test),NSPN_Awarded_Qty),0),2) AS NSPN_CP_Qty
, ROUND(NVL(LEAST(NSPN_PRICE*LEAST(GREATEST((1-AGC_Flag)*LEAST(NSPN_RT_Cleared_Qty,NSPN_MAIN_CALC),NSPN_AS_Test),NSPN_Awarded_Qty),NSPN_No_Pay_AMT_Total),0),2) AS NSPN_CP_NoPay

, ROUND(NVL(REGUP_Awarded_Qty,0),2) AS REGUP_Awarded_Qty
, NVL(REGUP_No_Pay_QTY_Total,0) AS REGUP_No_Pay_QTY_Total
, NVL(REGUP_No_Pay_AMT_Total,0) AS REGUP_No_Pay_AMT_Total
, NVL(REGUP_PRICE,0) AS REGUP_PRICE
, ROUND(NVL(REGUP_MAIN_CALC_Qty,0),2) AS REGUP_CP_Qty
, ROUND(NVL(LEAST(LEAST(REGUP_Awarded_Qty,REGUP_MAIN_CALC_Qty)*REGUP_PRICE,REGUP_No_Pay_AMT_Total),0),2) AS REGUP_CP_NoPay

, ROUND(NVL(REGDW_Awarded_Qty,0),2) AS REGDW_Awarded_Qty
, NVL(REGDW_No_Pay_QTY_Total,0) AS REGDW_No_Pay_QTY_Total
, NVL(REGDW_No_Pay_AMT_Total,0) AS REGDW_No_Pay_AMT_Total
, NVL(REGDW_PRICE,0) AS REGDW_PRICE
, ROUND(NVL(REGDW_MAIN_CALC_Qty,0),2) AS REGDW_CP_Qty
, ROUND(NVL(LEAST(LEAST(REGDW_Awarded_Qty,REGDW_MAIN_CALC_Qty)*REGDW_PRICE,REGDW_No_Pay_AMT_Total),0),2) AS REGDW_CP_NoPay


, ROUND(NVL(SPIN_AS_Test,0),2) AS SPIN_AS_Test_P
, ROUND(NVL(SPIN_Unavail,0),2) AS SPIN_Unavail_P
, ROUND(NVL(SPIN_Undeliv,0),2) AS SPIN_Undeliv_P
, ROUND(NVL(SPIN_Unsync,0),2) AS SPIN_Unsync_P
, ROUND(NVL(SPIN_Constraint_DQ,0),2) AS SPIN_Constraint_DQ_NP
, ROUND(NVL(SPIN_Undisp,0),2) AS SPIN_Undisp_NP
, ROUND(NVL(SPIN_Declined,0),2) AS SPIN_Declined_NP
, ROUND(NVL(SPIN_Untag,0),2) AS SPIN_Untag_NP

, ROUND(NVL(NSPN_AS_Test,0),2) AS NSPN_AS_Test_P
, ROUND(NVL(NSPN_Unavail,0),2) AS NSPN_Unavail_P
, ROUND(NVL(NSPN_Undeliv,0),2) AS NSPN_Undeliv_P
, ROUND(NVL(NSPN_Unsync,0),2) AS NSPN_Unsync_P
, ROUND(NVL(NSPN_Constraint_DQ,0),2) AS NSPN_Constraint_DQ_NP
, ROUND(NVL(NSPN_Undisp,0),2) AS NSPN_Undisp_NP
, ROUND(NVL(NSPN_Declined,0),2) AS NSPN_Declined_NP
, ROUND(NVL(NSPN_Untag,0),2) AS NSPN_Untag_NP

, NVL(REGUP_Comm_Error_P,0) AS REGUP_Comm_Error_P
, NVL(REGUP_Off_Ctrl_AGC_P,0) AS REGUP_Off_Ctrl_AGC_P
, NVL(REGUP_Outage_P,0) AS REGUP_Outage_P
, NVL(REGUP_Out_of_Range_P,0) AS REGUP_Out_of_Range_P
, NVL(REGUP_Constraint_DQ_NP,0) AS REGUP_Constraint_DQ_NP
, NVL(REGUP_Constrained_LackRange_NP,0) AS REGUP_Constrained_LackRange_NP

, NVL(REGDW_Comm_Error_P,0) AS REGDW_Comm_Error_P
, NVL(REGDW_Off_Ctrl_AGC_P,0) AS REGDW_Off_Ctrl_AGC_P
, NVL(REGDW_Outage_P,0) AS REGDW_Outage_P
, NVL(REGDW_Out_of_Range_P,0) AS REGDW_Out_of_Range_P
, NVL(REGDW_Constraint_DQ_NP,0) AS REGDW_Constraint_DQ_NP
, NVL(REGDW_Constrained_LackRange_NP,0) AS REGDW_Constrained_LackRange_NP

FROM
    (
    SELECT trade_date
    , attributevalue2
    , run_group_name
    , hour
    , interval
    , SUM(NVL(AGC_Flag,0)) AS AGC_Flag

    , SUM(SPIN_RT_Cleared_Qty)/12 AS SPIN_RT_Cleared_Qty
    , SUM(SPIN_Awarded_Qty)/12 AS SPIN_Awarded_Qty
    , SUM(SPIN_No_Pay_QTY_Total) AS SPIN_No_Pay_QTY_Total
    , SUM(SPIN_No_Pay_AMT_Total) AS SPIN_No_Pay_AMT_Total
    , SUM(NVL(SPIN_AS_Test,0)) AS SPIN_AS_Test
    , SUM(SPIN_Unavail) AS SPIN_Unavail
    , SUM(SPIN_Undeliv) AS SPIN_Undeliv
    , SUM(SPIN_Unsync) AS SPIN_Unsync
    , SUM(SPIN_Constraint_DQ) AS SPIN_Constraint_DQ
    , SUM(SPIN_Undisp) AS SPIN_Undisp
    , SUM(NVL(SPIN_Declined,0)) AS SPIN_Declined
    , SUM(NVL(SPIN_Untag,0))/12 AS SPIN_Untag
    , SUM(GREATEST(0, SPIN_PRICE_COMP)) AS SPIN_PRICE
    , SUM(SPIN_MAIN_CALC) AS SPIN_MAIN_CALC

    , SUM(NSPN_RT_Cleared_Qty)/12 AS NSPN_RT_Cleared_Qty
    , SUM(NSPN_Awarded_Qty)/12 AS NSPN_Awarded_Qty
    , SUM(NSPN_No_Pay_QTY_Total) AS NSPN_No_Pay_QTY_Total
    , SUM(NSPN_No_Pay_AMT_Total) AS NSPN_No_Pay_AMT_Total
    , SUM(NVL(NSPN_AS_Test,0)) AS NSPN_AS_Test
    , SUM(NSPN_Unavail) AS NSPN_Unavail
    , SUM(NSPN_Undeliv) AS NSPN_Undeliv
    , SUM(NSPN_Unsync) AS NSPN_Unsync
    , SUM(NSPN_Constraint_DQ) AS NSPN_Constraint_DQ
    , SUM(NSPN_Undisp) AS NSPN_Undisp
    , SUM(NVL(NSPN_Declined,0)) AS NSPN_Declined
    , SUM(NVL(NSPN_Untag,0))/12 AS NSPN_Untag
    , SUM(GREATEST(0, NSPN_PRICE_COMP)) AS NSPN_PRICE
    , SUM(NSPN_MAIN_CALC) AS NSPN_MAIN_CALC

    , SUM(REGUP_Awarded_Qty)/12 AS REGUP_Awarded_Qty
    , ROUND(SUM(REGUP_No_Pay_QTY_Total),2) AS REGUP_No_Pay_QTY_Total
    , ROUND(SUM(REGUP_No_Pay_AMT_Total),2) AS REGUP_No_Pay_AMT_Total
    , ROUND(SUM(REGUP_Comm_Error)/12,2) AS REGUP_Comm_Error_P
    , ROUND(SUM(REGUP_Off_Ctrl_AGC)/12,2) AS REGUP_Off_Ctrl_AGC_P
    , ROUND(SUM(REGUP_Outage)/12,2) AS REGUP_Outage_P
    , ROUND(SUM(REGUP_Out_of_Range)/12,2) AS REGUP_Out_of_Range_P
    , ROUND(SUM(REGUP_Constraint_DQ)/12,2) AS REGUP_Constraint_DQ_NP
    , ROUND(SUM(REGUP_Constrained_LackRange)/12,2) AS REGUP_Constrained_LackRange_NP
    , SUM(GREATEST(0, REGUP_PRICE_COMP)) AS REGUP_PRICE
    , MAX(REGUP_MAIN_CALC)/12 AS REGUP_MAIN_CALC_Qty

    , SUM(REGDW_Awarded_Qty)/12 AS REGDW_Awarded_Qty
    , ROUND(SUM(REGDW_No_Pay_QTY_Total),2) AS REGDW_No_Pay_QTY_Total
    , ROUND(SUM(REGDW_No_Pay_AMT_Total),2) AS REGDW_No_Pay_AMT_Total
    , ROUND(SUM(REGDW_Comm_Error)/12,2) AS REGDW_Comm_Error_P
    , ROUND(SUM(REGDW_Off_Ctrl_AGC)/12,2) AS REGDW_Off_Ctrl_AGC_P
    , ROUND(SUM(REGDW_Outage)/12,2) AS REGDW_Outage_P
    , ROUND(SUM(REGDW_Out_of_Range)/12,2) AS REGDW_Out_of_Range_P
    , ROUND(SUM(REGDW_Constraint_DQ)/12,2) AS REGDW_Constraint_DQ_NP
    , ROUND(SUM(REGDW_Constrained_LackRange)/12,2) AS REGDW_Constrained_LackRange_NP
    , SUM(GREATEST(0, REGDW_PRICE_COMP)) AS REGDW_PRICE
    , MAX(REGDW_MAIN_CALC)/12 AS REGDW_MAIN_CALC_Qty

    FROM
        (
        SELECT trade_date
        , attributevalue2
        , run_group_name
        , hour
        , interval
        , CASE WHEN name = 'BA_5M_RSRC_AGC@FLAG' THEN VALUE END AS AGC_Flag

        , CASE WHEN name = 'BA_5M_RSRC_TOT_SPIN_DA_RT_AWARD@QUANTITY' THEN VALUE END AS SPIN_Awarded_Qty
        , CASE WHEN name = 'BA_5M_RSRC_NO_PAY_SPIN_AWARD@QUANTITY' THEN VALUE END AS SPIN_No_Pay_QTY_Total
        , CASE WHEN name = 'BA_5M_RSRC_NOPAY_SPIN_STLMT@AMOUNT' THEN VALUE END AS SPIN_No_Pay_AMT_Total
        , CASE WHEN name = 'BA_15M_RSRC_RT_SPIN_CLEARED_QTY' THEN VALUE END AS SPIN_RT_Cleared_Qty
        , CASE WHEN name = 'BA_5M_RSRC_AS_TEST_RESC_SPIN@QUANTITY' THEN VALUE END AS SPIN_AS_Test
        , CASE WHEN name = 'BA_5M_RSRC_UNAVAIL_SPIN_CAP@QUANTITY' THEN VALUE END AS SPIN_Unavail
        , CASE WHEN name = 'BA_5M_RSRC_UNDELV_SPIN_CAP@QUANTITY' THEN VALUE END AS SPIN_Undeliv
        , CASE WHEN name = 'BA_5M_RSRC_UNSYNCHRONIZED_SPIN_RSRV_BILL@QUANTITY' THEN VALUE END AS SPIN_Unsync
        , CASE WHEN name = 'BA_15M_RSRC_RT_SPIN_CONSTRAINT_DQ@QUANTITY' THEN VALUE/12 END AS SPIN_Constraint_DQ
        , CASE WHEN name = 'BA_5M_RSRC_UNDISP_SPIN_CAP@QUANTITY' THEN VALUE END AS SPIN_Undisp      
        , CASE WHEN name = 'BA_5M_RSRC_DECLINED_NSPN_CAP@QUANTITY' THEN VALUE END AS SPIN_Declined
        , CASE WHEN name = 'BA_15M_RSRC_UNTAG_SPIN_CAP_HPD_TG@QUANTITY' THEN VALUE END AS SPIN_Untag          
        , CASE WHEN name = 'BA_15M_RSRC_NOPAY_SPIN_STLMT@PRICE' THEN VALUE END AS SPIN_PRICE_COMP
        , CASE WHEN name IN ('BA_5M_RSRC_UNDELV_SPIN_CAP@QUANTITY', 'BA_5M_RSRC_UNAVAIL_SPIN_CAP@QUANTITY','BA_5M_RSRC_UNSYNCHRONIZED_SPIN_RSRV_BILL@QUANTITY') THEN VALUE END AS SPIN_MAIN_CALC

        , CASE WHEN name = 'BA_5M_RSRC_TOT_NSPN_DA_RT_AWARD@QUANTITY' THEN VALUE END AS NSPN_Awarded_Qty
        , CASE WHEN name = 'BA_5M_RSRC_NO_PAY_NSPN_AWARD@QUANTITY' THEN VALUE END AS NSPN_No_Pay_QTY_Total
        , CASE WHEN name = 'BA_5M_RSRC_NOPAY_NSPN_STLMT@AMOUNT' THEN VALUE END AS NSPN_No_Pay_AMT_Total
        , CASE WHEN name = 'BA_15M_RSRC_RT_NSPN_CLEARED_QTY' THEN VALUE END AS NSPN_RT_Cleared_Qty
        , CASE WHEN name = 'BA_5M_RSRC_AS_TEST_RESC_NSPN@QUANTITY' THEN VALUE END AS NSPN_AS_Test
        , CASE WHEN name = 'BA_5M_RSRC_UNAVAIL_NSPN_CAP@QUANTITY' THEN VALUE END AS NSPN_Unavail
        , CASE WHEN name = 'BA_5M_RSRC_UNDELV_NSPN_CAP@QUANTITY' THEN VALUE END AS NSPN_Undeliv
        , CASE WHEN name = 'BA_5M_RSRC_UNSYNCHRONIZED_NSPN_RSRV_BILL@QUANTITY' THEN VALUE END AS NSPN_Unsync
        , CASE WHEN name = 'BA_5M_RSRC_CONSTRAINT_DQ_NO_PAY_NSPN@QUANTITY' THEN VALUE END AS NSPN_Constraint_DQ
        , CASE WHEN name = 'BA_5M_RSRC_UNDISP_NSPN_CAP@QUANTITY' THEN VALUE END AS NSPN_Undisp
        , CASE WHEN name = 'BA_5M_RSRC_DECLINED_NSPN_CAP@QUANTITY' THEN VALUE END AS NSPN_Declined
        , CASE WHEN name = 'BA_15M_RSRC_UNTAG_NSPN_CAP_HPD_TG@QUANTITY' THEN VALUE END AS NSPN_Untag          
        , CASE WHEN name = 'BA_15M_RSRC_NOPAY_NSPN_STLMT@PRICE' THEN VALUE END AS NSPN_PRICE_COMP
        , CASE WHEN name IN ('BA_5M_RSRC_UNDELV_NSPN_CAP@QUANTITY', 'BA_5M_RSRC_UNAVAIL_NSPN_CAP@QUANTITY', 'BA_5M_RSRC_UNSYNCHRONIZED_NSPN_RSRV_BILL@QUANTITY') THEN VALUE END AS NSPN_MAIN_CALC


        , CASE WHEN name IN ('BA_15M_RSRC_REGUP_TOT_AWARD_CAP@QUANTITY') THEN VALUE END AS REGUP_Awarded_Qty
        , CASE WHEN name IN ('BA_5M_RSRC_NOPAY_REGUP_BID@QUANTITY') THEN VALUE END AS REGUP_No_Pay_QTY_Total
        , CASE WHEN name IN ('BA_5M_RSRC_NOPAY_REGUP@AMOUNT') THEN VALUE END AS REGUP_No_Pay_AMT_Total
        , CASE WHEN name IN ('BA_15M_RSRC_RT_REGUP_CONSTRAINT_DQ@QUANTITY') THEN VALUE END AS REGUP_Constraint_DQ
        , CASE WHEN name IN ('BA_15M_RSRC_REGUP_CONSTRAINED_MW@QUANTITY') THEN VALUE END AS REGUP_Constrained_LackRange
        , CASE WHEN name IN ('BA_15M_RSRC_REGUP_COMM_ERROR_MW@QUANTITY') THEN VALUE END AS REGUP_Comm_Error
        , CASE WHEN name IN ('BA_15M_RSRC_REGUP_OFF_CTRL_MW@QUANTITY') THEN VALUE END AS REGUP_Off_Ctrl_AGC
        , CASE WHEN name IN ('BA_15M_RSRC_REGUP_OUTAGE_MW@QUANTITY') THEN VALUE END AS REGUP_Outage
        , CASE WHEN name IN ('BA_15M_RSRC_REGUP_OUT_OF_RANGE_MW@QUANTITY') THEN VALUE END AS REGUP_Out_of_Range
        , CASE WHEN name IN ('BA_15M_RSRC_NOPAY_REGUP@PRICE') THEN VALUE END AS REGUP_PRICE_COMP
        , CASE WHEN name IN ('BA_15M_RSRC_REGUP_COMM_ERROR_MW@QUANTITY', 'BA_15M_RSRC_REGUP_OFF_CTRL_MW@QUANTITY', 'BA_15M_RSRC_REGUP_OUTAGE_MW@QUANTITY'
                            , 'BA_15M_RSRC_REGUP_OUT_OF_RANGE_MW@QUANTITY') THEN VALUE END AS REGUP_MAIN_CALC

        , CASE WHEN name IN ('BA_15M_RSRC_REGDOWN_TOT_AWARD_CAP@QUANTITY') THEN VALUE END AS REGDW_Awarded_Qty
        , CASE WHEN name IN ('BA_5M_RSRC_NOPAY_REGDOWN_BID@QUANTITY') THEN VALUE END AS REGDW_No_Pay_QTY_Total
        , CASE WHEN name IN ('BA_5M_RSRC_NOPAY_REGDOWN_STLMT@AMOUNT') THEN VALUE END AS REGDW_No_Pay_AMT_Total
        , CASE WHEN name IN ('BA_15M_RSRC_RT_REGDOWN_CONSTRAINT_DQ@QUANTITY') THEN VALUE END AS REGDW_Constraint_DQ
        , CASE WHEN name IN ('BA_15M_RSRC_REGDOWN_CONSTRAINED_MW@QUANTITY') THEN VALUE END AS REGDW_Constrained_LackRange
        , CASE WHEN name IN ('BA_15M_RSRC_REGDOWN_COMM_ERROR_MW@QUANTITY') THEN VALUE END AS REGDW_Comm_Error
        , CASE WHEN name IN ('BA_15M_RSRC_REGDOWN_OFF_CTRL_MW@QUANTITY') THEN VALUE END AS REGDW_Off_Ctrl_AGC
        , CASE WHEN name IN ('BA_15M_RSRC_REGDOWN_OUTAGE_MW@QUANTITY') THEN VALUE END AS REGDW_Outage
        , CASE WHEN name IN ('BA_15M_RSRC_REGDOWN_OUT_OF_RANGE_MW@QUANTITY') THEN VALUE END AS REGDW_Out_of_Range
        , CASE WHEN name IN ('BA_15M_RSRC_NOPAY_REGDOWN_STLMT@PRICE') THEN VALUE END AS REGDW_PRICE_COMP
        , CASE WHEN name IN ('BA_15M_RSRC_REGDOWN_COMM_ERROR_MW@QUANTITY', 'BA_15M_RSRC_REGDOWN_OFF_CTRL_MW@QUANTITY', 'BA_15M_RSRC_REGDOWN_OUTAGE_MW@QUANTITY'
                            , 'BA_15M_RSRC_REGDOWN_OUT_OF_RANGE_MW@QUANTITY') THEN VALUE END AS REGDW_MAIN_CALC


        FROM 
            (
            SELECT bd.trade_date
            , bd.attributevalue2
            , mh.run_group_name
            , ti.hour
            , ti.interval
            , bd.name
            , CASE ti.interval
                WHEN 1 THEN to_number(NVL(bd.int001,0))
                WHEN 2 THEN to_number(NVL(bd.int002,0))
                WHEN 3 THEN to_number(NVL(bd.int003,0))
                WHEN 4 THEN to_number(NVL(bd.int004,0))
                WHEN 5 THEN to_number(NVL(bd.int005,0))
                WHEN 6 THEN to_number(NVL(bd.int006,0))
                WHEN 7 THEN to_number(NVL(bd.int007,0))
                WHEN 8 THEN to_number(NVL(bd.int008,0))
                WHEN 9 THEN to_number(NVL(bd.int009,0))
                WHEN 10 THEN to_number(NVL(bd.int010,0))
                WHEN 11 THEN to_number(NVL(bd.int011,0))
                WHEN 12 THEN to_number(NVL(bd.int012,0))
                WHEN 13 THEN to_number(NVL(bd.int013,0))
                WHEN 14 THEN to_number(NVL(bd.int014,0))
                WHEN 15 THEN to_number(NVL(bd.int015,0))
                WHEN 16 THEN to_number(NVL(bd.int016,0))
                WHEN 17 THEN to_number(NVL(bd.int017,0))
                WHEN 18 THEN to_number(NVL(bd.int018,0))
                WHEN 19 THEN to_number(NVL(bd.int019,0))
                WHEN 20 THEN to_number(NVL(bd.int020,0))
                WHEN 21 THEN to_number(NVL(bd.int021,0))
                WHEN 22 THEN to_number(NVL(bd.int022,0))
                WHEN 23 THEN to_number(NVL(bd.int023,0))
                WHEN 24 THEN to_number(NVL(bd.int024,0))
                WHEN 25 THEN to_number(NVL(bd.int025,0))
                WHEN 26 THEN to_number(NVL(bd.int026,0))
                WHEN 27 THEN to_number(NVL(bd.int027,0))
                WHEN 28 THEN to_number(NVL(bd.int028,0))
                WHEN 29 THEN to_number(NVL(bd.int029,0))
                WHEN 30 THEN to_number(NVL(bd.int030,0))
                WHEN 31 THEN to_number(NVL(bd.int031,0))
                WHEN 32 THEN to_number(NVL(bd.int032,0))
                WHEN 33 THEN to_number(NVL(bd.int033,0))
                WHEN 34 THEN to_number(NVL(bd.int034,0))
                WHEN 35 THEN to_number(NVL(bd.int035,0))
                WHEN 36 THEN to_number(NVL(bd.int036,0))
                WHEN 37 THEN to_number(NVL(bd.int037,0))
                WHEN 38 THEN to_number(NVL(bd.int038,0))
                WHEN 39 THEN to_number(NVL(bd.int039,0))
                WHEN 40 THEN to_number(NVL(bd.int040,0))
                WHEN 41 THEN to_number(NVL(bd.int041,0))
                WHEN 42 THEN to_number(NVL(bd.int042,0))
                WHEN 43 THEN to_number(NVL(bd.int043,0))
                WHEN 44 THEN to_number(NVL(bd.int044,0))
                WHEN 45 THEN to_number(NVL(bd.int045,0))
                WHEN 46 THEN to_number(NVL(bd.int046,0))
                WHEN 47 THEN to_number(NVL(bd.int047,0))
                WHEN 48 THEN to_number(NVL(bd.int048,0))
                WHEN 49 THEN to_number(NVL(bd.int049,0))
                WHEN 50 THEN to_number(NVL(bd.int050,0))
                WHEN 51 THEN to_number(NVL(bd.int051,0))
                WHEN 52 THEN to_number(NVL(bd.int052,0))
                WHEN 53 THEN to_number(NVL(bd.int053,0))
                WHEN 54 THEN to_number(NVL(bd.int054,0))
                WHEN 55 THEN to_number(NVL(bd.int055,0))
                WHEN 56 THEN to_number(NVL(bd.int056,0))
                WHEN 57 THEN to_number(NVL(bd.int057,0))
                WHEN 58 THEN to_number(NVL(bd.int058,0))
                WHEN 59 THEN to_number(NVL(bd.int059,0))
                WHEN 60 THEN to_number(NVL(bd.int060,0))
                WHEN 61 THEN to_number(NVL(bd.int061,0))
                WHEN 62 THEN to_number(NVL(bd.int062,0))
                WHEN 63 THEN to_number(NVL(bd.int063,0))
                WHEN 64 THEN to_number(NVL(bd.int064,0))
                WHEN 65 THEN to_number(NVL(bd.int065,0))
                WHEN 66 THEN to_number(NVL(bd.int066,0))
                WHEN 67 THEN to_number(NVL(bd.int067,0))
                WHEN 68 THEN to_number(NVL(bd.int068,0))
                WHEN 69 THEN to_number(NVL(bd.int069,0))
                WHEN 70 THEN to_number(NVL(bd.int070,0))
                WHEN 71 THEN to_number(NVL(bd.int071,0))
                WHEN 72 THEN to_number(NVL(bd.int072,0))
                WHEN 73 THEN to_number(NVL(bd.int073,0))
                WHEN 74 THEN to_number(NVL(bd.int074,0))
                WHEN 75 THEN to_number(NVL(bd.int075,0))
                WHEN 76 THEN to_number(NVL(bd.int076,0))
                WHEN 77 THEN to_number(NVL(bd.int077,0))
                WHEN 78 THEN to_number(NVL(bd.int078,0))
                WHEN 79 THEN to_number(NVL(bd.int079,0))
                WHEN 80 THEN to_number(NVL(bd.int080,0))
                WHEN 81 THEN to_number(NVL(bd.int081,0))
                WHEN 82 THEN to_number(NVL(bd.int082,0))
                WHEN 83 THEN to_number(NVL(bd.int083,0))
                WHEN 84 THEN to_number(NVL(bd.int084,0))
                WHEN 85 THEN to_number(NVL(bd.int085,0))
                WHEN 86 THEN to_number(NVL(bd.int086,0))
                WHEN 87 THEN to_number(NVL(bd.int087,0))
                WHEN 88 THEN to_number(NVL(bd.int088,0))
                WHEN 89 THEN to_number(NVL(bd.int089,0))
                WHEN 90 THEN to_number(NVL(bd.int090,0))
                WHEN 91 THEN to_number(NVL(bd.int091,0))
                WHEN 92 THEN to_number(NVL(bd.int092,0))
                WHEN 93 THEN to_number(NVL(bd.int093,0))
                WHEN 94 THEN to_number(NVL(bd.int094,0))
                WHEN 95 THEN to_number(NVL(bd.int095,0))
                WHEN 96 THEN to_number(NVL(bd.int096,0))
                WHEN 97 THEN to_number(NVL(bd.int097,0))
                WHEN 98 THEN to_number(NVL(bd.int098,0))
                WHEN 99 THEN to_number(NVL(bd.int099,0))
                WHEN 100 THEN to_number(NVL(bd.int100,0))
                WHEN 101 THEN to_number(NVL(bd.int101,0))
                WHEN 102 THEN to_number(NVL(bd.int102,0))
                WHEN 103 THEN to_number(NVL(bd.int103,0))
                WHEN 104 THEN to_number(NVL(bd.int104,0))
                WHEN 105 THEN to_number(NVL(bd.int105,0))
                WHEN 106 THEN to_number(NVL(bd.int106,0))
                WHEN 107 THEN to_number(NVL(bd.int107,0))
                WHEN 108 THEN to_number(NVL(bd.int108,0))
                WHEN 109 THEN to_number(NVL(bd.int109,0))
                WHEN 110 THEN to_number(NVL(bd.int110,0))
                WHEN 111 THEN to_number(NVL(bd.int111,0))
                WHEN 112 THEN to_number(NVL(bd.int112,0))
                WHEN 113 THEN to_number(NVL(bd.int113,0))
                WHEN 114 THEN to_number(NVL(bd.int114,0))
                WHEN 115 THEN to_number(NVL(bd.int115,0))
                WHEN 116 THEN to_number(NVL(bd.int116,0))
                WHEN 117 THEN to_number(NVL(bd.int117,0))
                WHEN 118 THEN to_number(NVL(bd.int118,0))
                WHEN 119 THEN to_number(NVL(bd.int119,0))
                WHEN 120 THEN to_number(NVL(bd.int120,0))
                WHEN 121 THEN to_number(NVL(bd.int121,0))
                WHEN 122 THEN to_number(NVL(bd.int122,0))
                WHEN 123 THEN to_number(NVL(bd.int123,0))
                WHEN 124 THEN to_number(NVL(bd.int124,0))
                WHEN 125 THEN to_number(NVL(bd.int125,0))
                WHEN 126 THEN to_number(NVL(bd.int126,0))
                WHEN 127 THEN to_number(NVL(bd.int127,0))
                WHEN 128 THEN to_number(NVL(bd.int128,0))
                WHEN 129 THEN to_number(NVL(bd.int129,0))
                WHEN 130 THEN to_number(NVL(bd.int130,0))
                WHEN 131 THEN to_number(NVL(bd.int131,0))
                WHEN 132 THEN to_number(NVL(bd.int132,0))
                WHEN 133 THEN to_number(NVL(bd.int133,0))
                WHEN 134 THEN to_number(NVL(bd.int134,0))
                WHEN 135 THEN to_number(NVL(bd.int135,0))
                WHEN 136 THEN to_number(NVL(bd.int136,0))
                WHEN 137 THEN to_number(NVL(bd.int137,0))
                WHEN 138 THEN to_number(NVL(bd.int138,0))
                WHEN 139 THEN to_number(NVL(bd.int139,0))
                WHEN 140 THEN to_number(NVL(bd.int140,0))
                WHEN 141 THEN to_number(NVL(bd.int141,0))
                WHEN 142 THEN to_number(NVL(bd.int142,0))
                WHEN 143 THEN to_number(NVL(bd.int143,0))
                WHEN 144 THEN to_number(NVL(bd.int144,0))
                WHEN 145 THEN to_number(NVL(bd.int145,0))
                WHEN 146 THEN to_number(NVL(bd.int146,0))
                WHEN 147 THEN to_number(NVL(bd.int147,0))
                WHEN 148 THEN to_number(NVL(bd.int148,0))
                WHEN 149 THEN to_number(NVL(bd.int149,0))
                WHEN 150 THEN to_number(NVL(bd.int150,0))
                WHEN 151 THEN to_number(NVL(bd.int151,0))
                WHEN 152 THEN to_number(NVL(bd.int152,0))
                WHEN 153 THEN to_number(NVL(bd.int153,0))
                WHEN 154 THEN to_number(NVL(bd.int154,0))
                WHEN 155 THEN to_number(NVL(bd.int155,0))
                WHEN 156 THEN to_number(NVL(bd.int156,0))
                WHEN 157 THEN to_number(NVL(bd.int157,0))
                WHEN 158 THEN to_number(NVL(bd.int158,0))
                WHEN 159 THEN to_number(NVL(bd.int159,0))
                WHEN 160 THEN to_number(NVL(bd.int160,0))
                WHEN 161 THEN to_number(NVL(bd.int161,0))
                WHEN 162 THEN to_number(NVL(bd.int162,0))
                WHEN 163 THEN to_number(NVL(bd.int163,0))
                WHEN 164 THEN to_number(NVL(bd.int164,0))
                WHEN 165 THEN to_number(NVL(bd.int165,0))
                WHEN 166 THEN to_number(NVL(bd.int166,0))
                WHEN 167 THEN to_number(NVL(bd.int167,0))
                WHEN 168 THEN to_number(NVL(bd.int168,0))
                WHEN 169 THEN to_number(NVL(bd.int169,0))
                WHEN 170 THEN to_number(NVL(bd.int170,0))
                WHEN 171 THEN to_number(NVL(bd.int171,0))
                WHEN 172 THEN to_number(NVL(bd.int172,0))
                WHEN 173 THEN to_number(NVL(bd.int173,0))
                WHEN 174 THEN to_number(NVL(bd.int174,0))
                WHEN 175 THEN to_number(NVL(bd.int175,0))
                WHEN 176 THEN to_number(NVL(bd.int176,0))
                WHEN 177 THEN to_number(NVL(bd.int177,0))
                WHEN 178 THEN to_number(NVL(bd.int178,0))
                WHEN 179 THEN to_number(NVL(bd.int179,0))
                WHEN 180 THEN to_number(NVL(bd.int180,0))
                WHEN 181 THEN to_number(NVL(bd.int181,0))
                WHEN 182 THEN to_number(NVL(bd.int182,0))
                WHEN 183 THEN to_number(NVL(bd.int183,0))
                WHEN 184 THEN to_number(NVL(bd.int184,0))
                WHEN 185 THEN to_number(NVL(bd.int185,0))
                WHEN 186 THEN to_number(NVL(bd.int186,0))
                WHEN 187 THEN to_number(NVL(bd.int187,0))
                WHEN 188 THEN to_number(NVL(bd.int188,0))
                WHEN 189 THEN to_number(NVL(bd.int189,0))
                WHEN 190 THEN to_number(NVL(bd.int190,0))
                WHEN 191 THEN to_number(NVL(bd.int191,0))
                WHEN 192 THEN to_number(NVL(bd.int192,0))
                WHEN 193 THEN to_number(NVL(bd.int193,0))
                WHEN 194 THEN to_number(NVL(bd.int194,0))
                WHEN 195 THEN to_number(NVL(bd.int195,0))
                WHEN 196 THEN to_number(NVL(bd.int196,0))
                WHEN 197 THEN to_number(NVL(bd.int197,0))
                WHEN 198 THEN to_number(NVL(bd.int198,0))
                WHEN 199 THEN to_number(NVL(bd.int199,0))
                WHEN 200 THEN to_number(NVL(bd.int200,0))
                WHEN 201 THEN to_number(NVL(bd.int201,0))
                WHEN 202 THEN to_number(NVL(bd.int202,0))
                WHEN 203 THEN to_number(NVL(bd.int203,0))
                WHEN 204 THEN to_number(NVL(bd.int204,0))
                WHEN 205 THEN to_number(NVL(bd.int205,0))
                WHEN 206 THEN to_number(NVL(bd.int206,0))
                WHEN 207 THEN to_number(NVL(bd.int207,0))
                WHEN 208 THEN to_number(NVL(bd.int208,0))
                WHEN 209 THEN to_number(NVL(bd.int209,0))
                WHEN 210 THEN to_number(NVL(bd.int210,0))
                WHEN 211 THEN to_number(NVL(bd.int211,0))
                WHEN 212 THEN to_number(NVL(bd.int212,0))
                WHEN 213 THEN to_number(NVL(bd.int213,0))
                WHEN 214 THEN to_number(NVL(bd.int214,0))
                WHEN 215 THEN to_number(NVL(bd.int215,0))
                WHEN 216 THEN to_number(NVL(bd.int216,0))
                WHEN 217 THEN to_number(NVL(bd.int217,0))
                WHEN 218 THEN to_number(NVL(bd.int218,0))
                WHEN 219 THEN to_number(NVL(bd.int219,0))
                WHEN 220 THEN to_number(NVL(bd.int220,0))
                WHEN 221 THEN to_number(NVL(bd.int221,0))
                WHEN 222 THEN to_number(NVL(bd.int222,0))
                WHEN 223 THEN to_number(NVL(bd.int223,0))
                WHEN 224 THEN to_number(NVL(bd.int224,0))
                WHEN 225 THEN to_number(NVL(bd.int225,0))
                WHEN 226 THEN to_number(NVL(bd.int226,0))
                WHEN 227 THEN to_number(NVL(bd.int227,0))
                WHEN 228 THEN to_number(NVL(bd.int228,0))
                WHEN 229 THEN to_number(NVL(bd.int229,0))
                WHEN 230 THEN to_number(NVL(bd.int230,0))
                WHEN 231 THEN to_number(NVL(bd.int231,0))
                WHEN 232 THEN to_number(NVL(bd.int232,0))
                WHEN 233 THEN to_number(NVL(bd.int233,0))
                WHEN 234 THEN to_number(NVL(bd.int234,0))
                WHEN 235 THEN to_number(NVL(bd.int235,0))
                WHEN 236 THEN to_number(NVL(bd.int236,0))
                WHEN 237 THEN to_number(NVL(bd.int237,0))
                WHEN 238 THEN to_number(NVL(bd.int238,0))
                WHEN 239 THEN to_number(NVL(bd.int239,0))
                WHEN 240 THEN to_number(NVL(bd.int240,0))
                WHEN 241 THEN to_number(NVL(bd.int241,0))
                WHEN 242 THEN to_number(NVL(bd.int242,0))
                WHEN 243 THEN to_number(NVL(bd.int243,0))
                WHEN 244 THEN to_number(NVL(bd.int244,0))
                WHEN 245 THEN to_number(NVL(bd.int245,0))
                WHEN 246 THEN to_number(NVL(bd.int246,0))
                WHEN 247 THEN to_number(NVL(bd.int247,0))
                WHEN 248 THEN to_number(NVL(bd.int248,0))
                WHEN 249 THEN to_number(NVL(bd.int249,0))
                WHEN 250 THEN to_number(NVL(bd.int250,0))
                WHEN 251 THEN to_number(NVL(bd.int251,0))
                WHEN 252 THEN to_number(NVL(bd.int252,0))
                WHEN 253 THEN to_number(NVL(bd.int253,0))
                WHEN 254 THEN to_number(NVL(bd.int254,0))
                WHEN 255 THEN to_number(NVL(bd.int255,0))
                WHEN 256 THEN to_number(NVL(bd.int256,0))
                WHEN 257 THEN to_number(NVL(bd.int257,0))
                WHEN 258 THEN to_number(NVL(bd.int258,0))
                WHEN 259 THEN to_number(NVL(bd.int259,0))
                WHEN 260 THEN to_number(NVL(bd.int260,0))
                WHEN 261 THEN to_number(NVL(bd.int261,0))
                WHEN 262 THEN to_number(NVL(bd.int262,0))
                WHEN 263 THEN to_number(NVL(bd.int263,0))
                WHEN 264 THEN to_number(NVL(bd.int264,0))
                WHEN 265 THEN to_number(NVL(bd.int265,0))
                WHEN 266 THEN to_number(NVL(bd.int266,0))
                WHEN 267 THEN to_number(NVL(bd.int267,0))
                WHEN 268 THEN to_number(NVL(bd.int268,0))
                WHEN 269 THEN to_number(NVL(bd.int269,0))
                WHEN 270 THEN to_number(NVL(bd.int270,0))
                WHEN 271 THEN to_number(NVL(bd.int271,0))
                WHEN 272 THEN to_number(NVL(bd.int272,0))
                WHEN 273 THEN to_number(NVL(bd.int273,0))
                WHEN 274 THEN to_number(NVL(bd.int274,0))
                WHEN 275 THEN to_number(NVL(bd.int275,0))
                WHEN 276 THEN to_number(NVL(bd.int276,0))
                WHEN 277 THEN to_number(NVL(bd.int277,0))
                WHEN 278 THEN to_number(NVL(bd.int278,0))
                WHEN 279 THEN to_number(NVL(bd.int279,0))
                WHEN 280 THEN to_number(NVL(bd.int280,0))
                WHEN 281 THEN to_number(NVL(bd.int281,0))
                WHEN 282 THEN to_number(NVL(bd.int282,0))
                WHEN 283 THEN to_number(NVL(bd.int283,0))
                WHEN 284 THEN to_number(NVL(bd.int284,0))
                WHEN 285 THEN to_number(NVL(bd.int285,0))
                WHEN 286 THEN to_number(NVL(bd.int286,0))
                WHEN 287 THEN to_number(NVL(bd.int287,0))
                WHEN 288 THEN to_number(NVL(bd.int288,0))
                WHEN 289 THEN to_number(NVL(bd.int289,0))
                WHEN 290 THEN to_number(NVL(bd.int290,0))
                WHEN 291 THEN to_number(NVL(bd.int291,0))
                WHEN 292 THEN to_number(NVL(bd.int292,0))
                WHEN 293 THEN to_number(NVL(bd.int293,0))
                WHEN 294 THEN to_number(NVL(bd.int294,0))
                WHEN 295 THEN to_number(NVL(bd.int295,0))
                WHEN 296 THEN to_number(NVL(bd.int296,0))
                WHEN 297 THEN to_number(NVL(bd.int297,0))
                WHEN 298 THEN to_number(NVL(bd.int298,0))
                WHEN 299 THEN to_number(NVL(bd.int299,0))
                WHEN 300 THEN to_number(NVL(bd.int300,0))
            ELSE 0 END AS VALUE

            FROM billdeterminant bd
            JOIN messageheader mh ON mh.messageheaderid = bd.messageheaderid 
            JOIN hyp_time_intervals ti ON ti.total_intervals = 300
            WHERE name IN ('BA_5M_RSRC_TOT_SPIN_DA_RT_AWARD@QUANTITY', 'BA_5M_RSRC_TOT_NSPN_DA_RT_AWARD@QUANTITY',
                            'BA_5M_RSRC_NOPAY_SPIN_STLMT@AMOUNT', 'BA_5M_RSRC_NOPAY_NSPN_STLMT@AMOUNT',
                            'BA_5M_RSRC_NO_PAY_SPIN_AWARD@QUANTITY', 'BA_5M_RSRC_NO_PAY_NSPN_AWARD@QUANTITY',
                            'BA_5M_RSRC_AS_TEST_RESC_SPIN@QUANTITY', 'BA_5M_RSRC_AS_TEST_RESC_NSPN@QUANTITY', 
                            'BA_5M_RSRC_DECLINED_SPIN_CAP@QUANTITY', 'BA_5M_RSRC_DECLINED_NSPN_CAP@QUANTITY', 
                            'BA_5M_RSRC_UNAVAIL_SPIN_CAP@QUANTITY', 'BA_5M_RSRC_UNAVAIL_NSPN_CAP@QUANTITY', 
                            'BA_5M_RSRC_UNDELV_SPIN_CAP@QUANTITY', 'BA_5M_RSRC_UNDELV_NSPN_CAP@QUANTITY', 
                            'BA_5M_RSRC_UNDISP_SPIN_CAP@QUANTITY', 'BA_5M_RSRC_UNDISP_NSPN_CAP@QUANTITY', 
                            'BA_5M_RSRC_UNSYNCHRONIZED_SPIN_RSRV_BILL@QUANTITY', 'BA_5M_RSRC_UNSYNCHRONIZED_NSPN_RSRV_BILL@QUANTITY', 
                            'BA_5M_RSRC_CONSTRAINT_DQ_NO_PAY_NSPN@QUANTITY','BA_5M_RSRC_AGC@FLAG','BA_5M_RSRC_NOPAY_REGUP@AMOUNT',
                            'BA_5M_RSRC_NOPAY_REGDOWN_STLMT@AMOUNT', 'BA_5M_RSRC_NOPAY_REGUP_BID@QUANTITY', 'BA_5M_RSRC_NOPAY_REGDOWN_BID@QUANTITY')
                --AND bd.attributevalue2 = 'RUSCTY_2_UNITS'
                --AND bd.trade_date BETWEEN 
                --AND mh.run_group_name
                AND mh.messageheaderid in 
                (
                select MESSAGEHEADERID from date_details
                )                   

            UNION ALL

            SELECT bd.trade_date
            , bd.attributevalue2
            , mh.run_group_name
            , ti.hour
            , ti.interval
            , bd.name
            , CASE ti.interval 
                WHEN 1 THEN to_number(NVL(bd.int001,0))
                WHEN 2 THEN to_number(NVL(bd.int001,0))
                WHEN 3 THEN to_number(NVL(bd.int001,0))
                WHEN 4 THEN to_number(NVL(bd.int002,0))
                WHEN 5 THEN to_number(NVL(bd.int002,0))
                WHEN 6 THEN to_number(NVL(bd.int002,0))
                WHEN 7 THEN to_number(NVL(bd.int003,0))
                WHEN 8 THEN to_number(NVL(bd.int003,0))
                WHEN 9 THEN to_number(NVL(bd.int003,0))
                WHEN 10 THEN to_number(NVL(bd.int004,0))
                WHEN 11 THEN to_number(NVL(bd.int004,0))
                WHEN 12 THEN to_number(NVL(bd.int004,0))
                WHEN 13 THEN to_number(NVL(bd.int005,0))
                WHEN 14 THEN to_number(NVL(bd.int005,0))
                WHEN 15 THEN to_number(NVL(bd.int005,0))
                WHEN 16 THEN to_number(NVL(bd.int006,0))
                WHEN 17 THEN to_number(NVL(bd.int006,0))
                WHEN 18 THEN to_number(NVL(bd.int006,0))
                WHEN 19 THEN to_number(NVL(bd.int007,0))
                WHEN 20 THEN to_number(NVL(bd.int007,0))
                WHEN 21 THEN to_number(NVL(bd.int007,0))
                WHEN 22 THEN to_number(NVL(bd.int008,0))
                WHEN 23 THEN to_number(NVL(bd.int008,0))
                WHEN 24 THEN to_number(NVL(bd.int008,0))
                WHEN 25 THEN to_number(NVL(bd.int009,0))
                WHEN 26 THEN to_number(NVL(bd.int009,0))
                WHEN 27 THEN to_number(NVL(bd.int009,0))
                WHEN 28 THEN to_number(NVL(bd.int010,0))
                WHEN 29 THEN to_number(NVL(bd.int010,0))
                WHEN 30 THEN to_number(NVL(bd.int010,0))
                WHEN 31 THEN to_number(NVL(bd.int011,0))
                WHEN 32 THEN to_number(NVL(bd.int011,0))
                WHEN 33 THEN to_number(NVL(bd.int011,0))
                WHEN 34 THEN to_number(NVL(bd.int012,0))
                WHEN 35 THEN to_number(NVL(bd.int012,0))
                WHEN 36 THEN to_number(NVL(bd.int012,0))
                WHEN 37 THEN to_number(NVL(bd.int013,0))
                WHEN 38 THEN to_number(NVL(bd.int013,0))
                WHEN 39 THEN to_number(NVL(bd.int013,0))
                WHEN 40 THEN to_number(NVL(bd.int014,0))
                WHEN 41 THEN to_number(NVL(bd.int014,0))
                WHEN 42 THEN to_number(NVL(bd.int014,0))
                WHEN 43 THEN to_number(NVL(bd.int015,0))
                WHEN 44 THEN to_number(NVL(bd.int015,0))
                WHEN 45 THEN to_number(NVL(bd.int015,0))
                WHEN 46 THEN to_number(NVL(bd.int016,0))
                WHEN 47 THEN to_number(NVL(bd.int016,0))
                WHEN 48 THEN to_number(NVL(bd.int016,0))
                WHEN 49 THEN to_number(NVL(bd.int017,0))
                WHEN 50 THEN to_number(NVL(bd.int017,0))
                WHEN 51 THEN to_number(NVL(bd.int017,0))
                WHEN 52 THEN to_number(NVL(bd.int018,0))
                WHEN 53 THEN to_number(NVL(bd.int018,0))
                WHEN 54 THEN to_number(NVL(bd.int018,0))
                WHEN 55 THEN to_number(NVL(bd.int019,0))
                WHEN 56 THEN to_number(NVL(bd.int019,0))
                WHEN 57 THEN to_number(NVL(bd.int019,0))
                WHEN 58 THEN to_number(NVL(bd.int020,0))
                WHEN 59 THEN to_number(NVL(bd.int020,0))
                WHEN 60 THEN to_number(NVL(bd.int020,0))
                WHEN 61 THEN to_number(NVL(bd.int021,0))
                WHEN 62 THEN to_number(NVL(bd.int021,0))
                WHEN 63 THEN to_number(NVL(bd.int021,0))
                WHEN 64 THEN to_number(NVL(bd.int022,0))
                WHEN 65 THEN to_number(NVL(bd.int022,0))
                WHEN 66 THEN to_number(NVL(bd.int022,0))
                WHEN 67 THEN to_number(NVL(bd.int023,0))
                WHEN 68 THEN to_number(NVL(bd.int023,0))
                WHEN 69 THEN to_number(NVL(bd.int023,0))
                WHEN 70 THEN to_number(NVL(bd.int024,0))
                WHEN 71 THEN to_number(NVL(bd.int024,0))
                WHEN 72 THEN to_number(NVL(bd.int024,0))
                WHEN 73 THEN to_number(NVL(bd.int025,0))
                WHEN 74 THEN to_number(NVL(bd.int025,0))
                WHEN 75 THEN to_number(NVL(bd.int025,0))
                WHEN 76 THEN to_number(NVL(bd.int026,0))
                WHEN 77 THEN to_number(NVL(bd.int026,0))
                WHEN 78 THEN to_number(NVL(bd.int026,0))
                WHEN 79 THEN to_number(NVL(bd.int027,0))
                WHEN 80 THEN to_number(NVL(bd.int027,0))
                WHEN 81 THEN to_number(NVL(bd.int027,0))
                WHEN 82 THEN to_number(NVL(bd.int028,0))
                WHEN 83 THEN to_number(NVL(bd.int028,0))
                WHEN 84 THEN to_number(NVL(bd.int028,0))
                WHEN 85 THEN to_number(NVL(bd.int029,0))
                WHEN 86 THEN to_number(NVL(bd.int029,0))
                WHEN 87 THEN to_number(NVL(bd.int029,0))
                WHEN 88 THEN to_number(NVL(bd.int030,0))
                WHEN 89 THEN to_number(NVL(bd.int030,0))
                WHEN 90 THEN to_number(NVL(bd.int030,0))
                WHEN 91 THEN to_number(NVL(bd.int031,0))
                WHEN 92 THEN to_number(NVL(bd.int031,0))
                WHEN 93 THEN to_number(NVL(bd.int031,0))
                WHEN 94 THEN to_number(NVL(bd.int032,0))
                WHEN 95 THEN to_number(NVL(bd.int032,0))
                WHEN 96 THEN to_number(NVL(bd.int032,0))
                WHEN 97 THEN to_number(NVL(bd.int033,0))
                WHEN 98 THEN to_number(NVL(bd.int033,0))
                WHEN 99 THEN to_number(NVL(bd.int033,0))
                WHEN 100 THEN to_number(NVL(bd.int034,0))
                WHEN 101 THEN to_number(NVL(bd.int034,0))
                WHEN 102 THEN to_number(NVL(bd.int034,0))
                WHEN 103 THEN to_number(NVL(bd.int035,0))
                WHEN 104 THEN to_number(NVL(bd.int035,0))
                WHEN 105 THEN to_number(NVL(bd.int035,0))
                WHEN 106 THEN to_number(NVL(bd.int036,0))
                WHEN 107 THEN to_number(NVL(bd.int036,0))
                WHEN 108 THEN to_number(NVL(bd.int036,0))
                WHEN 109 THEN to_number(NVL(bd.int037,0))
                WHEN 110 THEN to_number(NVL(bd.int037,0))
                WHEN 111 THEN to_number(NVL(bd.int037,0))
                WHEN 112 THEN to_number(NVL(bd.int038,0))
                WHEN 113 THEN to_number(NVL(bd.int038,0))
                WHEN 114 THEN to_number(NVL(bd.int038,0))
                WHEN 115 THEN to_number(NVL(bd.int039,0))
                WHEN 116 THEN to_number(NVL(bd.int039,0))
                WHEN 117 THEN to_number(NVL(bd.int039,0))
                WHEN 118 THEN to_number(NVL(bd.int040,0))
                WHEN 119 THEN to_number(NVL(bd.int040,0))
                WHEN 120 THEN to_number(NVL(bd.int040,0))
                WHEN 121 THEN to_number(NVL(bd.int041,0))
                WHEN 122 THEN to_number(NVL(bd.int041,0))
                WHEN 123 THEN to_number(NVL(bd.int041,0))
                WHEN 124 THEN to_number(NVL(bd.int042,0))
                WHEN 125 THEN to_number(NVL(bd.int042,0))
                WHEN 126 THEN to_number(NVL(bd.int042,0))
                WHEN 127 THEN to_number(NVL(bd.int043,0))
                WHEN 128 THEN to_number(NVL(bd.int043,0))
                WHEN 129 THEN to_number(NVL(bd.int043,0))
                WHEN 130 THEN to_number(NVL(bd.int044,0))
                WHEN 131 THEN to_number(NVL(bd.int044,0))
                WHEN 132 THEN to_number(NVL(bd.int044,0))
                WHEN 133 THEN to_number(NVL(bd.int045,0))
                WHEN 134 THEN to_number(NVL(bd.int045,0))
                WHEN 135 THEN to_number(NVL(bd.int045,0))
                WHEN 136 THEN to_number(NVL(bd.int046,0))
                WHEN 137 THEN to_number(NVL(bd.int046,0))
                WHEN 138 THEN to_number(NVL(bd.int046,0))
                WHEN 139 THEN to_number(NVL(bd.int047,0))
                WHEN 140 THEN to_number(NVL(bd.int047,0))
                WHEN 141 THEN to_number(NVL(bd.int047,0))
                WHEN 142 THEN to_number(NVL(bd.int048,0))
                WHEN 143 THEN to_number(NVL(bd.int048,0))
                WHEN 144 THEN to_number(NVL(bd.int048,0))
                WHEN 145 THEN to_number(NVL(bd.int049,0))
                WHEN 146 THEN to_number(NVL(bd.int049,0))
                WHEN 147 THEN to_number(NVL(bd.int049,0))
                WHEN 148 THEN to_number(NVL(bd.int050,0))
                WHEN 149 THEN to_number(NVL(bd.int050,0))
                WHEN 150 THEN to_number(NVL(bd.int050,0))
                WHEN 151 THEN to_number(NVL(bd.int051,0))
                WHEN 152 THEN to_number(NVL(bd.int051,0))
                WHEN 153 THEN to_number(NVL(bd.int051,0))
                WHEN 154 THEN to_number(NVL(bd.int052,0))
                WHEN 155 THEN to_number(NVL(bd.int052,0))
                WHEN 156 THEN to_number(NVL(bd.int052,0))
                WHEN 157 THEN to_number(NVL(bd.int053,0))
                WHEN 158 THEN to_number(NVL(bd.int053,0))
                WHEN 159 THEN to_number(NVL(bd.int053,0))
                WHEN 160 THEN to_number(NVL(bd.int054,0))
                WHEN 161 THEN to_number(NVL(bd.int054,0))
                WHEN 162 THEN to_number(NVL(bd.int054,0))
                WHEN 163 THEN to_number(NVL(bd.int055,0))
                WHEN 164 THEN to_number(NVL(bd.int055,0))
                WHEN 165 THEN to_number(NVL(bd.int055,0))
                WHEN 166 THEN to_number(NVL(bd.int056,0))
                WHEN 167 THEN to_number(NVL(bd.int056,0))
                WHEN 168 THEN to_number(NVL(bd.int056,0))
                WHEN 169 THEN to_number(NVL(bd.int057,0))
                WHEN 170 THEN to_number(NVL(bd.int057,0))
                WHEN 171 THEN to_number(NVL(bd.int057,0))
                WHEN 172 THEN to_number(NVL(bd.int058,0))
                WHEN 173 THEN to_number(NVL(bd.int058,0))
                WHEN 174 THEN to_number(NVL(bd.int058,0))
                WHEN 175 THEN to_number(NVL(bd.int059,0))
                WHEN 176 THEN to_number(NVL(bd.int059,0))
                WHEN 177 THEN to_number(NVL(bd.int059,0))
                WHEN 178 THEN to_number(NVL(bd.int060,0))
                WHEN 179 THEN to_number(NVL(bd.int060,0))
                WHEN 180 THEN to_number(NVL(bd.int060,0))
                WHEN 181 THEN to_number(NVL(bd.int061,0))
                WHEN 182 THEN to_number(NVL(bd.int061,0))
                WHEN 183 THEN to_number(NVL(bd.int061,0))
                WHEN 184 THEN to_number(NVL(bd.int062,0))
                WHEN 185 THEN to_number(NVL(bd.int062,0))
                WHEN 186 THEN to_number(NVL(bd.int062,0))
                WHEN 187 THEN to_number(NVL(bd.int063,0))
                WHEN 188 THEN to_number(NVL(bd.int063,0))
                WHEN 189 THEN to_number(NVL(bd.int063,0))
                WHEN 190 THEN to_number(NVL(bd.int064,0))
                WHEN 191 THEN to_number(NVL(bd.int064,0))
                WHEN 192 THEN to_number(NVL(bd.int064,0))
                WHEN 193 THEN to_number(NVL(bd.int065,0))
                WHEN 194 THEN to_number(NVL(bd.int065,0))
                WHEN 195 THEN to_number(NVL(bd.int065,0))
                WHEN 196 THEN to_number(NVL(bd.int066,0))
                WHEN 197 THEN to_number(NVL(bd.int066,0))
                WHEN 198 THEN to_number(NVL(bd.int066,0))
                WHEN 199 THEN to_number(NVL(bd.int067,0))
                WHEN 200 THEN to_number(NVL(bd.int067,0))
                WHEN 201 THEN to_number(NVL(bd.int067,0))
                WHEN 202 THEN to_number(NVL(bd.int068,0))
                WHEN 203 THEN to_number(NVL(bd.int068,0))
                WHEN 204 THEN to_number(NVL(bd.int068,0))
                WHEN 205 THEN to_number(NVL(bd.int069,0))
                WHEN 206 THEN to_number(NVL(bd.int069,0))
                WHEN 207 THEN to_number(NVL(bd.int069,0))
                WHEN 208 THEN to_number(NVL(bd.int070,0))
                WHEN 209 THEN to_number(NVL(bd.int070,0))
                WHEN 210 THEN to_number(NVL(bd.int070,0))
                WHEN 211 THEN to_number(NVL(bd.int071,0))
                WHEN 212 THEN to_number(NVL(bd.int071,0))
                WHEN 213 THEN to_number(NVL(bd.int071,0))
                WHEN 214 THEN to_number(NVL(bd.int072,0))
                WHEN 215 THEN to_number(NVL(bd.int072,0))
                WHEN 216 THEN to_number(NVL(bd.int072,0))
                WHEN 217 THEN to_number(NVL(bd.int073,0))
                WHEN 218 THEN to_number(NVL(bd.int073,0))
                WHEN 219 THEN to_number(NVL(bd.int073,0))
                WHEN 220 THEN to_number(NVL(bd.int074,0))
                WHEN 221 THEN to_number(NVL(bd.int074,0))
                WHEN 222 THEN to_number(NVL(bd.int074,0))
                WHEN 223 THEN to_number(NVL(bd.int075,0))
                WHEN 224 THEN to_number(NVL(bd.int075,0))
                WHEN 225 THEN to_number(NVL(bd.int075,0))
                WHEN 226 THEN to_number(NVL(bd.int076,0))
                WHEN 227 THEN to_number(NVL(bd.int076,0))
                WHEN 228 THEN to_number(NVL(bd.int076,0))
                WHEN 229 THEN to_number(NVL(bd.int077,0))
                WHEN 230 THEN to_number(NVL(bd.int077,0))
                WHEN 231 THEN to_number(NVL(bd.int077,0))
                WHEN 232 THEN to_number(NVL(bd.int078,0))
                WHEN 233 THEN to_number(NVL(bd.int078,0))
                WHEN 234 THEN to_number(NVL(bd.int078,0))
                WHEN 235 THEN to_number(NVL(bd.int079,0))
                WHEN 236 THEN to_number(NVL(bd.int079,0))
                WHEN 237 THEN to_number(NVL(bd.int079,0))
                WHEN 238 THEN to_number(NVL(bd.int080,0))
                WHEN 239 THEN to_number(NVL(bd.int080,0))
                WHEN 240 THEN to_number(NVL(bd.int080,0))
                WHEN 241 THEN to_number(NVL(bd.int081,0))
                WHEN 242 THEN to_number(NVL(bd.int081,0))
                WHEN 243 THEN to_number(NVL(bd.int081,0))
                WHEN 244 THEN to_number(NVL(bd.int082,0))
                WHEN 245 THEN to_number(NVL(bd.int082,0))
                WHEN 246 THEN to_number(NVL(bd.int082,0))
                WHEN 247 THEN to_number(NVL(bd.int083,0))
                WHEN 248 THEN to_number(NVL(bd.int083,0))
                WHEN 249 THEN to_number(NVL(bd.int083,0))
                WHEN 250 THEN to_number(NVL(bd.int084,0))
                WHEN 251 THEN to_number(NVL(bd.int084,0))
                WHEN 252 THEN to_number(NVL(bd.int084,0))
                WHEN 253 THEN to_number(NVL(bd.int085,0))
                WHEN 254 THEN to_number(NVL(bd.int085,0))
                WHEN 255 THEN to_number(NVL(bd.int085,0))
                WHEN 256 THEN to_number(NVL(bd.int086,0))
                WHEN 257 THEN to_number(NVL(bd.int086,0))
                WHEN 258 THEN to_number(NVL(bd.int086,0))
                WHEN 259 THEN to_number(NVL(bd.int087,0))
                WHEN 260 THEN to_number(NVL(bd.int087,0))
                WHEN 261 THEN to_number(NVL(bd.int087,0))
                WHEN 262 THEN to_number(NVL(bd.int088,0))
                WHEN 263 THEN to_number(NVL(bd.int088,0))
                WHEN 264 THEN to_number(NVL(bd.int088,0))
                WHEN 265 THEN to_number(NVL(bd.int089,0))
                WHEN 266 THEN to_number(NVL(bd.int089,0))
                WHEN 267 THEN to_number(NVL(bd.int089,0))
                WHEN 268 THEN to_number(NVL(bd.int090,0))
                WHEN 269 THEN to_number(NVL(bd.int090,0))
                WHEN 270 THEN to_number(NVL(bd.int090,0))
                WHEN 271 THEN to_number(NVL(bd.int091,0))
                WHEN 272 THEN to_number(NVL(bd.int091,0))
                WHEN 273 THEN to_number(NVL(bd.int091,0))
                WHEN 274 THEN to_number(NVL(bd.int092,0))
                WHEN 275 THEN to_number(NVL(bd.int092,0))
                WHEN 276 THEN to_number(NVL(bd.int092,0))
                WHEN 277 THEN to_number(NVL(bd.int093,0))
                WHEN 278 THEN to_number(NVL(bd.int093,0))
                WHEN 279 THEN to_number(NVL(bd.int093,0))
                WHEN 280 THEN to_number(NVL(bd.int094,0))
                WHEN 281 THEN to_number(NVL(bd.int094,0))
                WHEN 282 THEN to_number(NVL(bd.int094,0))
                WHEN 283 THEN to_number(NVL(bd.int095,0))
                WHEN 284 THEN to_number(NVL(bd.int095,0))
                WHEN 285 THEN to_number(NVL(bd.int095,0))
                WHEN 286 THEN to_number(NVL(bd.int096,0))
                WHEN 287 THEN to_number(NVL(bd.int096,0))
                WHEN 288 THEN to_number(NVL(bd.int096,0))
                WHEN 289 THEN to_number(NVL(bd.int097,0))
                WHEN 290 THEN to_number(NVL(bd.int097,0))
                WHEN 291 THEN to_number(NVL(bd.int097,0))
                WHEN 292 THEN to_number(NVL(bd.int098,0))
                WHEN 293 THEN to_number(NVL(bd.int098,0))
                WHEN 294 THEN to_number(NVL(bd.int098,0))
                WHEN 295 THEN to_number(NVL(bd.int099,0))
                WHEN 296 THEN to_number(NVL(bd.int099,0))
                WHEN 297 THEN to_number(NVL(bd.int099,0))
                WHEN 298 THEN to_number(NVL(bd.int100,0))
                WHEN 299 THEN to_number(NVL(bd.int100,0))
                WHEN 300 THEN to_number(NVL(bd.int100,0))
            ELSE 0 END AS VALUE

            FROM billdeterminant bd
            JOIN messageheader mh ON mh.messageheaderid = bd.messageheaderid 
            JOIN hyp_time_intervals ti ON ti.total_intervals = 300
            WHERE name IN ('BA_15M_RSRC_RT_SPIN_CLEARED_QTY', 'BA_15M_RSRC_RT_NSPN_CLEARED_QTY', 'BA_15M_RSRC_NOPAY_SPIN_STLMT@PRICE'
                    , 'BA_15M_RSRC_NOPAY_NSPN_STLMT@PRICE', 'BA_15M_RSRC_RT_SPIN_CONSTRAINT_DQ@QUANTITY', 'BA_15M_RSRC_UNTAG_SPIN_CAP_HPD_TG@QUANTITY'
                    , 'BA_15M_RSRC_UNTAG_NSPN_CAP_HPD_TG@QUANTITY','BA_15M_RSRC_NOPAY_REGUP@PRICE', 'BA_15M_RSRC_NOPAY_REGDOWN_STLMT@PRICE', 'BA_15M_RSRC_REGUP_TOT_AWARD_CAP@QUANTITY'
                    , 'BA_15M_RSRC_REGDOWN_TOT_AWARD_CAP@QUANTITY', 'BA_15M_RSRC_RT_REGUP_CONSTRAINT_DQ@QUANTITY'
                    , 'BA_15M_RSRC_RT_REGDOWN_CONSTRAINT_DQ@QUANTITY', 'BA_15M_RSRC_REGUP_COMM_ERROR_MW@QUANTITY', 'BA_15M_RSRC_REGDOWN_COMM_ERROR_MW@QUANTITY'
                    , 'BA_15M_RSRC_REGUP_CONSTRAINED_MW@QUANTITY', 'BA_15M_RSRC_REGDOWN_CONSTRAINED_MW@QUANTITY', 'BA_15M_RSRC_REGUP_OFF_CTRL_MW@QUANTITY'
                    , 'BA_15M_RSRC_REGDOWN_OFF_CTRL_MW@QUANTITY', 'BA_15M_RSRC_REGUP_OUTAGE_MW@QUANTITY', 'BA_15M_RSRC_REGDOWN_OUTAGE_MW@QUANTITY'
                    , 'BA_15M_RSRC_REGUP_OUT_OF_RANGE_MW@QUANTITY', 'BA_15M_RSRC_REGDOWN_OUT_OF_RANGE_MW@QUANTITY')       
                --AND bd.attributevalue2 = 'RUSCTY_2_UNITS'
                --AND bd.trade_date BETWEEN 
                --AND mh.run_group_name
                AND mh.messageheaderid in (
                    select MESSAGEHEADERID from date_details
                    )
                )
            )GROUP BY trade_date, attributevalue2, run_group_name, hour, interval 
        )
WHERE ROUND(NVL(LEAST(SPIN_PRICE*LEAST(GREATEST((1-AGC_Flag)*LEAST(SPIN_RT_Cleared_Qty,SPIN_MAIN_CALC),SPIN_AS_Test),SPIN_Awarded_Qty),SPIN_No_Pay_AMT_Total),0)
        +NVL(LEAST(NSPN_PRICE*LEAST(GREATEST((1-AGC_Flag)*LEAST(NSPN_RT_Cleared_Qty,NSPN_MAIN_CALC),NSPN_AS_Test),NSPN_Awarded_Qty),NSPN_No_Pay_AMT_Total),0)
        +NVL(LEAST(LEAST(REGUP_Awarded_Qty,REGUP_MAIN_CALC_Qty)*REGUP_PRICE,REGUP_No_Pay_AMT_Total),0)
        +NVL(LEAST(LEAST(REGDW_Awarded_Qty,REGDW_MAIN_CALC_Qty)*REGDW_PRICE,REGDW_No_Pay_AMT_Total),0),2) <> 0
and attributevalue2 = 'RUSCTY_2_UNITS'
ORDER BY attributevalue2, trade_date, interval
