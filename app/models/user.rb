class User < ApplicationRecord
  has_many :calendar
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def update_time(after_user)
    self.update(squat_update: Time.now) if after_user.squat != self.squat
    self.update(benchpress_update: Time.now) if after_user.benchpress != self.benchpress
    self.update(deadlift_update: Time.now) if after_user.deadlift != self.deadlift 
  end
end
