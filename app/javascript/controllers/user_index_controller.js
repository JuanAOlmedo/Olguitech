import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="user-index"
export default class extends Controller {
    static targets = ["search", "row"];
    static classes = ["hidden"];

    // Show all the contacts a user has made
    toggleShowContacts(event) {
        const { id } = event.target.dataset;
        const info = document.querySelector(`#article-${id}`);

        if (info) {
            info.classList.toggle(this.hiddenClass);
        }
    }

    // Search all the table rows and display only the ones that match the searched
    // input
    search() {
        const input = this.searchTarget.value.toLowerCase();

        this.rowTargets.forEach((row) => {
            if (row.innerText.toLowerCase().includes(input)) {
                row.style.display = "table-row";
            } else {
                row.style.display = "none";
            }
        });
    }
}
