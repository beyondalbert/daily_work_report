class Dailynote < ActiveRecord::Base
  belongs_to :user
  belongs_to :weeklynote
end
