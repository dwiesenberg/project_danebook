class User < ApplicationRecord
  has_secure_password
  
  has_one :profile, dependent: :destroy, inverse_of: :user

  accepts_nested_attributes_for :profile, reject_if: :all_blank

  validates :first_name, 
            presence: true, 
            length: { maximum: 15 }
  validates :last_name, 
            presence: true, 
            length: { maximum: 15 }
  validates :email, 
            presence: true, 
            length: { maximum: 25 }, 
            uniqueness: true
  validates :password, 
            length: { minimum: 6, maximum: 15 }, 
            allow_nil: true

  after_create :queue_welcome_email

  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end

  def name
    self.first_name + ' ' + self.last_name
  end

  private
    def queue_welcome_email
      UserMailer.welcome(self).deliver_later
    end

end
