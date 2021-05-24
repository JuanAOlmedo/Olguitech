class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, except: [:index, :show]

  # GET /categories or /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1 or /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    parameters = category_params
    products = parameters[:products]
    parameters.delete(:products)

    articles = parameters[:articles]
    parameters.delete(:articles)

    proyectos = parameters[:proyectos]
    parameters.delete(:proyectos)

    @category = Category.new(parameters)

    respond_to do |format|
      if @category.save
        if products != nil
            products.each_with_index do |article, i|
                products[i] = Product.find(article.to_i)
                if !@category.products.include? products[i]
                    @category.products << products[i]
                end
            end
        else
            products = []
        end

        if articles != nil
            articles.each_with_index do |article, i|
                articles[i] = Article.find(article.to_i)
                if !@category.articles.include? articles[i]
                    @category.articles << articles[i]
                end
            end
        else
            articles = []
        end

        if proyectos != nil
            proyectos.each_with_index do |article, i|
                proyectos[i] = Proyecto.find(article.to_i)
                if !@category.proyectos.include? proyectos[i]
                    @category.proyectos << proyectos[i]
                end
            end
        else
            proyectos = []
        end

        format.html { redirect_to @category, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    parameters = category_params
    products = parameters[:products]
    parameters.delete(:products)

    articles = parameters[:articles]
    parameters.delete(:articles)

    proyectos = parameters[:proyectos]
    parameters.delete(:proyectos)

    respond_to do |format|
      if @category.update(parameters)
        if products != nil
            products.each_with_index do |article, i|
                products[i] = Product.find(article.to_i)
                if !@category.products.include? products[i]
                    @category.products << products[i]
                end
            end
        else
            products = []
        end

        @category.products.each do |article|
            if !products.include? article
                @category.category_categorizables.find_by(categorizable_id: article.id).destroy
            end
        end

        if articles != nil
            articles.each_with_index do |article, i|
                articles[i] = Article.find(article.to_i)
                if !@category.articles.include? articles[i]
                    @category.articles << articles[i]
                end
            end
        else
            articles = []
        end

        @category.articles.each do |article|
            if !articles.include? article
                @category.category_categorizables.find_by(categorizable_id: article.id).destroy
            end
        end

        if proyectos != nil
            proyectos.each_with_index do |article, i|
                proyectos[i] = Proyecto.find(article.to_i)
                if !@category.proyectos.include? proyectos[i]
                    @category.proyectos << proyectos[i]
                end
            end
        else
            proyectos = []
        end

        @category.proyectos.each do |article|
            if !proyectos.include? article
                @category.category_categorizables.find_by(categorizable_id: article.id).destroy
            end
        end

        format.html { redirect_to @category, notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
        params.require(:category).permit(:title, :title2, :description, :description2, {:products => []}, {:articles => []}, {:proyectos => []}, :image)
    end
end
