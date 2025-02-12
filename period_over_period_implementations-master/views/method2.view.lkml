## Period over Period Method 2: Allow users to choose periods with parameters
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
###

include: "/views/method1.view.lkml"


view: method2 {
  extends: [method1]



  parameter: choose_breakdown {
    label: "Choose Grouping (Rows)"
    view_label: "_PoP"
    type: unquoted
    default_value: "Month"
    allowed_value: {label: "Month Name" value:"Month"}
    allowed_value: {label: "Day of Year" value: "DOY"}
    allowed_value: {label: "Day of Month" value: "DOM"}
    allowed_value: {label: "Day of Week" value: "DOW"}
    allowed_value: {value: "Date"}
  }

  parameter: choose_comparison {
    label: "Choose Comparison (Pivot)"
    view_label: "_PoP"
    type: unquoted
    default_value: "Year"
    allowed_value: {value: "Year" }
    allowed_value: {value: "Month"}
    allowed_value: {value: "Week"}
  }

  dimension: pop_row  {
    view_label: "_PoP"
    label_from_parameter: choose_breakdown
    type: string
    order_by_field: sort_by1
    sql:
        {% if choose_breakdown._parameter_value == 'Month' %} ${created_month_name}
        {% elsif choose_breakdown._parameter_value == 'DOY' %} ${created_day_of_year}
        {% elsif choose_breakdown._parameter_value == 'DOM' %} ${created_day_of_month}
        {% elsif choose_breakdown._parameter_value == 'DOW' %} ${created_day_of_week}
        {% elsif choose_breakdown._parameter_value == 'Date' %} ${created_date}
        {% else %}NULL{% endif %} ;;
  }

  dimension: pop_pivot {
    view_label: "_PoP"
    label_from_parameter: choose_comparison
    type: string
    order_by_field: sort_by2
    sql:
        {% if choose_comparison._parameter_value == 'Year' %} ${created_year}
        {% elsif choose_comparison._parameter_value == 'Month' %} ${created_month_name}
        {% elsif choose_comparison._parameter_value == 'Week' %} ${created_week}
        {% else %}NULL{% endif %} ;;
  }


  # These dimensions are to make sure the dimensions sort correctly
  dimension: sort_by1 {
    hidden: yes
    type: number
    sql:
        {% if choose_breakdown._parameter_value == 'Month' %} ${created_month_num}
        {% elsif choose_breakdown._parameter_value == 'DOY' %} ${created_day_of_year}
        {% elsif choose_breakdown._parameter_value == 'DOM' %} ${created_day_of_month}
        {% elsif choose_breakdown._parameter_value == 'DOW' %} ${created_day_of_week_index}
        {% elsif choose_breakdown._parameter_value == 'Date' %} ${created_date}
        {% else %}NULL{% endif %} ;;
  }

  dimension: sort_by2 {
    hidden: yes
    type: string
    sql:
        {% if choose_comparison._parameter_value == 'Year' %} ${created_year}
        {% elsif choose_comparison._parameter_value == 'Month' %} ${created_month_num}
        {% elsif choose_comparison._parameter_value == 'Week' %} ${created_week}
        {% else %}NULL{% endif %} ;;
  }
}

explore: method2 {
  label: "PoP Method 2: Allow users to choose periods with parameters"
  always_filter: {
    filters: [choose_comparison: "Year", choose_breakdown: "Month"]
  }
}
