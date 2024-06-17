require 'csv'

class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
    validates :user_name, presence: true, uniqueness: { message: "This email address is already taken. Please choose another one - %{value}" }
    has_many :order_details
end
