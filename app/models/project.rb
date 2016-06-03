class Project < ActiveRecord::Base
  before_save :set_expiration, :set_tagline

  belongs_to :user
  has_many :favorites

  validates :title, :description, presence: true



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
