import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="captcha"
export default class extends Controller {
    connect() {
        this.renderCaptcha();
        this.turboListener = () => this.renderCaptcha();
        document.addEventListener("turbo:render", this.turboListener);
    }

    disconnect() {
        document.removeEventListener("turbo:render", this.turboListener);
    }

    renderCaptcha() {
        const widget = this.element.querySelector(".g-recaptcha");
        if (window.hcaptcha && widget) {
            widget.innerHTML = "";
            hcaptcha.render(widget);
        }
    }
}
