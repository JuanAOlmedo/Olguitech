class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, except: [:index, :show]

  # GET /products or /products.json
  def index
    @products = Product.all
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
        params.require(:product).permit(:title, :title2, :description, :description2, {:articles => []}, {:proyectos => []}, :image)
    end
end
