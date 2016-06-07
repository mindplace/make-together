module UsersHelper
  def is_following?(user)
    current_user.followed_users.include?(user)
  end
end