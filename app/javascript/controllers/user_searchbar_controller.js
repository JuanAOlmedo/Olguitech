import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-searchbar"
export default class extends Controller {
    static targets = [ "search", "row" ]

    search() {
        let input = this.searchTarget.value.toLowerCase();
        
        this.rowTargets.forEach((row) => {
            if (!row.innerText.toLowerCase().includes(input)) {
                row.style.display = "none";
            } else {
                row.style.display = "table-row";
            }
        });
    }
}