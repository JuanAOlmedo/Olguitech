import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-index"
export default class extends Controller {
    static classes = [ "hidden" ]

    toggleShowContacts() {
        const id = event.target.dataset.id;
        const info = document.querySelector("#article-" + id);
        
        if (info) {
            info.classList.toggle(this.hiddenClass);
        }
    }
}
