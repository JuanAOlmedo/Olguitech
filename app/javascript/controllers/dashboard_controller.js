import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard"
export default class extends Controller {
    connect() {
    }

    update() {
        event.preventDefault();
        let url = event.target.href,
            params = url.slice(url.indexOf('?') + 1);
        url = url.slice(0, url.indexOf('?')) + '.json';

        fetch(url, {
            method: "PATCH",
            headers: {
                'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
                'Content-Type': 'application/x-www-form-urlencoded'	
            },
            body: params
        }).then(result => result.json())
          .then(article => {
              const domArticle = document.getElementById(article.dom_id);
              domArticle.parentElement.removeChild(domArticle);
              domArticle.classList.remove('drafted', 'published', 'trashed')
              domArticle.classList.add(article.status)

              if (article.status === 'published') {
                  const articles = document.querySelector(`#${article.model_name}`)
                  articles.appendChild(domArticle)
              } else if (article.status === 'drafted') {
                  const articles = document.querySelector(`#${article.model_name.slice(0, -1)}_drafts`)
                  if (articles) articles.appendChild(domArticle)
              }
          });
    }

    delete({ params: { id } }) {
        event.preventDefault();
        console.log(id)
        if (!confirm(event.target.dataset.turboConfirm)) return;

        let url = event.target.href;
        
        fetch(url, {
            method: "DELETE",
            headers: {
                'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
            }
        }).then(document.getElementById(id).remove())
    }
}
