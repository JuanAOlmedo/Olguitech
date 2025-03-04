# frozen_string_literal: true

class NewslettersController < ApplicationController
    before_action :set_newsletter, only: %i[show edit update destroy change_status]
    before_action :check_sent, only: %i[edit update destroy]
    before_action :authenticate_admin!, except: :show

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

            respond_to do |format|
                format.html { redirect_to @newsletter, notice: 'Newsletter actualizada exitosamente.' }
                format.json { head :ok }
            end
        else
            respond_to do |format|
                format.html { render :edit, status: :unprocessable_entity }
                format.json { head :unprocessable_entity }
            end
        end
    end

    # DELETE /newsletters/1
    def destroy
        @newsletter.destroy

        redirect_to root_path, notice: 'Newsletter destruido exitosamente.', status: :see_other
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_newsletter
        @newsletter = Newsletter.friendly.find(params[:id])

        authenticate_admin! unless @newsletter.sent?
    end

    # Only allow a list of trusted parameters through.
    # Don't allow :sent through
    def newsletter_params
        p = params.require(:newsletter).permit(:title, :content, :subject, :status, :sent) .except(:sent)

        case params[:newsletter][:sent]
        when '1'
            p.merge! status: :sent
        when '0'
            p.merge! status: :drafted
        else
            p
        end
    end

    # Sent newsletters should not be edited or destroyed
    def check_sent
        return unless @newsletter.sent?

        redirect_to root_path, alert: 'La Newsletter ya fue enviada, no se puede editar'
    end

    def redirect_unless_admin
        return if admin_signed_in?

        redirect_to root_path, alert: 'Solo administradores pueden hacer eso'
    end
end
