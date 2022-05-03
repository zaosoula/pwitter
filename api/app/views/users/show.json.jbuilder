if @user
  json.(@user, :id, :email, :username, :current_sign_in_at, :last_sign_in_at, :posts)
  json.is_following @is_following
  json.followers @followers
  json.following @following
end
