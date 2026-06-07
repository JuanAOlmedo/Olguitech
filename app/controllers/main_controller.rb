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
        @show_form = contact_count < 10
    end

    # GET /nosotros
    def nosotros
        @nosotros = true
    end

    private

    def contact_count
        bucket = Time.now.to_i / 1.hour.to_i

        Rails.cache.fetch("contactos_#{bucket}", expires_in: 1.hour) { 0 }
    end
end
