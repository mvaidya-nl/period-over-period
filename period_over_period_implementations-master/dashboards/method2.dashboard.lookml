- dashboard: method_2_allow_users_to_choose_periods_with_parameters
  title: 'Method 2: Allow users to choose periods with parameters'
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: eaRH1fBQsqqyDSrR1sKQMe
  elements:
  - title: Method 2
    name: Method 2
    model: period_over_period
    explore: method2
    type: looker_line
    fields: [method2.total_sale_price, method2.pop_row, method2.pop_pivot]
    pivots: [method2.pop_pivot]
    filters:
      method2.to_date: 'Yes'
    sorts: [method2.pop_pivot, method2.pop_row]
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
    series_types: {}
    series_colors: {}
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Choose Grouping (Rows): method2.choose_breakdown
      Choose Comparison (Pivot): method2.choose_comparison
      Created Year: method2.created_year
      Display only Period to Date: method2.to_date_selection
    row: 2
    col: 0
    width: 24
    height: 12
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"p","children":[{"text":"Method 2 provides a more guided
      Explore experience and allows ","fontSize":"14px","backgroundColor":"rgb(255,
      255, 255)","color":"rgb(32, 33, 36)"},{"type":"a","url":"https://help.looker.com/hc/en-us/articles/360001288628-Creating-a-Dashboard-Only-User","children":[{"text":"view-only"}],"id":1670359472533},{"text":" users
      to define on-the-fly period-over-period analyses using dashboard filters","fontSize":"14px","backgroundColor":"rgb(255,
      255, 255)","color":"rgb(32, 33, 36)"},{"text":"\n\n"}]}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 0
    width: 24
    height: 2
  filters:
  - name: Choose Comparison (Pivot)
    title: Choose Comparison (Pivot)
    type: field_filter
    default_value: Month
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: period_over_period
    explore: method2
    listens_to_filters: []
    field: method2.choose_comparison
  - name: Choose Grouping (Rows)
    title: Choose Grouping (Rows)
    type: field_filter
    default_value: DOM
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: period_over_period
    explore: method2
    listens_to_filters: []
    field: method2.choose_breakdown
  - name: Created Year
    title: Created Year
    type: field_filter
    default_value: 2 months
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: period_over_period
    explore: method2
    listens_to_filters: []
    field: method2.created_year
  - name: Display only Period to Date
    title: Display only Period to Date
    type: field_filter
    default_value: MTD
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: period_over_period
    explore: method2
    listens_to_filters: []
    field: method2.to_date_selection
