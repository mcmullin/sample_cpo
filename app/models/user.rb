# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  email             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  password_digest   :string(255)
#  remember_token    :string(255)
#  admin             :boolean          default(FALSE)
#  confirmation_code :string(255)
#  activated         :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  #include AASM

  #scope :active_users, -> { where(aasm_state: "active") }
  attr_accessible :name, :email, :password, :password_confirmation, :activated

=begin
  aasm do
    state :inactive, initial: true
    state :active

    event :activate do #, before: :process_purchase do
      transitions from: :inactive, to: :active #, guard: :valid_payment?
    end

    event :deactivate do
      transitions from: :active, to: :inactive
    end
  end
=end

  has_secure_password
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  # Naturally, Rails allows us to override the default, in this case using the :source parameter (Listing 11.10), 
  # which explicitly tells Rails that the source of the followed_users array is the set of followed ids.
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  # Note that we actually have to include the class name for this association ... because otherwise Rails would 
  # look for a ReverseRelationship class, which doesn’t exist. 
  has_many :followers, through: :reverse_relationships, source: :follower
  # It’s also worth noting that we could actually omit the :source key in this case, using simply:
  # "has_many :followers, through: :reverse_relationships" since, in the case of a :followers attribute, 
  # Rails will singularize “followers” and automatically look for the foreign key follower_id in this case.

  before_save { email.downcase! } # equivalent to "before_save { |user| user.email = email.downcase }"
  before_save :create_remember_token
  before_save :create_confirmation_code

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id) # equivalent to "self.relationships.create!(...)"
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def create_confirmation_code
      self.confirmation_code = SecureRandom.urlsafe_base64
    end
end
