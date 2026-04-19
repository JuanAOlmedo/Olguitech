import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["content", "counter"];

    connect() {
        this.updateCounter();
    }

    updateCounter() {
        const max = this.contentTarget.maxLength;
        const current = this.contentTarget.value.length;
        this.counterTarget.textContent = `${current}/${max}`;
    }
}
