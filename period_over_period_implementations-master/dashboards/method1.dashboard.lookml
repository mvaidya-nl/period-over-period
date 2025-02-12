- dashboard: method_1_use_lookers_native_date_dimension_groups
  title: 'Method 1: Use Looker''s native date dimension groups'
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: TO36CUhKTjQdVmLybPSXFC
  elements:
  - title: Standard Looker Year-Over-Year Pivot
    name: Standard Looker Year-Over-Year Pivot
    model: period_over_period
    explore: order_items
    type: looker_line
    fields: [order_items.created_year, order_items.total_sale_price, order_items.created_month_name,
      order_items.created_month_num]
    pivots: [order_items.created_year]
    fill_fields: [order_items.created_year]
    filters:
      order_items.created_year: 2 years
    sorts: [order_items.created_year, order_items.created_month_num]
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
    hidden_fields: [order_items.created_month_num]
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
    listen: {}
    row: 2
    col: 0
    width: 20
    height: 6
  - title: Year-Over-Year Pivot with YTD Filter
    name: Year-Over-Year Pivot with YTD Filter
    model: period_over_period
    explore: method1
    type: looker_line
    fields: [method1.created_month_name, method1.total_sale_price, method1.created_year]
    pivots: [method1.created_year]
    fill_fields: [method1.created_month_name]
    filters:
      method1.year_to_date: 'Yes'
    sorts: [method1.created_year, method1.created_month_name]
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
      Created Year: method1.created_year
      Display only Year to Date: method1.YTD_selection
    row: 8
    col: 0
    width: 20
    height: 6
  - title: Month-over-Month with MTD Filter
    name: Month-over-Month with MTD Filter
    model: period_over_period
    explore: method1
    type: looker_line
    fields: [method1.created_month_name, method1.created_day_of_month, method1.total_sale_price]
    pivots: [method1.created_month_name]
    fill_fields: [method1.created_day_of_month]
    filters:
      method1.month_to_date: 'Yes'
    sorts: [method1.created_month_name, method1.total_sale_price desc 0]
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
    x_axis_zoom: true
    y_axis_zoom: true
    series_types: {}
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Created Year: method1.created_year
      Display only Month to Date: method1.MTD_selection
      Created Month: method1.created_month
    row: 19
    col: 0
    width: 20
    height: 5
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"p","children":[{"text":"Standard Looker Pivot on Period
      is available without any additional LookML.  Standard Pivots with added filters
      available in Method_1 allow comparisons with matching period-to-date ranges.  "}]}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 0
    width: 20
    height: 2
  - title: Standard Looker Month-over-Month Pivot
    name: Standard Looker Month-over-Month Pivot
    model: period_over_period
    explore: method1
    type: looker_line
    fields: [method1.created_month_name, method1.created_day_of_month, method1.total_sale_price]
    pivots: [method1.created_month_name]
    fill_fields: [method1.created_day_of_month]
    filters: {}
    sorts: [method1.created_month_name, method1.total_sale_price desc 0]
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
    x_axis_zoom: true
    y_axis_zoom: true
    series_types: {}
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Created Year: method1.created_year
      Display only Month to Date: method1.MTD_selection
      Created Month: method1.created_month
    row: 14
    col: 0
    width: 20
    height: 5
  filters:
  - name: Created Year
    title: Created Year
    type: field_filter
    default_value: 2 years
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: period_over_period
    explore: method1
    listens_to_filters: []
    field: method1.created_year
  - name: Display only Year to Date
    title: Display only Year to Date
    type: field_filter
    default_value: YTD
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: period_over_period
    explore: method1
    listens_to_filters: []
    field: method1.YTD_selection
  - name: Created Month
    title: Created Month
    type: field_filter
    default_value: 2 month
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: period_over_period
    explore: order_items
    listens_to_filters: []
    field: order_items.created_month
  - name: Display only Month to Date
    title: Display only Month to Date
    type: field_filter
    default_value: 'No'
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    model: period_over_period
    explore: method1
    listens_to_filters: []
    field: method1.MTD_selection
