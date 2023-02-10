import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="index"
// Controls the articles, products and projects index.
export default class extends Controller {
    expandMenu() {
        const content = event.target.nextElementSibling;
        content.classList.toggle('active')

//        if (content.style.maxHeight) {
//            content.style.maxHeight = null;
//        } else {
//            content.style.maxHeight = content.scrollHeight + "px";
//        }
    }
}
