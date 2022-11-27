import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="alert"
export default class extends Controller {
    close() {
        this.element.classList.add("disappear");
        setTimeout(() => (this.element.style.display = "none"), 1000);
    }
}
