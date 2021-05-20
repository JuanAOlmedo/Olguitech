class Clicker {
    constructor(element, action, parameters = null) {
        this.element = element;
        this.action = action;
        this.parameters = parameters;

        this.createClick = function () {
            element.tabIndex = 0;
            element.style.cursor = "pointer";

            element.onclick = function () {
                action(parameters);
            };

            element.onkeydown = function (event) {
                if (event.keyCode == 32 || event.keyCode == 13) {
                    event.preventDefault();
                    action(parameters);
                }
            };
        };
    }
}

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

// SLIDESHOW 1 //
const articles = document.querySelectorAll(".article");

if (articles.length > 1) {
    const next = document.querySelector("#next");
    const previous = document.querySelector("#previous");

    let sliderVariable = 0;

    articles[0].classList.add("show");
    articles[0].classList.add("visible");
    articles[0].classList.add("visible-fix");

    sliderVariable = 0;

    nextClicker = new Clicker(next, display, 1);
    nextClicker.createClick();

    previousClicker = new Clicker(previous, display, -1);
    previousClicker.createClick();

    function display(num) {
        let article = articles[sliderVariable];

        article.classList.remove("show");
        article.classList.remove("visible-fix");
        func(article);

        function func(element) {
            setTimeout(() => element.classList.remove("visible"), 500);
        }

        if (sliderVariable === articles.length - 1 && num === 1) {
            sliderVariable = 0;
        } else if (sliderVariable === 0 && num === -1) {
            sliderVariable = articles.length - 1;
        } else {
            sliderVariable += num;
        }

        let article2 = articles[sliderVariable];

        article2.classList.add("show");
        article2.classList.add("visible");
        article2.classList.add("visible-fix");
    }

    window.setInterval(function () {
        display(1);
    }, 10000);
} else if (articles.length > 0) {
    articles[0].classList.add("show");
    articles[0].classList.add("visible");
}
// SLIDESHOW 2 //

const proyects = document.querySelectorAll(".proyect");

if (proyects.length > 1) {
    const nextP = document.querySelector("#proyects-next");
    const previousP = document.querySelector("#proyects-previous");

    let sliderVariable = 0;

    proyects[0].classList.add("show");
    proyects[0].classList.add("visible");
    proyects[0].classList.add("visible-fix");

    sliderVariable = 0;

    nextPClicker = new Clicker(nextP, displayP, 1);
    nextPClicker.createClick();

    previousPClicker = new Clicker(previousP, displayP, -1);
    previousPClicker.createClick();

    function displayP(num) {
        let article = proyects[sliderVariable];

        article.classList.remove("show");
        article.classList.remove("visible-fix");
        func(article);

        function func(element) {
            setTimeout(() => element.classList.remove("visible"), 500);
        }

        if (sliderVariable === proyects.length - 1 && num === 1) {
            sliderVariable = 0;
        } else if (sliderVariable === 0 && num === -1) {
            sliderVariable = proyects.length - 1;
        } else {
            sliderVariable += num;
        }

        let article2 = proyects[sliderVariable];

        article2.classList.add("show");
        article2.classList.add("visible");
        article2.classList.add("visible-fix");
    }

    window.setInterval(function () {
        displayP(1);
    }, 10000);
} else if (proyects.length > 0) {
    proyects[0].classList.add("show");
    proyects[0].classList.add("visible");
}
