class MainsController < ApplicationController
  def index
    @articles = Article.all.order(created_at: :desc)

    @proyectos = Proyecto.all.order(created_at: :desc)
  end
end
