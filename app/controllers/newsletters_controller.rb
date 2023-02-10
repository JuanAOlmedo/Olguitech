# frozen_string_literal: true

class NewslettersController < ApplicationController
    before_action :set_newsletter, only: %i[show edit update destroy]
    before_action :check_sent, only: %i[edit update destroy]
    before_action :authenticate_admin!, except: :show

    def index
        @newsletters = Newsletter.all.order(created_at: :desc)
    end

    # GET /newsletters/1
    def show; end

    # GET /newsletters/new
    def new
        @newsletter = Newsletter.new
    end

    # GET /newsletters/1/edit
    def edit; end

    # POST /newsletters
    def create
        @newsletter = Newsletter.new(newsletter_params)

        if @newsletter.save
            @newsletter.send_newsletter if @newsletter.sent?
            redirect_to @newsletter, notice: 'Se ha creado la Newsletter'
        else
            render :new, status: :unprocessable_entity
        end
    end

    # PATCH /newsletters/1
    def update
        if @newsletter.update(newsletter_params)
            @newsletter.send_newsletter if @newsletter.sent?

            redirect_to @newsletter, notice: 'Newsletter actualizada exitosamente.'
        else
            render :edit, status: :unprocessable_entity
        end
    end

    # DELETE /newsletters/1
    def destroy
        @newsletter.destroy
        respond_to do |format|
            format.html do
                redirect_to root_path,
                            notice: 'Newsletter destruido exitosamente.',
                            status: :see_other
            end
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_newsletter
        @newsletter = Newsletter.friendly.find(params[:id])

        authenticate_admin! unless @newsletter.sent?
    end

    # Only allow a list of trusted parameters through.
    # Convert status to integer or use :sent instead if it exists.
    # Don't allow :sent through
    def newsletter_params
        params.require(:newsletter)
              .permit(:title, :content, :subject, :status, :sent)
              .merge(status: (params[:newsletter][:sent] || params[:newsletter][:status]).to_i)
              .except(:sent)
    end

    def check_sent
        return unless @newsletter.sent?

        redirect_to root_path, alert: 'La Newsletter ya fue enviada, no se puede editar'
    end

    def redirect_unless_admin
        return if admin_signed_in?

        redirect_to root_path, alert: 'Solo administradores pueden hacer eso'
    end
end
