class User < ActiveRecord::Base
  has_many :posts
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: :true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}


  def User.new_rememember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    def create_remember_token
      self.remember_token = User.digest(User.new_rememember_token)
    end
end
