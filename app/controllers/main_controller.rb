# frozen_string_literal: true

class MainController < ApplicationController
    # Only allow published articles. Create a new user to use in subscribe form.
    # GET /
    def main
        @solutions, @projects, @products =
            [Solution, Project, Product].map! do |model|
                model.published
                     .select(model.fields_for_cards)
                     .order(created_at: :desc)
                     .includes(image_attachment: { blob: :variant_records })
                     .first(4)
            end

        @user = User.new
    end

    # GET /contacto
    def contacto
        @user = User.new
        @message = @user.messages.build
    end

    # GET /nosotros
    def nosotros
        @nosotros = true
    end
end
