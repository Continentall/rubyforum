class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, uniqueness: true
    validates :name, presence: true, length: {minimum:3}
end
