import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="user-index"
export default class extends Controller {
    static classes = ["hidden"];

    toggleShowContacts(event) {
        const { id } = event.target.dataset;
        const info = document.querySelector(`#article-${id}`);

        if (info) {
            info.classList.toggle(this.hiddenClass);
        }
    }
}
