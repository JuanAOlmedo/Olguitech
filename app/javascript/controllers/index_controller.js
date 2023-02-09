import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="index"
// Controls the articles, products and projects index.
export default class extends Controller {
    expandMenu() {
        const content = event.target.nextElementSibling;

        event.target.classList.toggle("active");
        content.classList.toggle("active")
    }
}
