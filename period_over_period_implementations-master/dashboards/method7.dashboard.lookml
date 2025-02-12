- dashboard: method_7_arbitrary_period_and_directly_previous_period__compare_any_period_with_the_previous_preceding_period_of_the_same_length
  title: 'Method 7: Arbitrary Period and Directly Previous Period - Compare Any Period
    with the Previous Preceding Period of the Same Length'
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: B0ria1frb5R86OwvRRsRjQ
  elements:
  - title: Method 7
    name: Method 7
    model: period_over_period
    explore: method7
    type: single_value
    fields: [method7.timeframes, method7.total_sale_price]
    pivots: [method7.timeframes]
    fill_fields: [method7.timeframes]
    filters: {}
    sorts: [method7.timeframes]
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: Total Sale Price
    value_format: "#,###"
    comparison_label: Previous Period
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#62bad9",
        font_color: !!null '', color_application: {collection_id: belding, palette_id: belding-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    hidden_pivots: {}
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
    defaults_version: 1
    series_types: {}
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    listen:
      Date Filter: method7.date_filter
    row: 3
    col: 0
    width: 8
    height: 6
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '[{"type":"p","children":[{"text":"This method enables users to select
      any date range and compare it to the previous period of the same length. For
      example, if a user selects a range of 12 days in the past, the data will be
      compared to 12 days directly preceding that range. This is particularly useful
      for ","fontSize":"14px","backgroundColor":"rgb(255, 255, 255)","color":"rgb(32,
      33, 36)"},{"type":"a","url":"https://docs.looker.com/exploring-data/visualizing-query-results/single-value-options","children":[{"text":"single
      value visualization"}],"id":1671579437481},{"text":" comparisons.","fontSize":"14px","backgroundColor":"rgb(255,
      255, 255)","color":"rgb(32, 33, 36)"},{"text":"\n\n"}]}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 0
    width: 18
    height: 3
  filters:
  - name: Date Filter
    title: Date Filter
    type: field_filter
    default_value: 1 years
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: period_over_period
    explore: method7
    listens_to_filters: []
    field: method7.date_filter
