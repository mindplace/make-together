class User < ActiveRecord::Base
  before_action :set_user, except: {:index, :new, :create}
  has_many :projects

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private
  def set_user
    @user = User.find_by(id: params[:id])
  end
end
