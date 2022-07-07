import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dropdown-bars"
export default class extends Controller {
    static targets = ["menu", "bars", "line1", "line2"];

    static classes = ["show", "move"];

    initialize() {
        this.showing = false;
    }

    display() {
        this.menuTarget.classList.toggle(this.showClass);
        this.line1Target.classList.toggle(this.moveClass);
        this.line2Target.classList.toggle(this.moveClass);

        setTimeout(
            () => this.menuTarget.classList.toggle("visible"),
            this.showing ? 450 : 0
        );

        this.showing = !this.showing;
    }

    stopDisplayingWhenOutside(event) {
        if (
            !this.menuTarget.contains(event.target) &&
            !this.barsTarget.contains(event.target) &&
            this.menuTarget.classList.contains(this.showClass)
        ) {
            this.display();
        }
    }
}
