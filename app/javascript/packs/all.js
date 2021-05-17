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

const dropdownClickable = document.querySelectorAll(
        ".dropdown-clickable-div"
    )[0],
    dropdownExtensible = document.querySelectorAll(
        ".dropdown-clickable-extensible"
    )[0],
    dropdownClickable1 = document.querySelectorAll(
        ".dropdown-clickable-div"
    )[1],
    dropdownExtensible1 = document.querySelectorAll(
        ".dropdown-clickable-extensible"
    )[1];

const dropdownBars = document.querySelector("#dropdown-bars"),
    dropdown = document.querySelector("#dropdown"),
    dropdownNavLinks = document.querySelectorAll(".dropdown-navbar-link"),
    dropdownAccessLinks = document.querySelectorAll(".dropdown-access");

let showing = false;

window.onclick = function (event) {
    if (
        !event.target.matches(".dropdown") &&
        !event.target.matches(".dropdown-clickable") &&
        dropdown.classList.contains("show")
    ) {
        dropdownClickHandler();
    }
};

dropdownBarsClicker = new Clicker(dropdownBars, dropdownClickHandler);
dropdownBarsClicker.createClick();

function dropdownClickHandler() {
    dropdown.classList.toggle("show");
    document.querySelector(".line1").classList.toggle("move");
    document.querySelector(".line2").classList.toggle("move");

    setTimeout(() => showLinks(), showing ? 400 : 0);

    showing = showing ? false : true;

    if (!showing) {
        dropdownExtensible.classList.remove("extend");
        document
            .querySelectorAll(".icon-tabler-chevron-down")[0]
            .classList.remove("extend");

        dropdownExtensible.classList.remove("de-extend");
        extended = false;

        dropdownExtensible1.classList.remove("extend");
        document
            .querySelectorAll(".icon-tabler-chevron-down")[1]
            .classList.remove("extend");

        dropdownExtensible1.classList.remove("de-extend");
        extended1 = false;
    }
}

function showLinks() {
    dropdownNavLinks.forEach((link) => {
        link.classList.toggle("show");
    });

    dropdownAccessLinks.forEach((link) => {
        link.classList.toggle("show");
    });
}

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

dropdownClickableClicker = new Clicker(dropdownClickable, extend).createClick();

let extended = false;

function extend() {
    lazyLoad4();

    dropdownExtensible.classList.toggle("extend");
    document
        .querySelectorAll(".icon-tabler-chevron-down")[0]
        .classList.toggle("extend");

    if (extended) {
        dropdownExtensible.classList.add("de-extend");
        setTimeout(() => dropdownExtensible.classList.remove("de-extend"), 800);
        extended = false;
    } else {
        extended = true;
    }
}

dropdownClickableClicker1 = new Clicker(
    dropdownClickable1,
    extend1
).createClick();

let extended1 = false;

function extend1() {
    lazyLoad5();

    dropdownExtensible1.classList.toggle("extend");
    document
        .querySelectorAll(".icon-tabler-chevron-down")[1]
        .classList.toggle("extend");

    if (extended1) {
        dropdownExtensible1.classList.add("de-extend");
        setTimeout(
            () => dropdownExtensible1.classList.remove("de-extend"),
            800
        );
        extended1 = false;
    } else {
        extended1 = true;
    }
}

function lazyLoad4() {
    const lazyLoadImages2 = document.querySelectorAll("img.articles-lazy2");

    lazyLoadImages2.forEach(function (img) {
        img.src = img.dataset.src;
        img.classList.remove("articles-lazy2");
    });
}

function lazyLoad5() {
    const lazyLoadImages2 = document.querySelectorAll("img.proyects-lazy2");

    lazyLoadImages2.forEach(function (img) {
        img.src = img.dataset.src;
        img.classList.remove("proyects-lazy2");
    });
}

// var userLang = navigator.language || navigator.userLanguage; 
// alert ("The language is: " + userLang);
