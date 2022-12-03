import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dropdown-bars"
// Main dropdown from the navbar
export default class extends Controller {
    static targets = ["menu", "bars", "line1", "line2"];

    static classes = ["show", "move"];

    initialize() {
        this.showing = false;
    }

    // Display the dropdown or hide it according to the variable showing.
    display() {
        this.menuTarget.classList.toggle(this.showClass);
        this.line1Target.classList.toggle(this.moveClass);
        this.line2Target.classList.toggle(this.moveClass);

        // Wait some time to hide the dropdown so that the animation is displayed
        // properly
        setTimeout(
            () => this.menuTarget.classList.toggle("visible"),
            this.showing ? 450 : 0
        );

        this.showing = !this.showing;
    }

    // Hide the dropdown when the user clicks outside.
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
