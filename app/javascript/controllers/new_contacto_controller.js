import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-contacto"
export default class extends Controller {
    connect() {
        console.log('connected!');
        hcaptcha.render('captcha');
    }
}
