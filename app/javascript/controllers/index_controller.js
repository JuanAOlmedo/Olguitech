import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="index"
export default class extends Controller {
    static targets = ["menu", "svg", "path", "category", "title"];

    initialize() {
        if ("IntersectionObserver" in window) {
            this.categoryObserver = new IntersectionObserver(
                (entries, categoryObserver) => {
                    entries.forEach((entry) => {
                        if (!entry.isIntersecting) {
                            entry.target.classList.remove("visible1");

                            this.titleTargets[
                                Number(entry.target.dataset.index)
                            ].classList.remove("visible");

                            this.setSvg();
                            return;
                        }

                        entry.target.classList.add("visible1");
                        this.setVisible();

                        this.setSvg();
                    });
                },
                { threshold: 0 }
            );
        }
    }

    connect() {
        this.categoryTargets.forEach((category) => {
            this.categoryObserver.observe(category);
        });
    }

    setVisible() {
        this.categoryTargets.forEach((category) => {
            if (category.classList.contains("visible1")) {
                this.titleTargets[Number(category.dataset.index)].classList.add(
                    "visible"
                );
            }
        });
    }

    setSvg() {
        const categories = Array.from(document.querySelectorAll(".visible1")),
            menuBounds = this.menuTarget.getBoundingClientRect();
        this.svgTarget.style.height = `${menuBounds.y + menuBounds.height}px`;

        let categoriesIndex = [];
        categories.forEach((category) => {
            categoriesIndex.push(Number(category.dataset.index));
        });

        if (categories.length == 0) {
            this.pathTarget.setAttribute("stroke-dasharray", "0 0 0 10000");
            return;
        }

        let category1 =
                this.titleTargets[
                    Math.min.apply(Math, categoriesIndex)
                ].getBoundingClientRect(),
            category2 =
                this.titleTargets[
                    Math.max.apply(Math, categoriesIndex)
                ].getBoundingClientRect();

        const firstTitle = this.titleTargets[0].getBoundingClientRect(),
            lastTitle =
                this.titleTargets[
                    this.titleTargets.length - 1
                ].getBoundingClientRect();

        let pathStart = category1.y - firstTitle.y,
            pathEnd = category2.y + category2.height - firstTitle.y,
            pathLength = pathEnd - pathStart;

        this.pathTarget.attributes.d.value = `
        M ${firstTitle.x} ${firstTitle.y}
        V ${lastTitle.y + lastTitle.height}
        `;

        this.pathTarget.setAttribute(
            "stroke-dasharray",
            `0 ${pathStart} ${pathLength} 10000`
        );
    }
}
