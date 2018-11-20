class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
  validates_length_of :password, minimum: 6, allow_blank: true
  validates :email, presence: true
  has_secure_password validations: false

  has_many :tasks
end
