
import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="article-creator"
export default class extends Controller {
    connect() {
        hcaptcha.render('captcha');
    }
}
