json.array!(@slices) do |slice|
  json.extract! slice, :id, :use_case_id, :priority, :workflow_state, :estimate, :release_id, :order_priority
  json.url slice_url(slice, format: :json)
end
