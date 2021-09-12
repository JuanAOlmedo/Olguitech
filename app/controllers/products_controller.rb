class ProductsController < ApplicationController
    before_action :set_product, only: %i[show edit update destroy]
    before_action :authenticate_admin!, except: %i[index show]

    # GET /products or /products.json
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
            @products = Product.all.order(order_by => asc_desc)
        end

        @uncategorized = []

        Product.all.each do |product|
            @uncategorized << product if product.categories.empty?
        end
    end

    # GET /products/1 or /products/1.json
    def show; end

    # GET /products/new
    def new
        @product = Product.new
    end

    # GET /products/1/edit
    def edit; end

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

        @product.change_related(articles, proyectos, categories)

        respond_to do |format|
            if @product.save
                format.html do
                    redirect_to @product,
                                notice: 'Producto creado exitosamente.'
                end
                format.json do
                    render :show, status: :created, location: @product
                end
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json do
                    render json: @product.errors, status: :unprocessable_entity
                end
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
                @product.change_related(articles, proyectos, categories)

                format.html do
                    redirect_to @product,
                                notice: 'Producto actualizado exitosamente.'
                end
                format.json { render :show, status: :ok, location: @product }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json do
                    render json: @product.errors, status: :unprocessable_entity
                end
            end
        end
    end

    # DELETE /products/1 or /products/1.json
    def destroy
        @product.destroy
        respond_to do |format|
            format.html do
                redirect_to products_url,
                            notice: 'Producto destruido exitosamente.'
            end
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
        params
            .require(:product)
            .permit(
                :title,
                :title2,
                :description,
                :description2,
                :content,
                :content2,
                { articles: [] },
                { proyectos: [] },
                { categories: [] },
                :image,
            )
    end
end
