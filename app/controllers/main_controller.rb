# frozen_string_literal: true

class MainController < ApplicationController
    def main
        @articles, @projects, @products = [Article, Project, Product].map do |model|
            model.published.select(model.fields_for_cards).order(created_at: :desc).first 4
        end

        @user = User.new
    end
end
