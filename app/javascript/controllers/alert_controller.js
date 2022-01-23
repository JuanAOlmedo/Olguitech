import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="alert"
export default class extends Controller {
    initialize() {
        this.currentY = null;
        this.diffY = null;
    }

    close() {
        this.element.classList.add("disappear");
        setTimeout(() => (this.element.style.display = "none"), 1000);
    }

    moveTouch() {
        this.currentY = event.touches[0].clientY;
        this.diffY = 0 - this.currentY;

        event.preventDefault();
    }

    endTouch() {
        if (this.diffY > 1) {
            this.close();
        }

        this.diffY = 0;
    }
}
