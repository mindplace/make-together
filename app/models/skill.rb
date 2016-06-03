class Skill < ActiveRecord::Base
  validates :body, presence: true, uniqueness: true

  has_many :skill_users
  has_many :users, through: :skill_users

  def self.build_from_string(string)
    try = string.split(",").map {|skill| Skill.find_or_create_by(body: skill.strip.downcase)}
  end
end
