## example code for strategy using labels to replace "Current Period/Comparison Period"

view: relative_date_parameters {
  extension: required

  parameter: period_lens {
    view_label: " Period Comparison"
    # group_label: "Period Comparison"
    label: "1) Period Lens"
    type: unquoted
    default_value: "Week"
    allowed_value: {
      label: "Week"
      value: "week"
    }
    allowed_value: {
      label: "Month"
      value: "month"
    }
    allowed_value: {
      label: "Quarter"
      value: "quarter"
    }
    allowed_value: {
      label: "Year"
      value: "year"
    }
  }

  parameter: period_compare {
    view_label: " Period Comparison"
    # group_label: "Period Comparison"
    label: "2) Compare Periods"
    type: unquoted
    default_value: "Last Period"
    allowed_value: {
      label: "Last Period"
      value: "last_period"
    }
    allowed_value: {
      label: "Last Year"
      value: "last_year"
    }
  }

}

view: relative_dates {
  # https://aeo.cloud.looker.com/explore/aeo_poc/relative_time_dates_based_on_yesterday?qid=TZaglgqWQSjO377oY04YQm&toggle=fil
  extends: [relative_date_parameters]
  derived_table: {
    sql: WITH reference_dates as (

                    SELECT
                      fisc.aeo_date,
                      fisc.fiscaldayofyear_nbr,
                      fisc.dayofweek_no,
                      fisc.fiscalweek_desc,
                      fisc.fiscalperiod_desc,
                      fisc.fiscalquarter_desc,
                      fisc.fiscalyear_desc,
                      fisc.fiscalyearweek_id,
                      fisc.fiscalyearperiod_id,
                      fisc.fiscalyearquarter_id,
                      fisc.fiscalyear_id,
                      fisc.fiscalyearstart_date,
                      fisc.fiscalyearend_date,

      ty_last_week.fiscalweek_desc AS ty_last_week_fiscal_desc,
      ty_last_week.fiscalweekstart_date AS ty_last_week_start_date,
      ty_last_week.fiscalweekend_date AS ty_last_week_end_date,
      ty_previous_week.fiscalweek_desc AS ty_previous_week_fiscal_desc,
      ty_previous_week.fiscalweekstart_date AS ty_previous_week_start_date,
      ty_previous_week.fiscalweekend_date AS ty_previous_week_end_date,
      ly_last_week.fiscalweek_desc AS ly_last_week_fiscal_desc,
      ly_last_week.fiscalweekstart_date AS ly_last_week_start_date,
      ly_last_week.fiscalweekend_date AS ly_last_week_end_date,

      ty_last_month.fiscalperiod_desc AS ty_last_month_fiscal_desc,
      ty_last_month.fiscalperiodstart_date AS ty_last_month_start_date,
      ty_last_month.fiscalperiodend_date AS ty_last_month_end_date,

      ty_previous_month.fiscalperiod_desc AS ty_previous_month_fiscal_desc,
      ty_previous_month.fiscalperiodstart_date AS ty_previous_month_start_date,
      ty_previous_month.fiscalperiodend_date AS ty_previous_month_end_date,

      ly_last_month.fiscalperiod_desc AS ly_last_month_fiscal_desc,
      ly_last_month.fiscalperiodstart_date AS ly_last_month_start_date,
      ly_last_month.fiscalperiodend_date AS ly_last_month_end_date,

      ty_last_quarter.fiscalquarter_desc AS ty_last_quarter_fiscal_desc,
      ty_last_quarter.fiscalquarterstart_date AS ty_last_quarter_start_date,
      ty_last_quarter.fiscalquarterend_date AS ty_last_quarter_end_date,

      ty_previous_quarter.fiscalquarter_desc AS ty_previous_quarter_fiscal_desc,
      ty_previous_quarter.fiscalquarterstart_date AS ty_previous_quarter_start_date,
      ty_previous_quarter.fiscalquarterend_date AS ty_previous_quarter_end_date,


      ly_last_quarter.fiscalquarter_desc AS ly_last_quarter_fiscal_desc,
      ly_last_quarter.fiscalquarterstart_date AS ly_last_quarter_start_date,
      ly_last_quarter.fiscalquarterend_date AS ly_last_quarter_end_date,

      last_year.fiscalyear_desc AS last_year_fiscal_year_desc,
      last_year.fiscalyearstart_date AS last_year_fiscal_year_start_date,
      last_year.fiscalyearend_date AS last_year_fiscal_year_end_date,
      FROM
      `aeo-real-data-prod.common_reference.FISC_DT_ADJ_FOR_CUR_YEAR_53WK_V` AS fisc
      LEFT JOIN `aeo-real-data-prod.common_reference.FISC_DT_ADJ_FOR_CUR_YEAR_53WK_V` AS ty_last_week
      ON CASE
      WHEN fisc.fiscalyearweek_id > 1
      THEN ty_last_week.dayofweek_no = fisc.dayofweek_no
      AND ty_last_week.fiscalyear_id = (fisc.fiscalyear_id)
      AND ty_last_week.fiscalyearweek_id = (fisc.fiscalyearweek_id - 1)
      WHEN fisc.fiscalyearweek_id = 1
      THEN ty_last_week.dayofweek_no = fisc.dayofweek_no
      AND ty_last_week.fiscalyear_id = (fisc.fiscalyear_id - 1)
      AND ty_last_week.fiscalyearweek_id = 52
      END
      LEFT JOIN `aeo-real-data-prod.common_reference.FISC_DT_ADJ_FOR_CUR_YEAR_53WK_V` AS ty_previous_week
      ON CASE
      WHEN fisc.fiscalyearweek_id > 2
      THEN ty_previous_week.dayofweek_no = fisc.dayofweek_no
      AND ty_previous_week.fiscalyear_id = (fisc.fiscalyear_id)
      AND ty_previous_week.fiscalyearweek_id = (fisc.fiscalyearweek_id - 2)
      WHEN fisc.fiscalyearweek_id = 2
      THEN ty_previous_week.dayofweek_no = fisc.dayofweek_no
      AND ty_previous_week.fiscalyear_id = (fisc.fiscalyear_id - 1)
      AND ty_previous_week.fiscalyearweek_id = 52
      WHEN fisc.fiscalyearweek_id = 1
      THEN ty_previous_week.dayofweek_no = fisc.dayofweek_no
      AND ty_previous_week.fiscalyear_id = (fisc.fiscalyear_id - 1)
      AND ty_previous_week.fiscalyearweek_id = 51
      END
      LEFT JOIN `aeo-real-data-prod.common_reference.FISC_DT_ADJ_FOR_CUR_YEAR_53WK_V` AS ly_last_week
      ON ly_last_week.dayofweek_no = fisc.dayofweek_no
      AND ly_last_week.fiscalyear_id = fisc.fiscalyear_id - 1
      AND ly_last_week.fiscalyearweek_id = fisc.fiscalyearweek_id - 1
      LEFT JOIN `aeo-real-data-prod.common_reference.FISC_DT_ADJ_FOR_CUR_YEAR_53WK_V` AS ty_last_month
      ON CASE
      WHEN fisc.fiscalyearperiod_id > 1
      THEN ty_last_month.dayofweek_no = 1
      AND ty_last_month.weekinperiod_nbr = 1
      AND ty_last_month.fiscalyear_id = fisc.fiscalyear_id
      AND ty_last_month.fiscalyearperiod_id = (fisc.fiscalyearperiod_id - 1)
      WHEN fisc.fiscalyearweek_id = 1
      THEN ty_last_month.dayofweek_no = 1
      AND ty_last_month.weekinperiod_nbr = 1
      AND ty_last_month.fiscalyear_id = (fisc.fiscalyear_id - 1)
      AND ty_last_month.fiscalyearperiod_id = 12
      END

      LEFT JOIN `aeo-real-data-prod.common_reference.FISC_DT_ADJ_FOR_CUR_YEAR_53WK_V` AS ty_previous_month
      ON CASE
      WHEN fisc.fiscalyearperiod_id > 2
      THEN ty_previous_month.dayofweek_no = 1
      AND ty_previous_month.weekinperiod_nbr = 1
      AND ty_previous_month.fiscalyear_id = fisc.fiscalyear_id
      AND ty_previous_month.fiscalyearperiod_id = (fisc.fiscalyearperiod_id - 2)
      WHEN fisc.fiscalyearweek_id = 2
      THEN ty_previous_month.dayofweek_no = 1
      AND ty_previous_month.weekinperiod_nbr = 1
      AND ty_previous_month.fiscalyear_id = (fisc.fiscalyear_id - 1)
      AND ty_previous_month.fiscalyearperiod_id = 12
      WHEN fisc.fiscalyearweek_id = 1
      THEN ty_previous_month.dayofweek_no = 1
      AND ty_previous_month.weekinperiod_nbr = 1
      AND ty_previous_month.fiscalyear_id = (fisc.fiscalyear_id - 1)
      AND ty_previous_month.fiscalyearperiod_id = 11
      END


      LEFT JOIN `aeo-real-data-prod.common_reference.FISC_DT_ADJ_FOR_CUR_YEAR_53WK_V` AS ly_last_month
      ON ly_last_month.dayofweek_no = 1
      AND ly_last_month.fiscalyear_id = fisc.fiscalyear_id - 1
      AND ly_last_month.weekinperiod_nbr = fisc.weekinperiod_nbr
      AND ly_last_month.fiscalyearperiod_id = fisc.fiscalyearperiod_id -1

      LEFT JOIN `aeo-real-data-prod.common_reference.FISC_DT_ADJ_FOR_CUR_YEAR_53WK_V` AS ty_last_quarter
      ON CASE
      WHEN fisc.fiscalyearquarter_id > 1
      THEN ty_last_quarter.dayofweek_no = 1
      AND ty_last_quarter.weekinperiod_nbr = 1
      AND ty_last_quarter.fiscalyear_id = fisc.fiscalyear_id
      AND ty_last_quarter.fiscalyearquarter_id = (fisc.fiscalyearquarter_id - 1)
      WHEN fisc.fiscalyearweek_id = 1
      THEN ty_last_quarter.dayofweek_no = 1
      AND ty_last_quarter.weekinperiod_nbr = 1
      AND ty_last_quarter.fiscalyear_id = (fisc.fiscalyear_id - 1)
      AND ty_last_quarter.fiscalyearperiod_id = 4
      END

      LEFT JOIN `aeo-real-data-prod.common_reference.FISC_DT_ADJ_FOR_CUR_YEAR_53WK_V` AS ty_previous_quarter
      ON CASE
      WHEN fisc.fiscalyearquarter_id > 2
      THEN ty_previous_quarter.dayofweek_no = 1
      AND ty_previous_quarter.weekinperiod_nbr = 1
      AND ty_previous_quarter.fiscalyear_id = fisc.fiscalyear_id
      AND ty_previous_quarter.fiscalyearquarter_id = (fisc.fiscalyearquarter_id - 2)
      WHEN fisc.fiscalyearweek_id = 2
      THEN ty_previous_quarter.dayofweek_no = 1
      AND ty_previous_quarter.weekinperiod_nbr = 1
      AND ty_previous_quarter.fiscalyear_id = (fisc.fiscalyear_id - 1)
      AND ty_previous_quarter.fiscalyearperiod_id = 4
      WHEN fisc.fiscalyearweek_id = 1
      THEN ty_previous_quarter.dayofweek_no = 1
      AND ty_previous_quarter.weekinperiod_nbr = 1
      AND ty_previous_quarter.fiscalyear_id = (fisc.fiscalyear_id - 1)
      AND ty_previous_quarter.fiscalyearperiod_id = 3
      END

      LEFT JOIN `aeo-real-data-prod.common_reference.FISC_DT_ADJ_FOR_CUR_YEAR_53WK_V` AS ly_last_quarter
      ON
      ly_last_quarter.dayofweek_no = 1
      AND ly_last_quarter.fiscalyear_id = fisc.fiscalyear_id - 1
      AND ly_last_quarter.weekinperiod_nbr = 1
      AND ly_last_quarter.fiscalyearquarter_id = fisc.fiscalyearquarter_id - 1
      LEFT JOIN `aeo-real-data-prod.common_reference.FISC_DT_ADJ_FOR_CUR_YEAR_53WK_V` AS last_year
      ON last_year.dayofweek_no = 1
      AND last_year.fiscalyear_id = fisc.fiscalyear_id - 1
      AND last_year.weekinperiod_nbr = 1
      AND last_year.fiscalyearperiod_id = fisc.fiscalyearperiod_id
      -- WHERE (fisc.AEO_DATE) = '2022-01-30'
      WHERE (fisc.AEO_DATE ) = CURRENT_DATE()
      GROUP BY  1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43
      )

      SELECT
      fisc_dt_adj_for_cur_year_53_wk_v.aeo_date,
      CASE WHEN fisc_dt_adj_for_cur_year_53_wk_v.aeo_date BETWEEN
      reference_dates.ty_last_week_start_date AND reference_dates.ty_last_week_end_date THEN reference_dates.ty_last_week_fiscal_desc END AS last_week_label,
      CASE WHEN fisc_dt_adj_for_cur_year_53_wk_v.aeo_date BETWEEN
      reference_dates.ty_previous_week_start_date AND reference_dates.ty_previous_week_end_date THEN reference_dates.ty_previous_week_fiscal_desc END AS previous_week_label,
      CASE WHEN fisc_dt_adj_for_cur_year_53_wk_v.aeo_date BETWEEN
      reference_dates.ly_last_week_start_date AND reference_dates.ly_last_week_end_date THEN reference_dates.ly_last_week_fiscal_desc END AS ly_last_week_label,

      CASE WHEN fisc_dt_adj_for_cur_year_53_wk_v.aeo_date BETWEEN
      reference_dates.ty_last_month_start_date AND reference_dates.ty_last_month_end_date THEN reference_dates.ty_last_month_fiscal_desc END AS last_month_label,
      CASE WHEN fisc_dt_adj_for_cur_year_53_wk_v.aeo_date BETWEEN
      reference_dates.ty_previous_month_start_date AND reference_dates.ty_previous_month_end_date THEN reference_dates.ty_previous_month_fiscal_desc END AS previous_month_label,
      CASE WHEN fisc_dt_adj_for_cur_year_53_wk_v.aeo_date BETWEEN
      reference_dates.ly_last_month_start_date AND reference_dates.ly_last_month_end_date THEN reference_dates.ly_last_month_fiscal_desc END AS ly_last_month_label,

      CASE WHEN fisc_dt_adj_for_cur_year_53_wk_v.aeo_date BETWEEN
      reference_dates.ty_last_quarter_start_date AND reference_dates.ty_last_quarter_end_date THEN reference_dates.ty_last_quarter_fiscal_desc END AS last_quarter_label,
      CASE WHEN fisc_dt_adj_for_cur_year_53_wk_v.aeo_date BETWEEN
      reference_dates.ty_previous_quarter_start_date AND reference_dates.ty_previous_quarter_end_date THEN reference_dates.ty_previous_quarter_fiscal_desc END AS previous_quarter_label,
      CASE WHEN fisc_dt_adj_for_cur_year_53_wk_v.aeo_date BETWEEN
      reference_dates.ly_last_quarter_start_date AND reference_dates.ly_last_quarter_end_date THEN reference_dates.ly_last_quarter_fiscal_desc END AS ly_last_quarter_label,

      CASE WHEN fisc_dt_adj_for_cur_year_53_wk_v.aeo_date BETWEEN
      reference_dates.fiscalyearstart_date AND reference_dates.fiscalyearend_date THEN reference_dates.fiscalyear_desc END AS this_year_label,
      CASE WHEN fisc_dt_adj_for_cur_year_53_wk_v.aeo_date BETWEEN
      reference_dates.last_year_fiscal_year_start_date AND reference_dates.last_year_fiscal_year_end_date
      AND  fisc_dt_adj_for_cur_year_53_wk_v.fiscaldayofyear_nbr <= reference_dates.fiscaldayofyear_nbr
      THEN reference_dates.last_year_fiscal_year_desc END AS last_year_label,


      FROM `aeo-real-data-prod.common_reference.FISC_DT_ADJ_FOR_CUR_YEAR_53WK_V` AS fisc_dt_adj_for_cur_year_53_wk_v
      CROSS JOIN reference_dates
      WHERE fisc_dt_adj_for_cur_year_53_wk_v.AEO_DATE >= (DATE('2021-01-01')) AND fisc_dt_adj_for_cur_year_53_wk_v.AEO_DATE < CURRENT_Date()
      order by 1
      ;;
  }



  dimension: aeo_date {
    type: date
    datatype: date
    sql: ${TABLE}.aeo_date ;;
  }

  dimension: last_week_label {
    type: string
    sql: ${TABLE}.last_week_label ;;
  }

  dimension: previous_week_label {
    type: string
    sql: ${TABLE}.previous_week_label ;;
  }

  dimension: ly_last_week_label {
    type: string
    sql: ${TABLE}.ly_last_week_label ;;
  }

  dimension: last_month_label {
    type: string
    sql: ${TABLE}.last_month_label ;;
  }

  dimension: previous_month_label {
    type: string
    sql: ${TABLE}.previous_month_label ;;
  }

  dimension: ly_last_month_label {
    type: string
    sql: ${TABLE}.ly_last_month_label ;;
  }

  dimension: last_quarter_label {
    type: string
    sql: ${TABLE}.last_quarter_label ;;
  }

  dimension: previous_quarter_label {
    type: string
    sql: ${TABLE}.previous_quarter_label ;;
  }

  dimension: ly_last_quarter_label {
    type: string
    sql: ${TABLE}.ly_last_quarter_label ;;
  }

  dimension: this_year_label {
    type: string
    sql: ${TABLE}.this_year_label ;;
  }

  dimension: last_year_label {
    type: string
    sql: ${TABLE}.last_year_label ;;
  }







  ## Comparison Lables
  dimension: week_lp_lable {
    # hidden: yes
    type: string
    sql:  COALESCE(${last_week_label},${previous_week_label});;
  }
  dimension: week_ly_lable {
    # hidden: yes
    type: string
    sql:  COALESCE(${last_week_label},${ly_last_week_label});;
  }

  dimension: month_lp_label {
    hidden: yes
    type: string
    sql:  COALESCE(${last_month_label},${previous_month_label}) ;;
  }
  dimension: month_ly_label {
    hidden: yes
    type: string
    sql:  COALESCE(${last_month_label},${ly_last_month_label}) ;;
  }

  dimension: quarter_lp_lable {
    hidden: yes
    type: string
    sql:  COALESCE(${last_quarter_label},${previous_quarter_label}) ;;
  }
  dimension: quarter_ly_lable {
    hidden: yes
    type: string
    sql:  COALESCE(${last_quarter_label},${ly_last_quarter_label}) ;;
  }

  dimension: year_lp_lable {
    hidden: yes
    type: string
    sql:  COALESCE(${this_year_label},${last_year_label}) ;;
  }

  dimension: year_ly_lable {
    hidden: yes
    type: string
    sql:  COALESCE(${this_year_label},${last_year_label}) ;;
  }

  dimension: dynamic_period_dimension {
    view_label: " Period Comparison"
    label: "Period Lable"
    type: string
    label_from_parameter: period_lens
    sql:
        {% if period_lens._parameter_value == "week" and period_compare._parameter_value == "last_period" %}
        ${week_lp_lable}
        {% elsif period_lens._parameter_value == "week" and period_compare._parameter_value == "last_year" %}
        ${week_ly_lable}
        {% elsif period_lens._parameter_value == "month" and period_compare._parameter_value == "last_period" %}
        ${month_lp_label}
        {% elsif period_lens._parameter_value == "month" and period_compare._parameter_value == "last_year" %}
        ${month_ly_label}
        {% elsif period_lens._parameter_value == "quarter" and period_compare._parameter_value == "last_period" %}
        ${quarter_lp_lable}
        {% elsif period_lens._parameter_value == "quarter" and period_compare._parameter_value == "last_year" %}
        ${quarter_ly_lable}
        {% elsif period_lens._parameter_value == "year" and period_compare._parameter_value == "last_period" %}
        ${year_ly_lable}
        {% elsif period_lens._parameter_value == "year" and period_compare._parameter_value == "last_year" %}
        ${year_ly_lable}
        {% else  %}
        "N/A"
        {% endif %} ;;
  }
}



#     derived_table: {
#       explore_source: relative_time_dates_based_on_yesterday {
#         column: aeo_date {}
#         column: last_3_weeks_1_date {}
#         column: ly_last_week_date {}
#         column: last_3_weeks_2_date {}
#         column: fiscalweek_desc { field: fisc_dt_adj_for_cur_year_53_wk_v.fiscalweek_desc }
#         column: mtd_ty_label {}
#         column: mtd_ly_label {}
#         column: last_month_label {}
#         column: last_3_months_2_date {}
#         column: last_month_ly_label {}
#         column: fiscalperiod_desc { field: fisc_dt_adj_for_cur_year_53_wk_v.fiscalperiod_desc }
#         column: qtd_ty_label {}
#         column: qtd_ly_label {}
#         column: last_quarter_label {}
#         column: last_3_quarters_2_date {}
#         column: ly_last_quarter_date {}
#         column: fiscalquarter_desc { field: fisc_dt_adj_for_cur_year_53_wk_v.fiscalquarter_desc }
#         column: ytd_ty_label {}
#         column: ytd_ly_label {}
#       }
#     }
#     dimension: aeo_date {
#       type: date
#     }
#     dimension: last_3_weeks_1_date {
#       # hidden: yes
#       type: date
#     }
#     dimension: ly_last_week_date {
#       # hidden: yes
#       type: date
#     }
#     dimension: last_3_weeks_2_date {
#       # hidden: yes
#       type: date
#     }
#     dimension: fiscalweek_desc {
#       # hidden: yes
#     }
#     dimension: mtd_ty_label {
#       hidden: yes
#     }
#     dimension: mtd_ly_label {
#       hidden: yes
#     }
#     dimension: last_month_label {
#       # hidden: yes
#     }
#     dimension: last_3_months_2_date {
#       # hidden: yes
#       type: date
#     }
#     dimension: last_month_ly_label {
#       # hidden: yes
#     }
#     dimension: fiscalperiod_desc {
#       # hidden: yes
#     }
#     dimension: qtd_ty_label {
#       hidden: yes
#     }
#     dimension: qtd_ly_label {
#       hidden: yes
#     }
#     dimension: last_quarter_label {
#       # hidden: yes
#     }
#     dimension: last_3_quarters_2_date {
#       # hidden: yes
#       type: date
#     }
#     dimension: ly_last_quarter_date {
#       # hidden: yes
#       type: date
#     }
#     dimension: fiscalquarter_desc {
#       # hidden: yes
#     }
#     dimension: ytd_ty_label {
#       # hidden: yes
#     }
#     dimension: ytd_ly_label {
#       # hidden: yes
#     }


# # Lables
# dimension: last_week_label {
#   type: string
#   sql: CASE WHEN ${last_3_weeks_1_date} IS NOT NULL THEN ${fiscalweek_desc} ELSE NULL END  ;;
# }

#   dimension: previous_week_label {
#     type: string
#     sql: CASE WHEN ${last_3_weeks_2_date} IS NOT NULL THEN ${fiscalweek_desc} ELSE NULL END ;;
#   }

#   dimension: last_week_ly_label {
#     type: string
#     sql: CASE WHEN ${ly_last_week_date} IS NOT NULL THEN ${fiscalweek_desc} ELSE NULL END ;;
#   }



#   dimension: previous_month_label {
#     type: string
#     sql: CASE WHEN ${last_3_months_2_date} IS NOT NULL THEN ${fiscalperiod_desc} ELSE NULL END ;;
#   }




#   dimension: previous_quarter_label {
#     type: string
#     sql: CASE WHEN ${last_3_quarters_2_date} IS NOT NULL THEN ${fiscalquarter_desc} ELSE NULL END ;;
#   }


#   dimension: last_quarter_ly_label {
#     type: string
#     sql: CASE WHEN ${ly_last_quarter_date} IS NOT NULL THEN ${fiscalquarter_desc} ELSE NULL END ;;
#   }





# view: relative_dates {
#   # https://aeo.cloud.looker.com/explore/aeo_poc/relative_dates_step_1?qid=4qaKxgMoaZIjUWUjO1k8co&toggle=fil
#   extends: [relative_date_parameters]
#     derived_table: {
#       explore_source: relative_dates_step_1 {
#         column: fiscalweek_desc {}
#         column: dynamic_period_dimension {}
#         filters: {
#           field: relative_dates_step_1.dynamic_period_dimension
#           value: "-NULL"
#         }
#         bind_filters: {
#           to_field: relative_dates_step_1.period_lens
#           from_field: relative_dates.period_lens
#         }
#         bind_filters: {
#           to_field: relative_dates_step_1.period_compare
#           from_field: relative_dates.period_compare
#         }
#       }
#     }




#   dimension: fiscalweek_desc {
#     view_label: "Period Comparison"
#     # hidden: yes
#     type: string
#   }

#     dimension: dynamic_period_dimension {
#       view_label: "Period Comparison"
#       label_from_parameter: period_lens
#     }
#   }
