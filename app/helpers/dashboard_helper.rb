
module DashboardHelper
    def update_status_link(name, article, status, is_danger: false)
        link_to name, update_status_path(article, status),
                data: { action: 'dashboard#makeRequest:prevent', turbo_prefetch: false },
                class: "btn #{is_danger ? 'is-danger' : ''}"
    end

    def unrelate_category_link(category, article)
        link_to 'Desasociar', unrelate_category_path_with_article(category, article),
                data: { action: 'dashboard#makeRequest:prevent', turbo_prefetch: false },
                class: 'btn'
    end

    def delete_article_link(article)
        link_to 'Eliminar definitivamente', article,
                data: {
                    dashboard_method_param: 'DELETE',
                    dashboard_confirmation_param: 'Estás seguro?',
                    action: 'dashboard#makeRequest:prevent',
                    turbo_prefetch: false
                },
                class: 'btn is-danger'
    end

    def delete_category_link(category)
        link_to 'Eliminar', category_path(category, format: :json),
                data: {
                    dashboard_method_param: 'DELETE',
                    dashboard_confirmation_param: 'Estás seguro?',
                    action: 'dashboard#makeRequest:prevent',
                    turbo_prefetch: false
                },
                class: 'btn is-danger'
    end

    def delete_super_category_link(super_category)
        link_to 'Eliminar', super_category_path(super_category, format: :json),
                data: {
                    dashboard_method_param: 'DELETE',
                    dashboard_confirmation_param: 'Estás seguro?',
                    action: 'dashboard#makeRequest:prevent',
                    turbo_prefetch: false
                },
                class: 'btn is-danger'
    end

    def dashboard_edit_path(article)
        send "edit_#{article.model_name.singular}_path", article
    end

    private

    def update_status_path(article, status)
        url_for controller: article.model_name.plural,
                action: :show,
                id: article.id,
                format: :json,
                article.model_name.singular => { status: }
    end

    def unrelate_category_path_with_article(category, article)
        unrelate_category_path category,
                               params: { model: article.model_name.plural, article_id: article.id },
                               format: :json
    end
end
