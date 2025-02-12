- dashboard: method_5_compare_current_period_with_another_arbitrary_period
  title: 'Method 5: Compare current period with another arbitrary period'
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: X6BLweNx4bsR4ZN1LpyBSQ
  elements:
  - title: Method 5
    name: Method 5
    model: period_over_period
    explore: method5
    type: looker_column
    fields: [method5.period, method5.total_sale_price]
    filters: {}
    sorts: [method5.total_sale_price desc 0]
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    series_labels: {}
    show_dropoff: true
    defaults_version: 1
    show_null_points: true
    interpolation: linear
    hidden_fields: []
    hidden_points_if_no: []
    listen:
      Current Date Range: method5.current_date_range
      'Previous Date Range (Custom):': method5.previous_date_range
    row: 2
    col: 0
    width: 24
    height: 12
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"p","children":[{"text":"Sometimes you don''t want to compare
      the current period to exactly the previous period. Adding another filter to
      Method 3 allows users to compare the current period with any other arbitrary
      date range.","fontSize":"14px","backgroundColor":"rgb(255, 255, 255)","color":"rgb(32,
      33, 36)"},{"text":"\n\n"}]}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 0
    width: 24
    height: 2
  filters:
  - name: Current Date Range
    title: Current Date Range
    type: field_filter
    default_value: 2 months
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: period_over_period
    explore: method5
    listens_to_filters: []
    field: method5.current_date_range
  - name: 'Previous Date Range (Custom):'
    title: 'Previous Date Range (Custom):'
    type: field_filter
    default_value: 3 months ago for 1 days
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: period_over_period
    explore: method5
    listens_to_filters: []
    field: method5.previous_date_range
