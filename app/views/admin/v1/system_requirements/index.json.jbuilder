json.system_requirements do
  json.array! @system_requirements, :id, :os, :name, :storage, :processor, :memory, :video_board
end