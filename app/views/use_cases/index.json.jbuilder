json.array!(@use_cases) do |use_case|
  json.extract! use_case, :id, :name, :description, :pre_condition, :standard_flow, :alternate_flow, :post_condition, :open_issue, :state
  json.url use_case_url(use_case, format: :json)
end
