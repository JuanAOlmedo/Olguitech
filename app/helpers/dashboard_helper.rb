
module DashboardHelper
    def update_status_link(name, article, status, is_danger: false)
        link_to name, status_path(article, status),
                data: { turbo_method: :patch }, class: "btn #{is_danger ? 'is-danger' : ''}"
    end

    def unrelate_category_link(category, article)
        link_to 'Desasociar', unrelate_category_path_with_article(category, article),
                data: { turbo_method: :patch }, class: 'btn'
    end

    def delete_article_link(article)
        link_to 'Eliminar definitivamente', article,
                data: { turbo_method: :delete, turbo_confirm: 'Estás seguro?' }, class: 'btn is-danger'
    end

    def dashboard_edit_path(article)
        send "edit_#{article.model_name.singular}_path", article
    end

    private

    def unrelate_category_path_with_article(category, article)
        unrelate_category_path(category, params: { model: article.model_name.plural, article_id: article.id })
    end

    def status_path(article, status)
        send "status_#{article.model_name.singular}_path", article, status: status
    end
end
