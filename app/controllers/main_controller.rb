# frozen_string_literal: true

class MainController < ApplicationController
    # GET /
    def main
        @solutions, @projects, @products =
            [Solution, Project, Product].map! do |model|
                # Cachear consulta
                Rails.cache.fetch("#{model.model_name.cache_key}/main", expires_in: 2.hours) do
                    model.published
                         .select(model.fields_for_cards)
                         .order(created_at: :desc)
                         .includes_image
                         .first(4)
                end
            end

        # Crear usuario para usar en formulario de suscripción
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
