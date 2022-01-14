import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="intersection-observer"
export default class extends Controller {
    initialize() {
        if ("IntersectionObserver" in window) {
            this.imgObserver = new IntersectionObserver(
                (entries, imgObserver) => {
                    entries.forEach((entry) => {
                        if (!entry.isIntersecting) return;
        
                        const img = entry.target;
                        img.classList.remove("lazy");
                        imgObserver.unobserve(img);
                        img.src = img.dataset.src ? img.dataset.src : img.src;
                    });
                },
                {
                    threshold: 0,
                }
            );
        
            this.stillsObserver = new IntersectionObserver(
                (entries, stillsObserver) => {
                    entries.forEach((entry) => {
                        const still = entry.target;
                        if (!entry.isIntersecting) {
                            return;
                        }
        
                        still.classList.add("move");
                        stillsObserver.unobserve(entry.target);
                    });
                },
                {
                    threshold: 0.1,
                }
            );
        }
    }
    
    connect() {
        this.lazy = document.querySelectorAll(".lazy");
        this.stills = document.querySelectorAll(".still");

        if ("IntersectionObserver" in window) {
            this.lazy.forEach((img) => {
                this.imgObserver.observe(img);
            });
            
            this.stills.forEach((still) => {
                this.stillsObserver.observe(still);
            });
        } else {
            this.lazy.forEach((img) => {
                img.classList.remove("lazy");
                img.src = img.dataset.src ? img.dataset.src : img.src;
            });
            
            this.stills.forEach((still) => {
                still.classList.add("move");
            });
        }
    }
}
