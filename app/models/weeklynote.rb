class Weeklynote < ActiveRecord::Base
  belongs_to :user
  has_many :dailynotes, :dependent => :delete_all
  
  validate :validate_start_date
  
  def validate_start_date
    if start_date.wday != 1
      errors.add(:start_date, "开始时间只能是星期一！")
    end
  end
end
