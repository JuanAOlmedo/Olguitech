import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="intersection-observer"
export default class extends Controller {
    initialize() {
        if ("IntersectionObserver" in window) {
            this.stillsObserver = new IntersectionObserver(
                (entries, stillsObserver) => {
                    entries.forEach((entry) => {
                        if (entry.isIntersecting) {
                            entry.target.classList.add("move");
                            stillsObserver.unobserve(entry.target);
                        }
                    });
                },
                {
                    threshold: 0.1,
                }
            );
        }
    }

    // The class .move will be added to every element with the class .still when
    // it is viewed by the user
    // As a fallback, if the browser doesn't support the IntersectionObserver API
    // all elements will have the .move class appended
    connect() {
        document.querySelectorAll(".still").forEach((still) => {
            if ("IntersectionObserver" in window) {
                this.stillsObserver.observe(still);
            } else {
                still.classList.add("move");
            }
        });
    }
}
