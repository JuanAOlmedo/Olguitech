import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dashboard"
export default class extends Controller {
    csrfToken = document.querySelector('meta[name="csrf-token"]').content;

    connect() {
        this.updateDraftHolders();
    }

    update(event) {
        event.preventDefault();
        const href = event.target.href,
            params = href.slice(href.indexOf("?") + 1),
            url = `${href.slice(0, href.indexOf("?"))}.json`;

        fetch(url, {
            method: "PATCH",
            headers: {
                "X-CSRF-Token": this.csrfToken,
                "Content-Type": "application/x-www-form-urlencoded",
            },
            body: params,
        })
            .then((result) => result.json())
            .then((article) => {
                if (url.indexOf("/categories/") != -1) {
                    event.target.parentElement.parentElement.remove();
                    return;
                }

                this.appendArticle(article);
            });
    }

    delete({ params: { id } }) {
        event.preventDefault();
        if (!confirm(event.target.dataset.turboConfirm)) return;

        fetch(event.target.href, {
            method: "DELETE",
            headers: { "X-CSRF-Token": this.csrfToken },
        }).then(document.getElementById(id).remove());

        this.updateDraftHolders();
    }

    appendArticle(article) {
        const domArticle = document.getElementById(article.dom_id);
        domArticle.remove();
        domArticle.classList.remove("drafted", "published", "trashed", "sent");
        domArticle.classList.add(article.status);

        if (article.status != "trashed") {
            const articles = document.querySelector(
                `#${article.status}_${article.model_name}`
            );

            if (articles) articles.appendChild(domArticle);
        }

        this.updateDraftHolders();
    }

    updateDraftHolders() {
        const holders = document.querySelectorAll(
                "#drafted_articles, #drafted_projects, #drafted_products, #drafted_newsletters"
            ),
            message = document.getElementById("dashboard-message");

        holders.forEach((holder) => {
            holder.parentElement.style.display =
                holder.childElementCount != 0 ? "block" : "none";
        });

        if (!message) return;

        const shouldDisplayMessage = Array.from(holders).every(
            (holder) => holder && holder.parentElement.style.display == "none"
        );
        message.style.display = shouldDisplayMessage ? "block" : "none";
    }
}
