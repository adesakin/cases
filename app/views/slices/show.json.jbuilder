json.extract! @slice, :id, :priority, :workflow_state, :estimate, :release_id, :order_priority, :created_at, :updated_at

json.steps @slice.steps, :id, :full_desc
