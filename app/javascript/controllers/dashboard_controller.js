import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dashboard"
// Controller for the admin dashboard
export default class extends Controller {
    // CSRF-Token needed to send requests back to the server
    csrfToken = document.querySelector('meta[name="csrf-token"]').content;

    connect() {
        this.updateDraftHolders();
    }

    // Send a request to the server with the parameters that the link provides.
    // Send the resulting article to appendArticle to process it.
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
                if (article.model_name == "categories") {
                    event.target.parentElement.parentElement.remove();
                    return;
                }

                this.appendArticle(article);
            });
    }

    // Delete an article and remove it from the DOM
    delete({ params: { id } }) {
        event.preventDefault();
        if (!confirm(event.target.dataset.turboConfirm)) return;

        fetch(event.target.href, {
            method: "DELETE",
            headers: { "X-CSRF-Token": this.csrfToken },
        }).then(document.getElementById(id).remove());

        this.updateDraftHolders();
    }

    // Append the updated article to its corresponding place in the DOM and update
    // the draft holders.
    appendArticle(article) {
        const domArticle = document.getElementById(article.dom_id);
        domArticle.remove();
        domArticle.classList = `compact-card ${article.status}`;

        if (article.status != "trashed") {
            const articles = document.querySelector(
                `#${article.status}_${article.model_name}`,
            );

            if (articles) articles.appendChild(domArticle);
        }

        this.updateDraftHolders();
    }

    // Don't show the drafts section unless there are any drafted articles.
    // If all draft holders are empty, display a message indicating this.
    updateDraftHolders() {
        const holders = document.querySelectorAll(
                "#drafted_solutions, #drafted_projects, #drafted_products, #drafted_newsletters",
            ),
            message = document.getElementById("dashboard-message");

        holders.forEach((holder) => {
            holder.parentElement.style.display =
                holder.childElementCount != 0 ? "block" : "none";
        });

        if (!message) return;

        const shouldDisplayMessage = Array.from(holders).every(
            (holder) => holder && holder.parentElement.style.display == "none",
        );
        message.style.display = shouldDisplayMessage ? "block" : "none";
    }
}
