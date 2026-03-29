import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="user-index"
export default class extends Controller {
    static targets = ["search", "row", "toggle"];

    connect() {
        this.filterConfirmed = false;
    }

    // Search all the table rows and display only the ones that match the searched
    // input
    search() {
        const input = this.normalizeInput(this.searchTarget.value);
        const words = input.split(/\s+/).filter((w) => w.length > 0);

        this.rowTargets.forEach((row) => {
            const rowText = this.normalizeInput(row.innerText);
            const matchesSearch =
                words.length === 0 ||
                words.some((word) => rowText.includes(word));

            const matchesFilter =
                !this.filterConfirmed || row.dataset.confirmed === "true";

            row.style.display =
                matchesSearch && matchesFilter ? "table-row" : "none";
        });
    }

    toggleFilter() {
        this.filterConfirmed = this.toggleTarget.checked;

        this.search();
    }

    normalizeInput(input) {
        return input
            .toLowerCase()
            .normalize("NFD")
            .replace(/[\u0300-\u036f]/g, "")
            .trim();
    }
}
