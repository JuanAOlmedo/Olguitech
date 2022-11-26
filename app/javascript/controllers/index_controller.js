import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="index"
// Controls the articles, products and projects index.
export default class extends Controller {
    static targets = ["menu", "svg", "path", "category", "title"];

    categoriesIndex = [];

    initialize() {
        if ("IntersectionObserver" in window) {
            this.categoryObserver = new IntersectionObserver(
                (entries, categoryObserver) => {
                    entries.forEach((entry) => {
                        const index = Number(entry.target.dataset.index);

                        // If the category is intersecting, append its index to
                        // the array and remove it if it isn't. Update the svg
                        if (!entry.isIntersecting) {
                            this.categoriesIndex = this.categoriesIndex.filter(
                                (i) => i != index
                            );
                            this.titleTargets[index].classList.remove(
                                "visible"
                            );

                            this.setSvg();
                            return;
                        }

                        this.categoriesIndex.push(index);
                        this.titleTargets[index].classList.add("visible");

                        this.setSvg();
                    });
                },
                { threshold: 0 }
            );
        }
    }

    // Observe every category section
    connect() {
        if ("IntersectionObserver" in window) {
            this.categoryTargets.forEach((category) => {
                this.categoryObserver.observe(category);
            });
        }
    }

    // Update the svg to span all the categories which are being viewed by the user
    // The function will also get called when the user scrolls the sidebar
    setSvg() {
        if (this.categoriesIndex.length == 0) {
            this.pathTarget.setAttribute("stroke-dasharray", "0 0 0 10000");
            return;
        }

        // Get the first and last category viewed by the user and select their
        // corresponding titles on the sidebar
        const category1 =
                this.titleTargets[
                    Math.min.apply(Math, this.categoriesIndex)
                ].getBoundingClientRect(),
            category2 =
                this.titleTargets[
                    Math.max.apply(Math, this.categoriesIndex)
                ].getBoundingClientRect();

        // Get the first and last title in the sidebar
        const firstTitle = this.titleTargets[0].getBoundingClientRect(),
            lastTitle = this.titleTargets.pop().getBoundingClientRect();

        const pathStart = category1.y - firstTitle.y,
            pathEnd = category2.y + category2.height - firstTitle.y,
            pathLength = pathEnd - pathStart,
            lastY = lastTitle.y + lastTitle.height;

        this.svgTarget.style.height = `${lastY}px`;

        this.pathTarget.attributes.d.value = `
            M ${firstTitle.x} ${firstTitle.y} V ${lastY}
        `;

        this.pathTarget.setAttribute(
            "stroke-dasharray",
            `0 ${pathStart} ${pathLength} 10000`
        );
    }
}
