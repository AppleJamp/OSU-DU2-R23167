json.extract! note, :id, :title, :content, :group_id, :status, :created_at, :updated_at
json.url note_url(note, format: :json)
