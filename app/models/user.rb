class User < ActiveRecord::Base
  has_many :projects

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def image
  end

  def visible_name
    "#{first_name} #{last_name[0]}."
  end
end
