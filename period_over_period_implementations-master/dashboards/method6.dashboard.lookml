- dashboard: method_6_compare_two_arbitrary_date_ranges
  title: 'Method 6: Compare two arbitrary date ranges'
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: 4XVwUrW31OtxtyEhNve3bN
  elements:
  - title: Method 6
    name: Method 6
    model: period_over_period
    explore: method6
    type: looker_line
    fields: [method6.period_selected, method6.total_sale_price, method6.days_from_first_period]
    pivots: [method6.period_selected]
    filters: {}
    sorts: [method6.period_selected, method6.days_from_first_period]
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
    point_style: circle_outline
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
        reverse: false
    x_axis_zoom: true
    y_axis_zoom: true
    defaults_version: 1
    listen:
      First Period Filter: method6.first_period_filter
      Second Period Filter: method6.second_period_filter
      First or second period: method6.period_selected
    row: 3
    col: 0
    width: 24
    height: 8
  - title: Percentage Change
    name: Percentage Change
    model: period_over_period
    explore: method6
    type: single_value
    fields: [method6.sales_pop_change]
    filters: {}
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    point_style: circle_outline
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
      options:
        steps: 5
        reverse: false
    defaults_version: 1
    series_types: {}
    listen:
      First Period Filter: method6.first_period_filter
      Second Period Filter: method6.second_period_filter
      First or second period: method6.period_selected
    row: 11
    col: 0
    width: 24
    height: 3
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"p","children":[{"text":"Sometimes an analysis requires a
      comparison between two arbitrary periods, not including the current period.
      This is relevant for use cases such as web analytics, where, for example, the
      number of registrations for an upcoming webinar needs to be compared to a previous
      webinar from six months ago. The challenge is that the date ranges might have
      a different number of days, so the periods need to be aligned based on their
      start day.","fontSize":"14px","backgroundColor":"rgb(255, 255, 255)","color":"rgb(32,
      33, 36)"},{"text":"\n\n"}]}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 0
    width: 24
    height: 3
  filters:
  - name: First Period Filter
    title: First Period Filter
    type: field_filter
    default_value: 2022/05/01 to 2022/06/01
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: period_over_period
    explore: method6
    listens_to_filters: []
    field: method6.first_period_filter
  - name: Second Period Filter
    title: Second Period Filter
    type: field_filter
    default_value: 2022/06/01 to 2022/07/01
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: period_over_period
    explore: method6
    listens_to_filters: []
    field: method6.second_period_filter
  - name: First or second period
    title: First or second period
    type: field_filter
    default_value: "-NULL"
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: period_over_period
    explore: method6
    listens_to_filters: []
    field: method6.period_selected
