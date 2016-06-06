class User < ActiveRecord::Base
  has_many :projects
  has_many :skill_users
  has_many :skills, through: :skill_users
  has_many :favorites
  has_many :reviews
  has_many :conversations, foreign_key: :sender_id

  has_secure_password
  validates :email, :password, presence: true
  validates :email, uniqueness: true
  validate :is_valid_email, on: :create

  def is_valid_email
    unless email.match(/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
      self.errors[:email].push("Not a valid email address: should resemble 'user@example.com'")
    end
  end

  def visible_name
    "#{first_name.capitalize} #{last_name[0].upcase}."
  end

  def avg_star_rating
    self.reviews.length != 0 ?
    self.reviews.sum(:rating) / self.reviews.length :
    0
  end

  def text_rating
    avg_star_rating == 0 ? "Not yet rated" : "Rated #{avg_star_rating} Stars"
  end


  def has_favorited(project)
    favorites.any?{|fave| fave.project_id == project.id}
  end
end
