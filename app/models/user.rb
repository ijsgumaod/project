class User < ApplicationRecord
  authenticates_with_sorcery!
  enum role: [:admin, :user]

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  validates :password, length: {minimum: 3}
  validates :password, confirmation: true
  validates :email, uniqueness: true, email_format: { message: 'has invalid format'}
  #validates_processing_of :image
  validate :image_size_validation

  has_many :posts, dependent: :destroy

  mount_uploader :avatar, ImageUploader

  private
    def image_size_validation
      errors[:avatar] << "should be less than 5mb" if avatar.size > 5.megabytes
    end
end
