const nav = document.querySelector("nav");

function navbar() {
    if (window.pageYOffset > 50) {
        nav.classList.add("show");
    } else {
        nav.classList.remove("show");
    }
}

document.addEventListener("scroll", navbar);
window.addEventListener("DOMContentLoaded", navbar);
window.addEventListener("resize", navbar);
window.addEventListener("orientationChange", navbar);