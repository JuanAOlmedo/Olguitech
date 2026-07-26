# frozen_string_literal: true

class MainController < ApplicationController
    include Throttle

    # GET /
    def main
        @solutions, @projects, @products =
            [Solution, Project, Product].map! do |model|
                model.published
                     .select(model.fields_for_cards)
                     .order(created_at: :desc)
                     .includes_image
                     .limit(4)
            end

        # Crear usuario para usar en formulario de suscripción
        @user = User.new
    end

    # GET /contacto
    def contacto
        @user = User.new
        @message = @user.messages.build
        @show_form = !block_contact?
    end

    # GET /nosotros
    def nosotros
        @nosotros = true
    end
end
