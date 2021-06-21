json.users do
  json.array! @users, :id, :name, :email, :profile
end

# json.meta do
#   json.partial! 'shared/pagination', pagination: @loading_service.pagination
# end