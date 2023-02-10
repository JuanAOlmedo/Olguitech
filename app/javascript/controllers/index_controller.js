import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="index"
// Controls the articles, products and projects index.
export default class extends Controller {
    expandMenu() {
        event.target.nextElementSibling.classList.toggle('active');
    }
}
