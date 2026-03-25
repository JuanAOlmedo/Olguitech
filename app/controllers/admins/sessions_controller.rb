# frozen_string_literal: true

module Admins
    class SessionsController < Devise::SessionsController
        invisible_captcha only: [:create]
    end
end
