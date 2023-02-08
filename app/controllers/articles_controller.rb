# frozen_string_literal: true

class ArticlesController < ApplicationController
    before_action :set_article, only: %i[show edit update destroy]
    before_action :authenticate_admin!, except: %i[index show]

    # GET /articles
    # GET /articles.json
    def index
        respond_to do |format|
            format.html do
                @super_categories = SuperCategory.related_to :articles
                @super_category = @super_categories.find do |sc|
                    sc.id == params[:super_category_id].to_i
                end || @super_categories.first
            end

            format.json { @articles = Article.published }
        end
    end

    # GET /articles/1
    # GET /articles/1.json
    # Count the number of views of an article. Store in the user's session that
    # the article has been viewed
    def show
        session[:viewed_articles] = [] unless session[:viewed_articles]

        return if @article.id.in? session[:viewed_articles]

        @article.update views: @article.views + 1
        session[:viewed_articles] << @article.id
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

        authenticate_admin! unless @article.published?
    end

    # Only allow a list of trusted parameters through.
    # Convert status to integer
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
                      :image,
                      :status)
              .merge(status: params[:article].fetch(:status, 1).to_i)
    end
end
