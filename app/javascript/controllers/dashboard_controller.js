import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dashboard"
// Controller for the admin dashboard
export default class extends Controller {
    // CSRF-Token needed to send requests back to the server
    csrfToken = document.querySelector('meta[name="csrf-token"]').content;

    // When clicking on a link, make the request it specifies.
    makeRequest(event) {
        // Confirm the action if the parameter confirmation is present
        if (
            event.params.confirmation != undefined &&
            !confirm(event.params.confirmation)
        )
            return;

        fetch(event.target.href, {
            method: event.params.method || "PATCH", // Make PATCH request by default
            headers: { "X-CSRF-Token": this.csrfToken },
        }).then(this.refresh()); // Refresh the dashboard after the request is completed
    }

    // Make Turbo refresh the current page
    refresh() {
        Turbo.visit(window.location.href, { action: "replace" });
    }
}
