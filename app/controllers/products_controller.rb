class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, except: [:index, :show]

  # GET /products or /products.json
  def index
    order_by = params[:order_by] == "created_at" || params[:order_by] == "updated_at" || params[:order_by] == "title" || params[:order_by] == "categories" ? params[:order_by] : "categories"
    order_by = order_by == "title" && I18n.locale == :en ? "title2" : order_by
    asc_desc = params[:asc_desc] == "asc" || params[:asc_desc] == "desc" ? params[:asc_desc] : "desc"

    if order_by == "categories"
        @categories = Category.all.order(created_at: :desc)
    else 
        @products = Product.all.order(order_by => asc_desc) 
    end
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    parameters = product_params
    articles = parameters[:articles]
    parameters.delete(:articles)

    proyectos = parameters[:proyectos]
    parameters.delete(:proyectos)

    categories = parameters[:categories]
    parameters.delete(:categories)

    @product = Product.new(parameters)

    if articles != nil
        articles.each_with_index do |article, i|
            articles[i] = Article.find(article.to_i)
            @product.articles << articles[i]
        end
    else
        articles = []
    end

    if proyectos != nil
        proyectos.each_with_index do |article, i|
            proyectos[i] = Proyecto.find(article.to_i)
            @product.proyectos << proyectos[i]
        end
    else
        proyectos = []
    end

    if categories != nil
        categories.each_with_index do |category, i|
            categories[i] = Category.find(category.to_i)
            if !@product.categories.include? categories[i]
                categories[i].products << @product
            end
        end
    else
        categories = []
    end

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    parameters = product_params
    articles = parameters[:articles]
    parameters.delete(:articles)

    proyectos = parameters[:proyectos]
    parameters.delete(:proyectos)

    categories = parameters[:categories]
    parameters.delete(:categories)

    respond_to do |format|
      if @product.update(parameters)
        if articles != nil
            articles.each_with_index do |article, i|
                articles[i] = Article.find(article.to_i)
                if !@product.articles.include? articles[i]
                    @product.articles << articles[i]
                end
            end
        else
            articles = []
        end

        @product.articles.each do |article|
            if !articles.include? article
                @product.product_referenceables.find_by(referenceable_id: article.id).destroy
            end
        end

        if proyectos != nil
            proyectos.each_with_index do |article, i|
                proyectos[i] = Proyecto.find(article.to_i)
                if !@product.proyectos.include? proyectos[i]
                    @product.proyectos << proyectos[i]
                end
            end
        else
            proyectos = []
        end

        @product.proyectos.each do |article|
            if !proyectos.include? article
                @product.product_referenceables.find_by(referenceable_id: article.id).destroy
            end
        end

        if categories != nil
            categories.each_with_index do |category, i|
                categories[i] = Category.find(category.to_i)
                if !@product.categories.include? categories[i]
                    categories[i].products << @product
                end
            end
        else
            categories = []
        end

        @product.categories.each do |category|
            if !categories.include? category
                @product.category_categorizables.find_by(category_id: category.id).destroy
            end
        end

        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
        params.require(:product).permit(:title, :title2, :description, :description2, {:articles => []}, {:proyectos => []}, {:categories => []}, :image)
    end
end
