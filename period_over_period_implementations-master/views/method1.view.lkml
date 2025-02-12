## Period over Period Method 1: Use Looker's native date dimension groups
##
## Refined from:
##    -Molly Lippsett 2020, Methods for Period Over Period (PoP) Analysis in Looker,[LookML Example],https://community.looker.com/technical-tips-tricks-1021/methods-for-period-over-period-pop-analysis-in-looker-30823
##    -Llooker 2020, Lookml period over period analysis in different dialects, [views],https://github.com/llooker/period_over_period_analysis
##
## Created by: Carl Clifford - Bytecode IO
## Create Date: 11/29/2022
##
## Modified by: Carl Clifford
## Modified Date: 12/2/2022
## Comments: Added SQL Dialects


include: "/views/order_items.view.lkml"

view: method1 {
  extends: [order_items]

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: order_id {
    view_label: "_PoP"
    type: number
    sql: ${TABLE}.orders_id ;;
  }

  dimension_group: created {
    type: time
    view_label: "_PoP"
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      day_of_week_index,
      day_of_month,
      day_of_year,
      week,
      week_of_year,
      month,
      month_name,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
    convert_tz: no
  }


### WTD, MTD and YTD filters

  parameter: to_date_selection {
    label: "Display only Period to Date"
    view_label: "_PoP"
    type: unquoted
    default_value: "No"
    allowed_value: {
      label: "WTD_Only"
      value:"WTD"
      }
    allowed_value: {
      label: "MTD_Only"
      value:"MTD"
    }
    allowed_value: {
      label: "YTD_Only"
      value:"YTD"
    }
    allowed_value: {
      label:"Display all Dates"
      value:"No"
      }
  }


  parameter: YTD_selection {
    label: "Display only Year to Date"
    view_label: "_PoP"
    type: unquoted
    default_value: "No"
    allowed_value: {
      label: "YTD_Only"
      value:"YTD"
    }
    allowed_value: {
      label:"Display all Dates"
      value:"No"
    }
  }

  parameter: MTD_selection {
    label: "Display only Month to Date"
    view_label: "_PoP"
    type: unquoted
    default_value: "No"
    allowed_value: {
      label: "MTD_Only"
      value:"MTD"
    }
    allowed_value: {
      label:"Display all Dates"
      value:"No"
    }
  }

  parameter: WTD_selection {
    label: "Display only Week to Date"
    view_label: "_PoP"
    type: unquoted
    default_value: "No"
    allowed_value: {
      label: "WTD_Only"
      value:"WTD"
    }
    allowed_value: {
      label:"Display all Dates"
      value:"No"
    }
  }


  dimension: to_date {
    group_label: "To-Date Filters"
    label: "1. To-Date"
    view_label: "_PoP"
    type: yesno
    sql:
      {% if to_date_selection._parameter_value == 'WTD' %}
        ${wtd_only}
      {% elsif to_date_selection._parameter_value == 'MTD' %}
        ${mtd_only}
      {% elsif to_date_selection._parameter_value == 'YTD' %}
        ${ytd_only}
      {% else %}
        1 = 1
      {% endif %};;
  }

  dimension: year_to_date {
    group_label: "To-Date Filters"
    label: "Year-To-Date"
    view_label: "_PoP"
    type: yesno
    sql:
      {% if YTD_selection._parameter_value == 'YTD' %}
        ${ytd_only}
      {% else %}
        1 = 1
      {% endif %};;
  }

  dimension: month_to_date {
    group_label: "To-Date Filters"
    label: "Month-To-Date"
    view_label: "_PoP"
    type: yesno
    sql:
      {% if MTD_selection._parameter_value == 'MTD' %}
        ${mtd_only}
      {% else %}
        1 = 1
      {% endif %};;
  }

  dimension: week_to_date {
    group_label: "To-Date Filters"
    label: "Week-To-Date"
    view_label: "_PoP"
    type: yesno
    sql:
      {% if YTD_selection._parameter_value == 'WTD' %}
        ${wtd_only}
      {% else %}
        1 = 1
      {% endif %};;
  }




### - BIGQUERY {




  dimension: wtd_only {
    group_label: "To-Date Filters"
    label: "WTD"
    view_label: "_PoP"
    hidden: yes
    type: yesno
    sql:  (EXTRACT(DAYOFWEEK FROM ${created_raw}) < EXTRACT(DAYOFWEEK FROM CURRENT_DATE())
                  OR
              (EXTRACT(DAYOFWEEK FROM ${created_raw}) = EXTRACT(DAYOFWEEK FROM CURRENT_DATE()) AND
              EXTRACT(HOUR FROM ${created_raw}) < EXTRACT(HOUR FROM CURRENT_TIME()))
                  OR
              (EXTRACT(DAYOFWEEK FROM ${created_raw}) = EXTRACT(DAYOFWEEK FROM CURRENT_DATE()) AND
              EXTRACT(HOUR FROM ${created_raw}) <= EXTRACT(HOUR FROM CURRENT_TIME()) AND
              EXTRACT(MINUTE FROM ${created_raw}) < EXTRACT(MINUTE FROM CURRENT_TIME())))  ;;
  }

  dimension: mtd_only {
    group_label: "To-Date Filters"
    label: "MTD"
    view_label: "_PoP"
    hidden: yes
    type: yesno
    sql:  (EXTRACT(DAY FROM ${created_raw}) < EXTRACT(DAY FROM CURRENT_DATE())
                  OR
              (EXTRACT(DAY FROM ${created_raw}) = EXTRACT(DAY FROM CURRENT_DATE()) AND
              EXTRACT(HOUR FROM ${created_raw}) < EXTRACT(HOUR FROM CURRENT_TIME()))
                  OR
              (EXTRACT(DAY FROM ${created_raw}) = EXTRACT(DAY FROM CURRENT_DATE()) AND
              EXTRACT(HOUR FROM ${created_raw}) <= EXTRACT(HOUR FROM CURRENT_TIME()) AND
              EXTRACT(MINUTE FROM ${created_raw}) < EXTRACT(MINUTE FROM CURRENT_TIME())))  ;;
  }

  dimension: ytd_only {
    group_label: "To-Date Filters"
    label: "YTD"
    view_label: "_PoP"
    hidden: yes
    type: yesno
    sql:  (EXTRACT(DAYOFYEAR FROM ${created_raw}) < EXTRACT(DAYOFYEAR FROM CURRENT_DATE())
                  OR
              (EXTRACT(DAYOFYEAR FROM ${created_raw}) = EXTRACT(DAYOFYEAR FROM CURRENT_DATE()) AND
              EXTRACT(HOUR FROM ${created_raw}) < EXTRACT(HOUR FROM CURRENT_TIME()))
                  OR
              (EXTRACT(DAYOFYEAR FROM ${created_raw}) = EXTRACT(DAYOFYEAR FROM CURRENT_DATE()) AND
              EXTRACT(HOUR FROM ${created_raw}) <= EXTRACT(HOUR FROM CURRENT_TIME()) AND
              EXTRACT(MINUTE FROM ${created_raw}) < EXTRACT(MINUTE FROM CURRENT_TIME())))  ;;
  }

### } / - END BIGQUERY

### - REDSHIFT {

  # dimension: wtd_only {
  #   group_label: "To-Date Filters"
  #   label: "WTD"
  #   view_label: "_PoP"
  #   type: yesno
  #   sql:  (EXTRACT(DOW FROM ${created_raw}) < EXTRACT(DOW FROM GETDATE())
  #             OR
  #         (EXTRACT(DOW FROM ${created_raw}) = EXTRACT(DOW FROM GETDATE()) AND
  #         EXTRACT(HOUR FROM ${created_raw}) < EXTRACT(HOUR FROM GETDATE()))
  #             OR
  #         (EXTRACT(DOW FROM ${created_raw}) = EXTRACT(DOW FROM GETDATE()) AND
  #         EXTRACT(HOUR FROM ${created_raw}) <= EXTRACT(HOUR FROM GETDATE()) AND
  #         EXTRACT(MINUTE FROM ${created_raw}) < EXTRACT(MINUTE FROM GETDATE())))  ;;
  # }

  # dimension: mtd_only {
  #   group_label: "To-Date Filters"
  #   label: "MTD"
  #   view_label: "_PoP"
  #   type: yesno
  #   sql:  (EXTRACT(DAY FROM ${created_raw}) < EXTRACT(DAY FROM GETDATE())
  #             OR
  #         (EXTRACT(DAY FROM ${created_raw}) = EXTRACT(DAY FROM GETDATE()) AND
  #         EXTRACT(HOUR FROM ${created_raw}) < EXTRACT(HOUR FROM GETDATE()))
  #             OR
  #         (EXTRACT(DAY FROM ${created_raw}) = EXTRACT(DAY FROM GETDATE()) AND
  #         EXTRACT(HOUR FROM ${created_raw}) <= EXTRACT(HOUR FROM GETDATE()) AND
  #         EXTRACT(MINUTE FROM ${created_raw}) < EXTRACT(MINUTE FROM GETDATE())))  ;;
  # }

  # dimension: ytd_only {
  #   group_label: "To-Date Filters"
  #   label: "YTD"
  #   view_label: "_PoP"
  #   type: yesno
  #   sql:  (EXTRACT(DOY FROM ${created_raw}) < EXTRACT(DOY FROM GETDATE())
  #             OR
  #         (EXTRACT(DOY FROM ${created_raw}) = EXTRACT(DOY FROM GETDATE()) AND
  #         EXTRACT(HOUR FROM ${created_raw}) < EXTRACT(HOUR FROM GETDATE()))
  #             OR
  #         (EXTRACT(DOY FROM ${created_raw}) = EXTRACT(DOY FROM GETDATE()) AND
  #         EXTRACT(HOUR FROM ${created_raw}) <= EXTRACT(HOUR FROM GETDATE()) AND
  #         EXTRACT(MINUTE FROM ${created_raw}) < EXTRACT(MINUTE FROM GETDATE())))  ;;
  # }

### } / - END REDSHIFT

### - SNOWFLAKE {

  # dimension: wtd_only {
  #   group_label: "To-Date Filters"
  #   label: "WTD"
  #   view_label: "_PoP"
  #   type: yesno
  #   sql:  (EXTRACT(dow_iso FROM ${created_raw}) < EXTRACT(dow_iso FROM GETDATE())
  #             OR
  #         (EXTRACT(dow_iso FROM ${created_raw}) = EXTRACT(dow_iso FROM GETDATE()) AND
  #         EXTRACT(HOUR FROM ${created_raw}) < EXTRACT(HOUR FROM GETDATE()))
  #             OR
  #         (EXTRACT(dow_iso FROM ${created_raw}) = EXTRACT(dow_iso FROM GETDATE()) AND
  #         EXTRACT(HOUR FROM ${created_raw}) <= EXTRACT(HOUR FROM GETDATE()) AND
  #         EXTRACT(MINUTE FROM ${created_raw}) < EXTRACT(MINUTE FROM GETDATE())))  ;;
  # }

  # dimension: mtd_only {
  #   group_label: "To-Date Filters"
  #   label: "MTD"
  #   view_label: "_PoP"
  #   type: yesno
  #   sql:  (EXTRACT(DAY FROM ${created_raw}) < EXTRACT(DAY FROM GETDATE())
  #             OR
  #         (EXTRACT(DAY FROM ${created_raw}) = EXTRACT(DAY FROM GETDATE()) AND
  #         EXTRACT(HOUR FROM ${created_raw}) < EXTRACT(HOUR FROM GETDATE()))
  #             OR
  #         (EXTRACT(DAY FROM ${created_raw}) = EXTRACT(DAY FROM GETDATE()) AND
  #         EXTRACT(HOUR FROM ${created_raw}) <= EXTRACT(HOUR FROM GETDATE()) AND
  #         EXTRACT(MINUTE FROM ${created_raw}) < EXTRACT(MINUTE FROM GETDATE())))  ;;
  # }

  # dimension: ytd_only {
  #   group_label: "To-Date Filters"
  #   label: "YTD"
  #   view_label: "_PoP"
  #   type: yesno
  #   sql:  (EXTRACT(DOY FROM ${created_raw}) < EXTRACT(DOY FROM GETDATE())
  #             OR
  #         (EXTRACT(DOY FROM ${created_raw}) = EXTRACT(DOY FROM GETDATE()) AND
  #         EXTRACT(HOUR FROM ${created_raw}) < EXTRACT(HOUR FROM GETDATE()))
  #             OR
  #         (EXTRACT(DOY FROM ${created_raw}) = EXTRACT(DOY FROM GETDATE()) AND
  #         EXTRACT(HOUR FROM ${created_raw}) <= EXTRACT(HOUR FROM GETDATE()) AND
  #         EXTRACT(MINUTE FROM ${created_raw}) < EXTRACT(MINUTE FROM GETDATE())))  ;;
  # }

  # dimension: wtd_only_without_today {
  #   group_label: "To-Date Filters"
  #   label: "WTD (today excluded)"
  #   view_label: "_PoP"
  #   type: yesno
  #   sql:  EXTRACT(dow_iso FROM ${created_raw}) < EXTRACT(dow_iso FROM GETDATE() ;;
  # }

  # dimension: mtd_only_without_today {
  #   group_label: "To-Date Filters"
  #   label: "MTD (today excluded)"
  #   view_label: "_PoP"
  #   type: yesno
  #   sql:  EXTRACT(DAY FROM ${created_raw}) < EXTRACT(DAY FROM GETDATE()) ;;
  # }

  # dimension: ytd_only_without_today {
  #   group_label: "To-Date Filters"
  #   label: "YTD (today excluded)"
  #   view_label: "_PoP"
  #   type: yesno
  #   sql:  EXTRACT(DOY FROM ${created_raw}) < EXTRACT(DOY FROM GETDATE());;
  # }

### } / - END SNOWFLAKE

### - MYSQL {

  # dimension: wtd_only {
  #   group_label: "To-Date Filters"
  #   label: "WTD"
  #   view_label: "_PoP"
  #   type: yesno
  #   sql:  (DAYOFWEEK(${created_raw}) < DAYOFWEEK(CURDATE())
  #             OR
  #         (DAYOFWEEK(${created_raw}) = DAYOFWEEK(CURDATE()) AND
  #         HOUR(${created_raw}) < HOUR (CURTIME()))
  #             OR
  #         (DAYOFWEEK(${created_raw}) = DAYOFWEEK(CURDATE()) AND
  #         HOUR (${created_raw}) <= HOUR (CURTIME()) AND
  #         MINUTE (${created_raw}) < MINUTE (CURTIME())));;
  # }

  # dimension: mtd_only {
  #   group_label: "To-Date Filters"
  #   label: "MTD"
  #   view_label: "_PoP"
  #   type: yesno
  #   sql:  (MONTH( ${created_raw}) < MONTH(CURDATE())
  #             OR
  #         (EXTRACT(DAY FROM ${created_raw}) = EXTRACT(DAY FROM CURDATE()) AND
  #         EXTRACT(HOUR FROM ${created_raw}) < EXTRACT(HOUR FROM CURDATE()))
  #             OR
  #         (EXTRACT(DAY FROM ${created_raw}) = EXTRACT(DAY FROM CURDATE()) AND
  #         EXTRACT(HOUR FROM ${created_raw}) <= EXTRACT(HOUR FROM CURTIME()) AND
  #         EXTRACT(MINUTE FROM ${created_raw}) < EXTRACT(MINUTE FROM CURTIME())))  ;;
  # }

  # dimension: ytd_only {
  #   group_label: "To-Date Filters"
  #   label: "YTD"
  #   view_label: "_PoP"
  #   type: yesno
  #   sql:  (DAYOFYEAR(${created_raw}) < DAYOFYEAR( CURDATE())
  #             OR
  #         (DAYOFYEAR (${created_raw}) = DAYOFYEAR( CURDATE()) AND
  #         EXTRACT(HOUR FROM ${created_raw}) < EXTRACT(HOUR FROM CURTIME()))
  #             OR
  #         (DAYOFYEAR(${created_raw}) = DAYOFYEAR(CURDATE()) AND
  #         EXTRACT(HOUR FROM ${created_raw}) <= EXTRACT(HOUR FROM CURTIME()) AND
  #         EXTRACT(MINUTE FROM ${created_raw}) < EXTRACT(MINUTE FROM CURTIME())))  ;;
  # }

### } / - END MYSQL



  dimension: sale_price {
    # not originally in the article
    view_label: "_PoP"
    sql: ${TABLE}.sale_price ;;
  }

  measure: count {
    label: "Count of order_items"
    type: count
    hidden: yes
  }
  measure: count_orders {
    label: "Count of orders"
    type: count_distinct
    sql: ${order_id} ;;
    hidden: yes
  }

  measure: total_sale_price {
    label: "Total Sales"
    view_label: "_PoP"
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd
    drill_fields: [created_date]
}
}
explore: method1 {
  label: "PoP Method 1: Use Looker's native date dimension groups"
}
