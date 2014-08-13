json.array!(@members) do |member|
  json.extract! member, :id, :first_name, :last_name, :user_id, :title, :note
  json.url member_url(member, format: :json)
end
