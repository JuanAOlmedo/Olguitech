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
