const dropdownBars = document.querySelector("#dropdown-bars"),
    dropdown = document.querySelector("#dropdown"),
    dropdownNavLinks = document.querySelectorAll(".dropdown-navbar-link"),
    dropdownAccess = document.querySelector(".dropdown-access");

window.onclick = function (event) {
    if (
        !event.target.matches(".dropdown") &&
        dropdown.classList.contains("show")
    ) {
        dropdown.classList.remove("show");
    }
};


dropdownBars.onclick = () => {
    dropdown.classList.toggle("show");

    dropdownNavLinks.forEach((link) => {
        link.classList.toggle("show");
    });

    dropdownAccess.classList.toggle("show");
};

const lazyLoadImages = document.querySelectorAll("img.lazy");
let lazyLoadThrottleTimeout;

function lazyLoad() {
    if (lazyLoadThrottleTimeout) {
        clearTimeout(lazyLoadThrottleTimeout);
    }

    lazyLoadThrottleTimeout = setTimeout(function () {
        lazyLoadImages.forEach(function (img) {
            if (defineElementOffset(img, 0)) {
                img.src = img.dataset.src;
                img.classList.remove("lazy");
            }
        });
        if (lazyLoadImages.length == 0) {
            document.removeEventListener("scroll", lazyLoad);
            window.removeEventListener("resize", lazyLoad);
            window.removeEventListener("orientationChange", lazyLoad);
        }
    }, 20);
}

function defineElementOffset(element, change) {
    const scrollTop = window.pageYOffset;

    if (element.offsetTop < window.innerHeight + scrollTop - change) {
        return true;
    } else {
        return false;
    }
}

document.addEventListener("scroll", lazyLoad);
window.addEventListener("resize", lazyLoad);
window.addEventListener("orientationChange", lazyLoad);
window.addEventListener("DOMContentLoaded", lazyLoad);

const articlesHoverableDiv = document.querySelector(".articles-hoverable-div");
const proyectsHoverableDiv = document.querySelector(".proyects-hoverable-div");

function lazyLoad2() {
    const lazyLoadImages2 = document.querySelectorAll("img.articles-lazy");

    lazyLoadImages2.forEach(function (img) {
        img.src = img.dataset.src;
        img.classList.remove("lazy2");
    });
}

articlesHoverableDiv.addEventListener("mouseover", lazyLoad2);

function lazyLoad3() {
    const lazyLoadImages3 = document.querySelectorAll("img.proyects-lazy");

    lazyLoadImages3.forEach(function (img) {
        img.src = img.dataset.src;
        img.classList.remove("lazy2");
    });
}

proyectsHoverableDiv.addEventListener("mouseover", lazyLoad3);

const stills = document.querySelectorAll(".still");

function scroll() {
    stills.forEach(function (still) {
        if (defineElementOffset(still, 200)) {
            still.classList.add("move");
        } else {
            still.classList.remove("move");
        }
    });
}

document.addEventListener("scroll", scroll);
window.addEventListener("DOMContentLoaded", scroll);
window.addEventListener("resize", scroll);
window.addEventListener("orientationChange", scroll);
