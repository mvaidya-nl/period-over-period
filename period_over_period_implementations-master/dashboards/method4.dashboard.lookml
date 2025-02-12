- dashboard: method_4_compare_multiple_templated_periods
  title: 'Method 4: Compare multiple templated periods'
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: 0eAXcq6UcunrCWrWL9CnZn
  elements:
  - title: Method 4
    name: Method 4
    model: period_over_period
    explore: method4
    type: looker_line
    fields: [method4.date_in_period_month_name, method4.period, method4.total_sale_price]
    pivots: [method4.period]
    filters: {}
    sorts: [method4.period]
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
    series_types: {}
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_fields: []
    listen:
      Current Date Range: method4.current_date_range
      Number of Periods: method4.comparison_periods
      'Compare To:': method4.compare_to
    row: 2
    col: 0
    width: 24
    height: 9
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"p","children":[{"text":"Sometimes you may want to compare
      more than just the current and previous periods. By adding a new parameter to
      choose the number of periods to compare, we can allow this; however, it does
      add a lot of verbosity to the model.","fontSize":"14px","backgroundColor":"rgb(255,
      255, 255)","color":"rgb(32, 33, 36)"},{"text":"\n\n"}]}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 0
    width: 24
    height: 2
  filters:
  - name: Current Date Range
    title: Current Date Range
    type: field_filter
    default_value: 6 months
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: period_over_period
    explore: method4
    listens_to_filters: []
    field: method4.current_date_range
  - name: Number of Periods
    title: Number of Periods
    type: field_filter
    default_value: '4'
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: period_over_period
    explore: method4
    listens_to_filters: []
    field: method4.comparison_periods
  - name: 'Compare To:'
    title: 'Compare To:'
    type: field_filter
    default_value: Year
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: period_over_period
    explore: method4
    listens_to_filters: []
    field: method4.compare_to
