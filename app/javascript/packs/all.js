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

if ('IntersectionObserver' in window) {
    const imgObserver = new IntersectionObserver(
        (entries, imgObserver) => {
            entries.forEach((entry) => {
                if (!entry.isIntersecting) return;

                const img = entry.target;
                img.src = img.dataset.src ? img.dataset.src : img.src;
                imgObserver.unobserve(entry.target);
                img.classList.remove("lazy");
            });
        },
        { threshold: 0 }
    );

    document.querySelectorAll("img.lazy").forEach((img) => {
        imgObserver.observe(img);
    });
}  else {
    document.querySelectorAll("img.lazy").forEach((img) => {
        img.src = img.dataset.src ? img.dataset.src : img.src;
        img.classList.remove("lazy");
    });
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
    )[1],
    dropdownBars = document.querySelector("#dropdown-bars"),
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

let navBool = false;

function dropdownClickHandler() {
    dropdown.classList.toggle("show");
    document.querySelector(".line1").classList.toggle("move");
    document.querySelector(".line2").classList.toggle("move");

    document.querySelector("nav").classList.add("show-lock")
    

    setTimeout(() => dropdown.classList.toggle("visible"), showing ? 450 : 0);

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

        document.querySelector("nav").classList.remove("show-lock")
    }
}

function defineElementOffset(element, change) {
    const scrollTop = window.pageYOffset;

    if (element.offsetTop < window.innerHeight + scrollTop - change) {
        return true;
    } else {
        return false;
    }
}

const articlesHoverableDiv = document.querySelector(".articles-hoverable-div"),
    proyectsHoverableDiv = document.querySelector(".proyects-hoverable-div"),
    stills = document.querySelectorAll(".still");

function scroll() {
    stills.forEach(function (still) {
        if (defineElementOffset(still, 200)) {
            still.classList.add("move");
        } else {
            still.classList.remove("move");
        }
    });
}

if (stills.length > 0) {
    document.addEventListener("scroll", scroll);
    window.addEventListener("DOMContentLoaded", scroll);
    window.addEventListener("resize", scroll);
    window.addEventListener("orientationChange", scroll);

    scroll();
}

dropdownClickableClicker = new Clicker(dropdownClickable, extend).createClick();

let extended = false;

function extend() {
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
