import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="solution-creator"
export default class extends Controller {
    static targets = ["fileInput", "image"];

    // Show an image when it is uploaded in an solution's form
    displayNewImage() {
        const [file] = this.fileInputTarget.files;
        if (file) {
            this.imageTarget.src = URL.createObjectURL(file);
        }
    }
}
