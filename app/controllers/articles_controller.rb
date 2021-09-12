class ArticlesController < ApplicationController
    before_action :set_article, only: %i[show edit update destroy]
    before_action :authenticate_admin!, except: %i[index show]

    # GET /articles
    # GET /articles.json
    def index
        order_by =
            if params[:order_by] == 'created_at' ||
                   params[:order_by] == 'updated_at' ||
                   params[:order_by] == 'title' ||
                   params[:order_by] == 'categories'
                params[:order_by]
            else
                'categories'
            end
        order_by =
            order_by == 'title' && I18n.locale == :en ? 'title2' : order_by
        asc_desc =
            if params[:asc_desc] == 'asc' || params[:asc_desc] == 'desc'
                params[:asc_desc]
            else
                'desc'
            end

        if order_by == 'categories'
            @categories = Category.all.order(created_at: :desc)
        else
            @articles = Article.all.order(order_by => asc_desc)
        end

        @uncategorized = []

        Article.all.each do |article|
            @uncategorized << article if article.categories.empty?
        end
    end

    # GET /articles/1
    # GET /articles/1.json
    def show; end

    # GET /articles/new
    def new
        @article = Article.new
    end

    # GET /articles/1/edit
    def edit; end

    # POST /articles
    # POST /articles.json
    def create
        parameters = article_params
        products = parameters[:products]
        parameters.delete(:products)

        categories = parameters[:categories]
        parameters.delete(:categories)

        @article = Article.new(parameters)

        @article.change_categories_and_products(categories, products)

        respond_to do |format|
            if @article.save
                format.html do
                    redirect_to @article,
                                notice: 'Artículo creado exitosamente.'
                end
                format.json do
                    render :show, status: :created, location: @article
                end

                @users = User.all.where(newsletter: true)

                @users.each do |user|
                    ArticlesMailer.article(user, @article).deliver_later
                end
            else
                format.html { render :new }
                format.json do
                    render json: @article.errors, status: :unprocessable_entity
                end
            end
        end
    end

    # PATCH/PUT /articles/1
    # PATCH/PUT /articles/1.json
    def update
        parameters = article_params
        products = parameters[:products]
        parameters.delete(:products)

        categories = parameters[:categories]
        parameters.delete(:categories)

        respond_to do |format|
            if @article.update(parameters)
                @article.change_categories_and_products(categories, products)

                format.html do
                    redirect_to @article,
                                notice: 'Artículo actualizado exitosamente.'
                end
                format.json { render :show, status: :ok, location: @article }
            else
                format.html { render :edit }
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
                            notice: 'Artículo destruido exitosamente.'
            end
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_article
        @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
        params
            .require(:article)
            .permit(
                :title,
                :title2,
                :content,
                :content2,
                :description,
                :description2,
                { products: [] },
                { categories: [] },
                :image,
            )
    end
end
