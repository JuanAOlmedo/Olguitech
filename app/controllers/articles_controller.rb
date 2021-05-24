class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, except: [:index, :show]

  # GET /articles
  # GET /articles.json
  def index
    # order_by = params[:order_by] == "created_at" || params[:order_by] == "title" || params[:order_by] == "title2" ? params[:order_by] : "created_at"
    # order_by = order_by == "title" && I18n.locale == "en" ? "title2" : "title"
    # asc_desc = params[:asc_desc] == "asc" || params[:asc_desc] == "desc" ? params[:asc_desc] : "desc"
    @articles = Article.all.order(created_at: :desc)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    parameters = article_params
    products = parameters[:products]
    parameters.delete(:products)

    categories = parameters[:categories]
    parameters.delete(:categories)

    @article = Article.new(parameters)

    if products != nil
        products.each_with_index do |product, i|
            products[i] = Product.find(product.to_i)
            if !@article.products.include? products[i]
                products[i].articles << @article
            end
        end
    else
        products = []
    end

    if categories != nil
        categories.each_with_index do |category, i|
            categories[i] = Category.find(category.to_i)
            if !@article.categories.include? categories[i]
                categories[i].articles << @article
            end
        end
    else
        categories = []
    end

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Artículo creado exitosamente.' } 
        format.json { render :show, status: :created, location: @article }

        @users = User.all.where(newsletter: true)
    
        @users.each do |user|
          ArticlesMailer.article(user, @article).deliver_later
        end
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
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
        if products != nil
            products.each_with_index do |product, i|
                products[i] = Product.find(product.to_i)
                if !@article.products.include? products[i]
                    products[i].articles << @article
                end
            end
        else
            products = []
        end

        @article.products.each do |product|
            if !products.include? product
                @article.product_referenceables.find_by(product_id: product.id).destroy
            end
        end

        if categories != nil
            categories.each_with_index do |category, i|
                categories[i] = Category.find(category.to_i)
                if !@article.categories.include? categories[i]
                    categories[i].articles << @article
                end
            end
        else
            categories = []
        end

        @article.categories.each do |category|
            if !categories.include? category
                @article.category_categorizables.find_by(category_id: category.id).destroy
            end
        end

        format.html { redirect_to @article, notice: 'Artículo actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Artículo destruido exitosamente.' }
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
      params.require(:article).permit(:title, :title2, :content, :content2, :description, :description2, {:products => []}, {:categories => []}, :image)
    end
end
