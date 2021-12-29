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

const lazy = document.querySelectorAll(".lazy");

if ("IntersectionObserver" in window) {
    const imgObserver = new IntersectionObserver(
        (entries, imgObserver) => {
            entries.forEach((entry) => {
                if (!entry.isIntersecting) return;

                const img = entry.target;
                img.classList.remove("lazy");
                imgObserver.unobserve(entry.target);
                img.src = img.dataset.src ? img.dataset.src : img.src;
            });
        },
        {
            threshold: 0,
        }
    );

    lazy.forEach((img) => {
        imgObserver.observe(img);
    });

    const stillsObserver = new IntersectionObserver(
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

    document.querySelectorAll(".still").forEach((still) => {
        stillsObserver.observe(still);
    });
} else {
    lazy.forEach((img) => {
        img.classList.remove("lazy");
        img.src = img.dataset.src ? img.dataset.src : img.src;
    });

    document.querySelectorAll(".still").forEach((still) => {
        still.classList.add("move");
    });
}

const dropdownBars = document.querySelector("#dropdown-bars"),
    dropdown = document.querySelector(".right-navbar-section"),
    dropdownNavLinks = document.querySelectorAll(".dropdown-navbar-link"),
    dropdownAccessLinks = document.querySelectorAll(".dropdown-access");

let showing = false;

window.onclick = function (event) {
    if (
        !dropdown.contains(event.target) &&
        !dropdownBars.contains(event.target) &&
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

    document.querySelector("nav").classList.add("show-lock");

    setTimeout(() => dropdown.classList.toggle("visible"), showing ? 450 : 0);

    showing = showing ? false : true;

    if (!showing) {
        document.querySelector("nav").classList.remove("show-lock");
    }
}

const langs = document.querySelectorAll("#lang .btn");

langs.forEach((lang) => {
    lang.onclick = () => {
        document.querySelector("#lang").classList.toggle("is-active");
    }
})
