class FlaggedProject < ActiveRecord::Base

  belongs_to :flagging_user, class_name: "User"
  belongs_to :project
end
