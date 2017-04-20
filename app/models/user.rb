class User < ActiveRecord::Base
  has_secure_password

  has_many :friendships, foreign_key: "user_id"
  has_many :friends, through: :friendships

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :name, presence: true, length: { in: 2..20 }
  # validates :state, length: { is: 2}
  validates :password, length: { minimum: 7}
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

  # creating a custom instance method. self refers to the ActiveRecord object
  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  # this callback will run before saving on create and update
  before_save :downcase_email

  # this callback will run after creating a new user
  after_create :successfully_created

  # this callback will run after updating an existing user
  after_update :successfully_updated

  private
    def downcase_email
      self.email.downcase!
    end

    def successfully_created
      puts "Successfully created a new user"
    end
    def successfully_updated
      puts "Successfully updated a existing user"
    end

end
