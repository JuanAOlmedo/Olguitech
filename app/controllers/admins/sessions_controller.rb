# frozen_string_literal: true

module Admins
    class SessionsController < Devise::SessionsController
        before_action :validate_turnstile, only: [:create]

        private

        def validate_turnstile
            redirect_to root_path, status: :see_other unless valid_turnstile?
        end
    end
end
