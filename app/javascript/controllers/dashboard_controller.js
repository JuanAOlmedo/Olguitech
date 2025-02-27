import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="dashboard"
// Controller for the admin dashboard
export default class extends Controller {
    refresh() {
        Turbo.visit(window.location.href, { action: "replace" });
    }
}
