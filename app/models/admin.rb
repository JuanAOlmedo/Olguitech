# frozen_string_literal: true

class Admin < ApplicationRecord
    # Include devise modules.
    devise :database_authenticatable,
           :registerable,
           :rememberable,
           :validatable,
           :lockable,
           :trackable,
           :confirmable
end
