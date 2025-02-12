- dashboard: method_3_custom_choice_of_current_and_previous_periods_with_parameters
  title: 'Method 3: Custom choice of current and previous periods with parameters'
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: QWeZ6LhnoZcYBsh7d1CG4r
  elements:
  - title: Method 3 Using Pivot
    name: Method 3 Using Pivot
    model: period_over_period
    explore: method3
    type: looker_line
    fields: [method3.date_in_period_date, method3.period, method3.total_sale_price]
    pivots: [method3.period]
    fill_fields: [method3.date_in_period_date]
    filters: {}
    sorts: [method3.period, method3.date_in_period_date]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    x_axis_zoom: true
    y_axis_zoom: true
    defaults_version: 1
    listen:
      Current Date Range: method3.current_date_range
      'Compare To:': method3.compare_to
    row: 3
    col: 0
    width: 24
    height: 7
  - title: Method 3 Using Period Measures Instead of Pivot
    name: Method 3 Using Period Measures Instead of Pivot
    model: period_over_period
    explore: method3
    type: looker_line
    fields: [method3.date_in_period_date, method3.current_period_sales, method3.previous_period_sales]
    fill_fields: [method3.date_in_period_date]
    filters: {}
    sorts: [method3.date_in_period_date]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    x_axis_zoom: true
    y_axis_zoom: true
    defaults_version: 1
    listen:
      Current Date Range: method3.current_date_range
      'Compare To:': method3.compare_to
    row: 10
    col: 0
    width: 24
    height: 7
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"p","align":"start","children":[{"text":"This method allows
      users to select a \"previous period,\" which is a period of the same length
      immediately preceding the current selected period.  This method uses a similar
      approach to Method 2 but, instead of using parameters to select the appropriate
      date "},{"type":"a","url":"https://docs.looker.com/reference/field-params/dimension_group#timeframe_options","children":[{"text":"timeframe"}],"id":1670360759516},{"text":",
      the logic for the correct previous period is defined using "},{"type":"a","url":"https://docs.looker.com/reference/liquid-variables","children":[{"text":"Liquid"}],"id":1670360759516},{"text":".
      See the examples below:"}],"id":1670360759516},{"type":"p","children":[{"text":"\n\n"}],"id":1670360759516}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 0
    width: 24
    height: 3
  filters:
  - name: Current Date Range
    title: Current Date Range
    type: field_filter
    default_value: 1 months
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: period_over_period
    explore: method3
    listens_to_filters: []
    field: method3.current_date_range
  - name: 'Compare To:'
    title: 'Compare To:'
    type: field_filter
    default_value: Period
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: period_over_period
    explore: method3
    listens_to_filters: []
    field: method3.compare_to
