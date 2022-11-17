# frozen_string_literal: true

class MainController < ApplicationController
    def main
        @articles = Article.published.order(created_at: :desc).first 4
        @projects = Project.published.order(created_at: :desc).first 4
        @products = Product.published.order(created_at: :desc).first 4

        @user = User.new
    end

    private

    def user_params
        params.require(:user).permit :email
    end
end
