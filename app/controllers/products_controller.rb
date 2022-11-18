# frozen_string_literal: true

class ProductsController < ApplicationController
    before_action :set_product, only: %i[show edit update destroy]
    before_action :authenticate_admin!, except: %i[index show]

    # GET /products or /products.json
    def index
        respond_to do |format|
            format.html do
                @categories, @products = 
                    Product.ordered(params[:order_by], params[:asc_desc])

                @uncategorized = Product.published.where.missing :categories
            end

            format.json { @products = Product.published }
        end
    end

    # GET /products/1 or /products/1.json
    def show
        viewed_products = session[:viewed_products]

        return unless viewed_products.nil? || !@product.id.in?(viewed_products)

        @product.views += 1

        session[:viewed_products] = [] if viewed_products.nil?
        session[:viewed_products] << @product.id

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
        @product = Product.new(product_params)

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
        respond_to do |format|
            if @product.update(product_params)
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
                            notice: 'Producto destruido exitosamente.',
                            status: :see_other
            end
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_product
        @product = Product.friendly.find(params[:id])

        authenticate_admin! unless @product.published?
    end

    # Only allow a list of trusted parameters through.
    def product_params
        product_params = params
                         .require(:product)
                         .permit(
                             :title,
                             :title2,
                             :description,
                             :description2,
                             :content,
                             :content2,
                             { article_ids: [] },
                             { project_ids: [] },
                             { category_ids: [] },
                             :image,
                             :status
                         )
        product_params[:status] = product_params[:status].to_i if product_params[:status]
        product_params
    end
end
