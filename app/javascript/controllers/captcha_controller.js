import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="captcha"
export default class extends Controller {
    static targets = ["script"];

    load() {
        if (document.querySelector(".g-recaptcha").innerHTML !== "") return;

        if (!window.grecaptcha) {
            // Script no cargado todavía
            const script = document.createElement("script");
            script.src = "https://www.recaptcha.net/recaptcha/api.js";
            script.async = true;
            script.defer = true;
            document.head.appendChild(script);
            return;
        }

        // Si el script ya está cargado, intentamos renderizar el reCAPTCHA
        // A veces falla uno de los dos comandos sin razón aparente, por eso se ponen
        // los dos
        try {
            grecaptcha.render(document.querySelector(".g-recaptcha"));
        } catch {
            grecaptcha.reset(document.querySelector(".g-recaptcha"));
        }
    }
}
