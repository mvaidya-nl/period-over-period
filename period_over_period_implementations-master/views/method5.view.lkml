## Period over Period Method 5: Compare current period with another arbitrary period
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



# Like Method 3, but allows you to compare the current period with any other arbitrary date range period


include: "/views/method3.view.lkml"

## This extended version allows the user to also choose a custom date range for the previous period

view: method5 {
  extends: [method3]

  # custom date range
  filter: previous_date_range {
    type: date
    view_label: "_PoP"
    label: "2a. Previous Date Range (Custom):"
    description: "Select a custom previous period you would like to compare to. Must be used with Current Date Range filter."
  }

  parameter: compare_to {label: "2b. Compare To:"}
  dimension_group: date_in_period {hidden:yes}



### - BIGQUERY {

  dimension: period_2_start {
    view_label: "_PoP"
    description: "Calculates the start of the previous period"
    type: date
    sql:
        {% if compare_to._in_query %}
            {% if compare_to._parameter_value == "Period" %}
            DATE_ADD(DATE({% date_start current_date_range %}), INTERVAL ${days_in_period} DAY)
            {% else %}
            DATE_SUB(DATE({% date_start current_date_range %}), INTERVAL 1 {% parameter compare_to %})
            {% endif %}
        {% else %}
            {% date_start previous_date_range %}
        {% endif %};;
    # hidden:  yes
    }

    dimension: period_2_end {
      # hidden:  yes
      view_label: "_PoP"
      description: "Calculates the end of the previous period"
      type: date
      sql:
        {% if compare_to._in_query %}
            {% if compare_to._parameter_value == "Period" %}
            DATE_SUB(DATE({% date_start current_date_range %}), INTERVAL 1 DAY)
            {% else %}
            DATE_SUB(DATE_SUB(DATE({% date_end current_date_range %}), INTERVAL 1 DAY), INTERVAL 1 {% parameter compare_to %})
            {% endif %}
        {% else %}
            {% date_end previous_date_range %}
        {% endif %};;
    }

### } / - END BIGQUERY

### - REDSHIFT {

  # dimension: period_2_start {
  #   view_label: "_PoP"
  #   description: "Calculates the start of the previous period"
  #   type: date
  #   sql:
  #     {% if compare_to._in_query %}
  #         {% if compare_to._parameter_value == "Period" %}
  #         DATEADD(DAY, -${days_in_period}, DATE({% date_start current_date_range %}))
  #         {% else %}
  #         DATEADD({% parameter compare_to %}, -1, DATE({% date_start current_date_range %}))
  #         {% endif %}
  #     {% else %}
  #         {% date_start previous_date_range %}
  #     {% endif %};;
  #   hidden:  yes
  # }

  # dimension: period_2_end {
  #   hidden:  yes
  #   view_label: "_PoP"
  #   description: "Calculates the end of the previous period"
  #   type: date
  #   sql:
  #     {% if compare_to._in_query %}
  #         {% if compare_to._parameter_value == "Period" %}
  #         DATEADD(DAY, -1, DATE({% date_start current_date_range %}))
  #         {% else %}
  #         DATEADD({% parameter compare_to %}, -1, DATEADD(DAY, -1, DATE({% date_end current_date_range %})))
  #         {% endif %}
  #     {% else %}
  #         {% date_end previous_date_range %}
  #     {% endif %};;
  # }


  ### } / - END REDSHIFT

### - SNOWFLAKE {


  # dimension: period_2_start {
  #   view_label: "_PoP"
  #   description: "Calculates the start of the previous period"
  #   type: date
  #   sql:
  #       {% if compare_to._in_query %}
  #           {% if compare_to._parameter_value == "Period" %}
  #           DATEADD(DAY, -${days_in_period}, DATE({% date_start current_date_range %}))
  #           {% else %}
  #           DATEADD({% parameter compare_to %}, -1, DATE({% date_start current_date_range %}))
  #           {% endif %}
  #       {% else %}
  #           {% date_start previous_date_range %}
  #       {% endif %};;
  #   hidden:  yes
  # }

  # dimension: period_2_end {
  #   hidden:  yes
  #   view_label: "_PoP"
  #   description: "Calculates the end of the previous period"
  #   type: date
  #   sql:
  #       {% if compare_to._in_query %}
  #           {% if compare_to._parameter_value == "Period" %}
  #           DATEADD(DAY, -1, DATE({% date_start current_date_range %}))
  #           {% else %}
  #           DATEADD({% parameter compare_to %}, -1, DATEADD(DAY, -1, DATE({% date_end current_date_range %})))
  #           {% endif %}
  #       {% else %}
  #           {% date_end previous_date_range %}
  #       {% endif %};;
  # }

### } / - END SNOWFLAKE

### - MYSQL {


  # dimension: period_2_start {
  #   view_label: "_PoP"
  #   description: "Calculates the start of the previous period"
  #   type: date
  #   sql:
  #       {% if compare_to._in_query %}
  #           {% if compare_to._parameter_value == "Period" %}
  #           DATE_ADD(DATE({% date_start current_date_range %}), INTERVAL -${days_in_period} DAY)
  #           {% else %}
  #           DATE_ADD(DATE({% date_start current_date_range %}), INTERVAL -1 {% parameter compare_to %})
  #           {% endif %}
  #       {% else %}
  #           {% date_start previous_date_range %}
  #       {% endif %};;
  #   hidden:  yes
  # }

  # dimension: period_2_end {
  #   hidden:  yes
  #   view_label: "_PoP"
  #   description: "Calculates the end of the previous period"
  #   type: date
  #   sql:
  #       {% if compare_to._in_query %}
  #           {% if compare_to._parameter_value == "Period" %}
  #           DATE_ADD(DATE({% date_start current_date_range %}), INTERVAL -1 DAY)
  #           {% else %}
  #           DATE_ADD(DATE_ADD(DATE({% date_end current_date_range %}), INTERVAL -1 DAY), INTERVAL -1 {% parameter compare_to %}) )
  #           {% endif %}
  #       {% else %}
  #           {% date_end previous_date_range %}
  #       {% endif %};;
  # }

### } / - END MYSQL



  }

explore: method5 {
  label: "PoP Method 5: Compare current period with another arbitrary period"
  always_filter: {
    filters: [current_date_range: "1 month", previous_date_range: "2 months ago for 2 days"]
  }
}
