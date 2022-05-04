if @user
  json.(@user, :id, :username)
  json.followers @followers
  json.following @following
  json.is_following @is_following
  json.post_count @user.posts.count
end
