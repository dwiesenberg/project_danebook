class Profile < ApplicationRecord

  belongs_to :user, inverse_of: :profile

  validates :birthday, inclusion: { in: (100.years.ago..Date.tomorrow), message: "must have been born within the last 100 years"}
  validates :college, length: { maximum: 50 }
  validates :hometown, length: { maximum: 50 }
  validates :currently_lives, length: { maximum: 50 }
  validates :telephone, length: { in: 9..20 }, allow_blank: true
  validates :words_to_live_by, length: { maximum: 500 }
  validates :about_me, length: { maximum: 1000 }
  validates :sex, length: { maximum: 10 }

  has_attached_file :photo, 
                    default_url: 'user_silhouette_generic.gif', 
                    styles: { profile_size: "200x200^"}
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
  has_attached_file :background
  validates_attachment_content_type :background, content_type: /\Aimage\/.*\z/

  def name
    user = self.user
    user['first_name'] + ' ' + user['last_name']
  end
end
