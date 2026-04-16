class User < ApplicationRecord
  has_secure_password

  with_options dependent: :destroy do
    has_one :profile
  end

  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }
end
