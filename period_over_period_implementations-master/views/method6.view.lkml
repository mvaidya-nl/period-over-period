##  Period over Period Method 6: Compare two arbitrary date ranges
##
## Refined from:
##    -Molly Lippsett 2020, Methods for Period Over Period (PoP) Analysis in Looker,[LookML Example],https://community.looker.com/technical-tips-tricks-1021/methods-for-period-over-period-pop-analysis-in-looker-30823
##    -Llooker 2020, Lookml period over period analysis in different dialects, [views],https://github.com/llooker/period_over_period_analysis
##
## Created by: Carl Clifford - Bytecode IO
## Create Date: 11/29/2022
##
## Modified by:
## Modified Date:
## Comments:



# Like Method 5, but allowing arbitrary definition of the 'current' period
# provides functionality like Google Analytics, which allows you to compare two arbitrary date ranges


include: "/views/method1.view.lkml"

view: method6 {
  extends: [method1]


## ------------------ USER FILTERS  ------------------ ##

  filter: first_period_filter {
    view_label: "_PoP"
    group_label: "Arbitrary Period Comparisons"
    description: "Choose the first date range to compare against. This must be before the second period"
    type: date
  }

  filter: second_period_filter {
    view_label: "_PoP"
    group_label: "Arbitrary Period Comparisons"
    description: "Choose the second date range to compare to. This must be after the first period"
    type: date
  }

## ------------------ HIDDEN HELPER DIMENSIONS  ------------------ ##

### - BIGQUERY {

  dimension: days_from_start_first {
    view_label: "_PoP"
    # hidden: yes
    type: number
    # the order here matters because
    # BigQuery doc: "If the first DATE is earlier than the second one, the output is negative."
    # Redshift doc: "If the second date or time is earlier than the first date or time, the result is negative."
    sql: DATE_DIFF(${created_date}, DATE({% date_start first_period_filter %}), DAY)  ;;

  }

  dimension: days_from_start_second {
    view_label: "_PoP"
    # hidden: yes
    type: number
    # the order here matters because
    # BigQuery doc: "If the first DATE is earlier than the second one, the output is negative."
    # Redshift doc: "If the second date or time is earlier than the first date or time, the result is negative."
    sql: DATE_DIFF( ${created_date}, DATE({% date_start second_period_filter %}), DAY)  ;;
  }

### } / - END BIGQUERY

### - REDSHIFT {


  # dimension: days_from_start_first {
  #   view_label: "_PoP"
  #   hidden: yes
  #   type: number
  #   sql: DATEDIFF(day,  {% date_start first_period_filter %}, ${created_date}) ;;
  # }

  # dimension: days_from_start_second {
  #   view_label: "_PoP"
  #   hidden: yes
  #   type: number
  #   sql: DATEDIFF(day,  {% date_start second_period_filter %}, ${created_date}) ;;
  # }


  ### } / - END REDSHIFT

### - SNOWFLAKE {

  # dimension: days_from_start_first {
  #   view_label: "_PoP"
  #   hidden: yes
  #   type: number
  #   sql: DATEDIFF(day,  {% date_start first_period_filter %}, ${created_date}) ;;
  # }

  # dimension: days_from_start_second {
  #   view_label: "_PoP"
  #   hidden: yes
  #   type: number
  #   sql: DATEDIFF(day,  {% date_start second_period_filter %}, ${created_date}) ;;
  # }


### } / - END SNOWFLAKE

### - MYSQL {

  # dimension: days_from_start_first {
  #   view_label: "_PoP"
  #   hidden: yes
  #   type: number
  #   sql: DATEDIFF(${created_date}, {% date_start first_period_filter %}) ;;
  # }

  # dimension: days_from_start_second {
  #   view_label: "_PoP"
  #   hidden: yes
  #   type: number
  #   sql: DATEDIFF(${created_date}, {% date_start second_period_filter %}) ;;
  # }


### } / - END MYSQL




## ------------------ DIMENSIONS TO PLOT ------------------ ##

  dimension: days_from_first_period {
    view_label: "_PoP"
    description: "Select for Grouping (Rows)"
    group_label: "Arbitrary Period Comparisons"
    type: number
    sql:
        CASE
        WHEN ${days_from_start_second} >= 0
        THEN ${days_from_start_second}
        WHEN ${days_from_start_first} >= 0
        THEN ${days_from_start_first}
        END;;
  }


  dimension: period_selected {
    view_label: "_PoP"
    group_label: "Arbitrary Period Comparisons"
    label: "First or second period"
    description: "Select for Comparison (Pivot)"
    type: string
    sql:
        CASE
            WHEN {% condition first_period_filter %}${created_raw} {% endcondition %}
            THEN 'First Period'
            WHEN {% condition second_period_filter %}${created_raw} {% endcondition %}
            THEN 'Second Period'
            END ;;
  }

## Filtered measures

  measure: current_period_sales {
    view_label: "_PoP"
    type: sum
    sql: ${sale_price};;
    filters: [period_selected: "Second Period"]
  }

  measure: previous_period_sales {
    view_label: "_PoP"
    type: sum
    sql: ${sale_price};;
    filters: [period_selected: "First Period"]
  }

  measure: sales_pop_change {
    view_label: "_PoP"
    label: "Total sales period-over-period % change"
    type: number
    sql: (1.0 * ${current_period_sales} / NULLIF(${previous_period_sales} ,0)) - 1 ;;
    value_format_name: percent_2
  }

  dimension_group: created {hidden: yes}
  dimension: ytd_only {hidden:yes}
  dimension: mtd_only {hidden:yes}
  dimension: wtd_only {hidden:yes}
}

explore: method6 {
  label: "PoP Method 6: Compare two arbitrary date ranges"
  always_filter: {
    filters: [first_period_filter: "1 year", second_period_filter: "2 years ", period_selected:"-NULL"]
  }
}
