import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="index"
// Controls the articles, products and projects index.
export default class extends Controller {
    scrollToAnchor(event) {
        event.preventDefault();
        location.hash = event.target.attributes.href.value;
    }
}
