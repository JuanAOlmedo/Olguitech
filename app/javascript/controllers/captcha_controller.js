import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="captcha"
export default class extends Controller {
    static targets = ["script"];

    connect() {
        this.loaded = false;
    }

    load() {
        if (this.loaded) return;

        const script = document.createElement("script");
        script.src = "https://www.recaptcha.net/recaptcha/api.js";
        script.async = true;
        script.defer = true;
        document.head.appendChild(script);

        this.loaded = true;
    }
}
