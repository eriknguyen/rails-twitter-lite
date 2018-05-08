class User < ApplicationRecord
  # create a virtual attribute which is not stored in the db
  attr_accessor :remember_token

  # create association with micropost
  has_many :microposts, dependent: :destroy

  # create association with relationship
  has_many :active_relationships, class_name: "Relationship",
           foreign_key: "follower_id",
           dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  # basic setup for User model
  before_save {self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sentitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  # Defines a proto-feed
  # see "following users" for the full implementation
  def feed
    Micropost.where("user_id = ?", id)
  end

  ### Methods
  class << self
    # returns the hash digest of the given string.
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # returns a random token
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # create a remember_token for user and store the remember_digest in db
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Return true if the given token matches the remember_digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # forget a user
  def forget
    update_attribute(:remember_digest, nil)
  end

end
