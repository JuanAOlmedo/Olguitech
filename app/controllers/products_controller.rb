class ProductsController < ApplicationController
    before_action :set_product, only: %i[show edit update destroy]
    before_action :authenticate_admin!, except: %i[index show]

    # GET /products or /products.json
    def index
        ordered = Product.get_ordered(params[:order_by], params[:asc_desc])

        @categories = ordered[0]
        @products = ordered[1]

        @uncategorized = Product.uncategorized
    end

    # GET /products/1 or /products/1.json
    def show
        if @product.views == nil
            @product.views = 0
        end

        if session[:viewed_products] == nil
            @product.views += 1

            session[:viewed_products] = [@product.id]
        elsif !@product.id.in? session[:viewed_products].to_a
            @product.views += 1

            a = session[:viewed_products].to_a
            a << @product.id
            session[:viewed_products] = a
        end

        @product.save
    end

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
