# frozen_string_literal: true

class MainController < ApplicationController
    # Only allow published articles. Create a new user to use in subscribe form.
    def main
        @solutions, @projects, @products =
            [Solution, Project, Product].map do |model|
                model.published.select(model.fields_for_cards).order(created_at: :desc).first 4
            end

        @user = User.new
    end

    def contacto
        @message = Message.new
        @user = @message.user
    end

    def nosotros
        @nosotros = true
    end
end
