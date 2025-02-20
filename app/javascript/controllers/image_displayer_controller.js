import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="image-displayer"
// When showing an solution, display its images bigger when they get clicked,
// and zoom them in if they get clicked again
export default class extends Controller {
    static targets = ["shower"];

    parent = null;
    displayed = false;
    zoomed = false;

    displayImage() {
        if (this.displayed) {
            this.zoom(event);
            return;
        }

        this.showerTarget.classList.add("show");
        this.parent = event.target.parentElement;
        this.parent.style.height = event.target.height + "px";
        this.showerTarget.append(event.target);
        document.documentElement.style.overflowY = "hidden";

        this.displayed = true;
    }

    stopDisplayImage() {
        const img = this.showerTarget.children[0];
        if (event.target == img) {
            return;
        }

        this.showerTarget.classList.remove("show");
        this.zoomOut(img);
        this.parent.prepend(img);
        this.parent.style.height = "";
        document.documentElement.style.overflowY = "auto";

        this.displayed = false;
    }

    zoom(e) {
        if (this.zoomed) {
            this.zoomOut(e.target);
            return;
        }

        const bounds = e.target.getBoundingClientRect(),
            transformX = bounds.x + bounds.width * 0.5 - e.clientX,
            transformY = bounds.y + bounds.height * 0.5 - e.clientY;

        e.target.style.transform = `translateX(${transformX}px)
                                    translateY(${transformY}px)
                                    scale(2)`;
        e.target.style.cursor = "zoom-out";

        this.zoomed = true;
    }

    zoomOut(img) {
        img.style.transform = "";
        img.style.cursor = "";
        this.zoomed = false;
    }
}
