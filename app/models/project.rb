class Project < ActiveRecord::Base
  before_save :set_expiration, :set_tagline

  belongs_to :user
  has_many :favorites

  validates :title, :description, presence: true

  has_many :tag_projects
  has_many :tags, through: :tag_projects

  def date
    expiration.strftime("%D")
  end

  def is_flagged
    FlaggedProject.find_by(project_id: id)
  end

  def blurb
    description.split[0..20].join(" ") + "..."
  end
  private

  def set_expiration
    if !self.expiration
      self.expiration = Date.today + 7.days
    end
  end

  def set_tagline
    if self.tagline.nil?
      self.tagline = "Seeking collaborators"
    end
  end


end
