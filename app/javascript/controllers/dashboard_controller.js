import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dashboard"
// Controller for the admin dashboard
export default class extends Controller {
    // CSRF-Token needed to send requests back to the server
    csrfToken = document.querySelector('meta[name="csrf-token"]').content;

    // Send a request to the server with the parameters that the link provides.
    update(event) {
        event.preventDefault();

        if (event.params.confirm && !confirm(event.params.confirm)) return;

        fetch(event.target.href, {
            method: event.params.method,
            headers: {
                "X-CSRF-Token": this.csrfToken,
                "Content-Type": "application/x-www-form-urlencoded",
            },
        });
    }
}
