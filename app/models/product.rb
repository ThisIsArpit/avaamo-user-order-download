class Product < ApplicationRecord
    validates :code, presence: true, uniqueness: { message: "This code is already taken. Please choose another one - %{value}" }
    has_many :order_details
end
