if user_signed_in?
  json.user do
    json.(current_user, :id, :email, :username, :current_sign_in_at, :last_sign_in_at, :posts)
  end
end
