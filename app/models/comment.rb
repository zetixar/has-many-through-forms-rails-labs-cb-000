class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def user_attributes=(user_attribute)
    self.user = User.find_or_create_by(user_attribute) unless user_attribute[:username].empty?
  end
end
