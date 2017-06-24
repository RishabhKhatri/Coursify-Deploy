class Teacher < ApplicationRecord
  has_many :courses, dependent: :destroy
  belongs_to :institute

  attr_accessor :activation_token, :reset_token

  before_save :downcase_email

  before_create :create_activation_digest

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_CONTACT_REGEX = /\A[789]\d{9}\z/

  mount_uploader :picture, PictureUploader

  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :contact, presence: true, length: { maximum: 10 }, uniqueness: true, format: { with: VALID_CONTACT_REGEX }
  validates :expertise, presence: true, length: { maximum: 250 }
  validates :email, presence: true, length: { maximum: 250 },
            format: { with: VALID_EMAIL_REGEX  }, uniqueness: { case_sensitive: false}
  before_save { self.email = email.downcase }
  validate :picture_size
  validates :institute_id, presence: true, allow_nil: true

  has_secure_password

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def authenticated?(activation_token)
    digest = self.send("activation_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(activation_token)
  end

  def password_authenticated?(reset_token)
    digest = self.send("reset_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(reset_token)
  end

  def create_reset_digest
    self.reset_token = Teacher.new_token
    update_attribute(:reset_digest,  Teacher.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    TeacherMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at<2.hours.ago
  end

  private

    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
      self.activation_token  = Teacher.new_token
      self.activation_digest = Teacher.digest(activation_token)
    end

    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
