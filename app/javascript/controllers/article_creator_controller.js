import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="article-creator"
export default class extends Controller {
    static targets = ["fileInput", "image"];

    displayNewImage() {
        const [file] = this.fileInputTarget.files;
        if (file) {
            this.imageTarget.src = URL.createObjectURL(file);
        }
    }
}
