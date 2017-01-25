class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :posts, through: :taggings

  def self.has_post
    joins(:posts).uniq
  end

end
