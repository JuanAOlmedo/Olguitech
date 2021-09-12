class Admin < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable,
           :registerable,
           :rememberable,
           :validatable,
           :lockable,
           :confirmable #, password_length: 10..128
end
