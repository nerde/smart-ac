class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :registerable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :lockable, :trackable
end
