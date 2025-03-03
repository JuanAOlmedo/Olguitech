#frozen_string_literal: true

# Includes all the functionality of Products, Projects and SolutionsControllers.
module Articles
    extend ActiveSupport::Concern

    included do
        before_action :set_article, only: %i[show edit update destroy change_status]
        before_action :authenticate_admin!, except: %i[index show]
    end

    def index
        @uncategorized = params[:uncategorized].present?
        @articles = if @uncategorized
                        model.published.uncategorized.select model.fields_for_cards
                    else
                        model.published.select model.fields_for_cards
                    end
    end

    def new
        @article = model.new
    end

    # Count the number of views of an article. Store in the user's session that
    # the article has been viewed
    def show
        session_name = :"viewed_#{model.model_name.plural}"
        session[session_name] = [] unless session[session_name]

        return if @article.id.in? session[session_name]

        @article.update views: @article.views + 1
        session[session_name] << @article.id
    end

    def create
        @article = model.new article_params

        if @article.save
            redirect_to @article, notice: 'Artículo creado exitosamente.'
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit; end

    def update
        if @article.update article_params
            redirect_to @article, notice: 'Artículo actualizado exitosamente.'
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @article.destroy
        @article.broadcast_refresh_later

        redirect_to send("#{model.model_name.plural}_url"),
                    notice: 'Artículo destruido exitosamente.',
                    status: :see_other
    end

    # PATCH /articles/1/status
    # Used in dashboard to update the status of an article.
    def change_status
        @article.update! status: params[:status].to_i

        head :no_content
    end

    private

    # Set the model used in the controller.
    # For example, if the controller is SolutionsController, the model will be Solution.
    def model
        @model ||= self.class.name.sub('Controller', '').singularize.constantize
    end

    def set_article
        @article = model.friendly.find(params[:id])

        authenticate_admin! unless @article.published?
    end
end
