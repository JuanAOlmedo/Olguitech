# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
    invisible_captcha only: [:create]
end
