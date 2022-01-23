# frozen_string_literal: true

class ArticlesController < ApplicationController
    before_action :set_article, only: %i[show edit update destroy]
    before_action :authenticate_admin!, except: %i[index show]

    # GET /articles
    # GET /articles.json
    def index
        respond_to do |format|
            format.html do
                ordered =
                    Article.ordered(params[:order_by], params[:asc_desc])

                @categories = ordered[0]
                @articles = ordered[1]

                @uncategorized = Article.uncategorized
            end

            format.json { @articles = Article.all }
        end
    end

    # GET /articles/1
    # GET /articles/1.json
    def show
        viewed_articles = session[:viewed_articles]

        return unless viewed_articles.nil? || !@article.id.in?(viewed_articles)

        @article.views += 1

        session[:viewed_articles] = [] if viewed_articles.nil?
        session[:viewed_articles] << @article.id

        @article.save
    end

    # GET /articles/new
    def new
        @article = Article.new
    end

    # GET /articles/1/edit
    def edit; end

    # POST /articles
    # POST /articles.json
    def create
        @article = Article.new(article_params)

        respond_to do |format|
            if @article.save
                format.html do
                    redirect_to @article,
                                notice: 'Artículo creado exitosamente.'
                end
                format.json do
                    render :show, status: :created, location: @article
                end
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json do
                    render json: @article.errors, status: :unprocessable_entity
                end
            end
        end
    end

    # PATCH/PUT /articles/1
    # PATCH/PUT /articles/1.json
    def update
        respond_to do |format|
            if @article.update(article_params)
                format.html do
                    redirect_to @article,
                                notice: 'Artículo actualizado exitosamente.'
                end
                format.json { render :show, status: :ok, location: @article }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json do
                    render json: @article.errors, status: :unprocessable_entity
                end
            end
        end
    end

    # DELETE /articles/1
    # DELETE /articles/1.json
    def destroy
        @article.destroy
        respond_to do |format|
            format.html do
                redirect_to articles_url,
                            notice: 'Artículo destruido exitosamente.',
                            status: :see_other
            end
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_article
        @article = Article.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
        params.require(:article)
              .permit(:title,
                      :title2,
                      :content,
                      :content2,
                      :description,
                      :description2,
                      { product_ids: [] },
                      { category_ids: [] },
                      :image)
    end
end
