class Tag < ActiveRecord::Base
  validates :body, presence: true, uniqueness: true

  has_many :tag_projects
  has_many :projects, through: :tag_projects
end
