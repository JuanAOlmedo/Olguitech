import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
    static targets = [ "menu" ]
    static classes = [ "active" ]

    display() {
        if (this.element.classList.contains(this.activeClass)) {
            setTimeout(() => {
                this.menuTarget.style.visibility = "hidden";
            }, 250);
        } else {
            this.menuTarget.style.visibility = "visible";
        }

        this.element.classList.toggle(this.activeClass);
    }
}
