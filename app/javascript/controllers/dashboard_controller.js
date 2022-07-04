import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="dashboard"
export default class extends Controller {
    connect() {
        this.updateDraftHolders();
    }

    update(event) {
        event.preventDefault();
        let url = event.target.href;
        const params = url.slice(url.indexOf('?') + 1);
        url = `${url.slice(0, url.indexOf('?'))}.json`;

        fetch(url, {
            method: 'PATCH',
            headers: {
                'X-CSRF-Token': document.querySelector(
                    'meta[name="csrf-token"]'
                ).content,
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: params,
        })
            .then((result) => result.json())
            .then((article) => {
                if (url.indexOf('categories' != -1)) {
                    event.target.parentElement.parentElement.remove();
                    return;
                }
                this.appendArticle(article);
            });
    }

    appendArticle(article) {
        const domArticle = document.getElementById(article.dom_id);
        domArticle.remove();
        domArticle.classList.remove('drafted', 'published', 'trashed', 'sent');
        domArticle.classList.add(article.status);

        if (article.status === 'published' || article.status === 'sent') {
            const articles = document.querySelector(`#${article.model_name}`);
            articles.appendChild(domArticle);
        } else if (article.status === 'drafted') {
            const articles = document.querySelector(
                `#${article.model_name.slice(0, -1)}_drafts`
            );
            if (articles) articles.appendChild(domArticle);
        }

        this.updateDraftHolders();
    }

    updateDraftHolders() {
        const toCheck = [document.getElementById('article_drafts'),
                         document.getElementById('proyecto_drafts'),
                         document.getElementById('product_drafts'),
                         document.getElementById('newsletter_drafts')];
        const message = document.getElementById('dashboard-message');

        toCheck.forEach((element) => {
            if (!element) return;

            element.parentElement.style.display = element.children.length != 0 ? 'block' : 'none';
        });

        const filtered = toCheck.filter(element => element && element.parentElement.style.display != 'none');
        message.style.display = filtered.length === 0 ? 'block' : 'none'; 
    }

    delete({ params: { id } }) {
        event.preventDefault();
        if (!confirm(event.target.dataset.turboConfirm)) return;

        const url = event.target.href;

        fetch(url, {
            method: 'DELETE',
            headers: {
                'X-CSRF-Token': document.querySelector(
                    'meta[name="csrf-token"]'
                ).content,
            },
        }).then(document.getElementById(id).remove());

        this.updateDraftHolders();
    }
}
