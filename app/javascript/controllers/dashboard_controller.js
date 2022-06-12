import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="dashboard"
export default class extends Controller {
    connect() {
        this.updateHolders();
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
            .then((article) => this.appendArticle(article));
    }

    appendArticle(article) {
        const domArticle = document.getElementById(article.dom_id);
        domArticle.parentElement.removeChild(domArticle);
        domArticle.classList.remove('drafted', 'published', 'trashed');
        domArticle.classList.add(article.status);

        if (article.status === 'published') {
            const articles = document.querySelector(`#${article.model_name}`);
            articles.appendChild(domArticle);
        } else if (article.status === 'drafted') {
            const articles = document.querySelector(
                `#${article.model_name.slice(0, -1)}_drafts`
            );
            if (articles) articles.appendChild(domArticle);
        }

        this.updateHolders();
    }

    updateHolders() {
        const toCheck = [];
        const message = document.getElementById('dashboard-message');
        toCheck.push(document.getElementById('article_drafts'));
        toCheck.push(document.getElementById('proyecto_drafts'));
        toCheck.push(document.getElementById('product_drafts'));
        let empty = 0;

        toCheck.forEach((element) => {
            if (element && element.children.length === 0) { 
                element.parentElement.style.display = 'none';
                empty += 1;
            } else {
                element.parentElement.style.display = 'block';
            }
        });

        if (empty === 3) { 
            message.style.display = 'block'; 
        } else {
            message.style.display = 'none';
        }
    }

    delete({ params: { id } }) {
        event.preventDefault();
        console.log(id);
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
    }
}
