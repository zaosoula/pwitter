if @user
  json.(@user, :id, :email, :username, :current_sign_in_at, :last_sign_in_at, :posts)
end
