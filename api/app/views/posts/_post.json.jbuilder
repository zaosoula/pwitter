json.extract! post, :id, :content, :created_at
json.user post.user, :id, :username

json.like_count post.likes.count
json.is_liked post.liking_users.pluck(:id).include? current_user.id
