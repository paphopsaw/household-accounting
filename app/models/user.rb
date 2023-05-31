class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :generate_auth_token, on: [:create]

  def generate_auth_token(force = false)
    self.auth_token ||= SecureRandom.urlsafe_base64

    self.auth_token = SecureRandom.urlsafe_base64 if force
  end

  def jwt(exp = 1.days.from_now)
    payload = { exp: exp.to_i, auth_token: self.auth_token }
    JWT.encode payload, Rails.application.credentials.secret_key_base, 'HS256'
  end
end
