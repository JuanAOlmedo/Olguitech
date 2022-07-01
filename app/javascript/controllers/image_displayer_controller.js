import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image-displayer"
export default class extends Controller {
    static targets = ['shower']

    displayImage() {
        this.showerTarget.style.display = 'flex';
        this.showerTarget.children[0].src = event.target.src;
        document.documentElement.style.overflowY = 'hidden';
    }

    stopDisplayImage() {
        this.showerTarget.style.display = 'none';
        document.documentElement.style.overflowY = 'auto';
    }
}
