## Period over Period Method 3: Custom choice of current and previous periods with parameters
##
## Refined from:
##    -Molly Lippsett 2020, Methods for Period Over Period (PoP) Analysis in Looker,[LookML Example],https://community.looker.com/technical-tips-tricks-1021/methods-for-period-over-period-pop-analysis-in-looker-30823
##    -Llooker 2020, Lookml period over period analysis in different dialects, [views],https://github.com/llooker/period_over_period_analysis
##
## Created by: Carl Clifford - Bytecode IO
## Create Date: 12/19/2022
##
## Modified by:
## Modified Date:
## Comments:


###  Period over Period Method 7: Compare any period with the previous preceding period of the same length


# Like Method 2, but here we define any date filter (not just current) and
# compare it to the previous period of the same length - great for single value visualization comparisons

include: "method1.view.lkml"
view: method7 {
  extends: [order_items]


  filter: date_filter {
    view_label: "_PoP"
    description: "Use this date filter in combination with the timeframes dimension for dynamic date filtering"
    type: date
  }

  dimension_group: filter_start_date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: CASE WHEN {% date_start date_filter %} IS NULL THEN '2013-01-01' ELSE CAST({% date_start date_filter %} AS DATE) END;;
    convert_tz: no
  }


### - BIGQUERY {

  dimension_group: filter_end_date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: CASE WHEN {% date_end date_filter %} IS NULL THEN CURRENT_DATE ELSE CAST({% date_end date_filter %} AS DATE) END;;
    convert_tz: no
  }

  dimension: interval {
    hidden: yes
    type: number
    sql: DATE_DIFF(${filter_end_date_raw},${filter_start_date_raw}, DAY);;
  }

  #start date of the previous period
  dimension: previous_start_date {
    hidden: yes
    type: string
    sql: DATE_ADD(${filter_start_date_raw},INTERVAL - ${interval} DAY);;
  }


### } / - END BIGQUERY

### - REDSHIFT {


#   dimension_group: filter_end_date {
#     hidden: yes
#     type: time
#     timeframes: [raw,date]
#     sql: CASE WHEN {% date_end date_filter %} IS NULL THEN CURRENT_DATE ELSE CAST({% date_end date_filter %} AS DATE) END;;
#   }

#   dimension: interval {
#     hidden: yes
#     type: number
#     sql: datediff(day, ${filter_start_date_raw}, ${filter_end_date_raw});;
#   }

# #start date of the previous period
#   dimension: previous_start_date {
#     hidden: yes
#     type: string
#     sql: DATEADD(day, - ${interval}, ${filter_start_date_raw});;
#   }

### } / - END REDSHIFT

### - SNOWFLAKE {

#   dimension_group: filter_end_date {
#     hidden: yes
#     type: time
#     timeframes: [raw,date]
#     sql: CASE WHEN {% date_end date_filter %} IS NULL THEN CURRENT_DATE ELSE CAST({% date_end date_filter %} AS DATE) END;;
#     convert_tz: no
#   }

#   dimension: interval {
#     hidden: yes
#     type: number
#     sql: datediff(day, ${filter_start_date_raw}, ${filter_end_date_raw});;
#   }

# #start date of the previous period
#   dimension: previous_start_date {
#     hidden: yes
#     type: string
#     sql: DATEADD(day, - ${interval}, ${filter_start_date_raw});;
#   }

### } / - END SNOWFLAKE

### - MYSQL {

#   dimension_group: filter_end_date {
#     hidden: yes
#     type: time
#     timeframes: [raw,date]
#     sql: CASE WHEN {% date_end date_filter %} IS NULL THEN CURRENT_DATE ELSE CAST({% date_end date_filter %} AS DATE) END;;
#     convert_tz: no
#   }

#   dimension: interval {
#     hidden: yes
#     type: number
#     sql: datediff(${filter_end_date_raw},${filter_start_date_raw});;
#   }

# #start date of the previous period
#   dimension: previous_start_date {
#     hidden: yes
#     type: string
#     sql: DATE_ADD(${filter_start_date_raw}, INTERVAL - ${interval} DAY );;
#   }

### } / - END MYSQL



  dimension: timeframes {
    view_label: "_PoP"
    type: string
    case: {
      when: {
        sql: ${is_current_period} = true;;
        label: "Selected Period"
      }
      when: {
        sql: ${is_previous_period} = true;;
        label: "Previous Period"
      }
      else: "Not in time period"
    }
  }

  ## For filtered measures


  dimension: is_current_period {
    hidden: yes
    type: yesno
    sql: ${created_date} >= ${filter_start_date_date} AND ${created_date} < ${filter_end_date_date} ;;
  }

  dimension: is_previous_period {
    hidden: yes
    type: yesno
    sql: ${created_date} >= ${previous_start_date} AND ${created_date} < ${filter_start_date_date} ;;
  }

  measure: selected_period_order_revenue {
    view_label: "_PoP"
    type: sum
    sql: ${sale_price} ;;
    filters: [is_current_period: "yes"]
    value_format_name: decimal_1
  }
  measure: previous_period_order_revenue {
    view_label: "_PoP"
    type: sum
    sql: ${sale_price} ;;
    filters: [is_previous_period: "yes"]
    value_format_name: decimal_1
  }

  dimension: ytd_only {hidden:yes}
  dimension: mtd_only {hidden:yes}
  dimension: wtd_only {hidden:yes}



}




# ---------- EXPLORE ---------- #

explore: method7 {
  label: "PoP Method 7: Compare any period with the previous period"
  always_filter: {
    filters: [date_filter: "1 year"]
  }
  sql_always_where: ${timeframes} <>'Not in time period' ;;
}
