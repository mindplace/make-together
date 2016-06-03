class Tag < ActiveRecord::Base
  validates :body, presence: true, uniqueness: true

  has_many :tag_projects
  has_many :projects, through: :tag_projects

  def self.build_from_string(string)
    try = string.split(",").map {|tag| Tag.find_or_create_by(body: tag.strip.downcase)}
  end

end
