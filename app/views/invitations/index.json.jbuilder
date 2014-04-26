json.array!(@invitations) do |invitation|
  json.extract! invitation, :id, :user_id, :folder_id
  json.url invitation_url(invitation, format: :json)
end
