import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dropdown"
// Dropdowns from the DropdownHelper
export default class extends Controller {
    static targets = ["menu"];

    static classes = ["active"];

    display() {
        if (this.element.classList.contains(this.activeClass)) {
            // Wait some time to hide the dropdown so that the animation is displayed
            // properly
            setTimeout(() => {
                this.menuTarget.style.visibility = "hidden";
            }, 250);
        } else {
            this.menuTarget.style.visibility = "visible";
        }

        this.element.classList.toggle(this.activeClass);
    }

    // Hide the dropdown when the user clicks outside.
    stopDisplayingWhenOutside(event) {
        if (this.element.contains(event.target)) {
            return;
        }

        setTimeout(() => {
            this.menuTarget.style.visibility = "hidden";
        }, 250);

        this.element.classList.remove(this.activeClass);
    }
}
