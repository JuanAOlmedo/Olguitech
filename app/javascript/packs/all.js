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

    document.querySelectorAll(".lazy").forEach((img) => {
        imgObserver.observe(img);
    });

    const stillsObserver = new IntersectionObserver(
        (entries, stillsObserver) => {
            entries.forEach((entry) => {
                const still = entry.target;
                if (!entry.isIntersecting) {
                    still.classList.remove("move");
                    return;
                }

                still.classList.add("move");
            });
        },
        {
            threshold: 0.2,
        }
    );

    document.querySelectorAll(".still").forEach((still) => {
        stillsObserver.observe(still);
    });
} else {
    document.querySelectorAll("lazy").forEach((img) => {
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

function defineElementOffset(element, change) {
    const scrollTop = window.pageYOffset;

    if (element.offsetTop < window.innerHeight + scrollTop - change) {
        return true;
    } else {
        return false;
    }
}

const articlesHoverableDiv = document.querySelector(".articles-hoverable-div"),
    proyectsHoverableDiv = document.querySelector(".proyects-hoverable-div");

class Clickable {
    constructor(element, chevron, dropdownExtensible) {
        this.element = element;
        this.chevron = chevron;
        this.dropdownExtensible = dropdownExtensible;
        this.extended = false;

        elementClicker = new Clicker(
            this.element,
            this.extend,
            this
        ).createClick();
    }

    extend(thisClass) {
        thisClass.dropdownExtensible.classList.toggle("extend");
        thisClass.chevron.classList.toggle("extend");

        if (thisClass.extended) {
            thisClass.dropdownExtensible.classList.add("de-extend");
            setTimeout(
                () =>
                    thisClass.dropdownExtensible.classList.remove("de-extend"),
                800
            );
            thisClass.extended = false;
        } else {
            thisClass.extended = true;
        }
    }
}

const dropdownClickables = document.querySelectorAll(".hoverable"),
    chevrons = document.querySelectorAll(".icon-tabler-chevron-down"),
    dropdownExtensibles = document.querySelectorAll(".hoverable-content");

let i;
for (i = 0; i < dropdownClickables.length; i++) {
    dropdownClickable = new Clickable(
        dropdownClickables[i],
        chevrons[i],
        dropdownExtensibles[i]
    );
}

let anchors = document.querySelectorAll("#articles-hoverable"),
    menus = document.querySelectorAll(".hoverable-content"),
    hoverables = document.querySelectorAll(".hoverable"),
    triangles = document.querySelectorAll(".triangle");

function setSvg(anchor, menu, triangle) {
    tParent = triangle.parentElement;
    tParent.style.height = `${menu.y}px`;
    tParent.style.width = `${menu.x + menu.width}px`;
    tParent.style.top = `${0}px`;
    tParent.style.left = `${0}px`;

    tParent.style.display = "block";

    triangle.attributes.d.value = `
    M ${anchor.x} ${anchor.y}
    Q ${anchor.x} ${menu.y}
      ${menu.x} ${menu.y}
    h ${menu.width}
    Q ${anchor.x + anchor.width} ${menu.y}
      ${anchor.x + anchor.width} ${anchor.y}
    V ${menu.y}
    h ${-anchor.width}
    z`;
}

function deSetSvg(triangle) {
    triangle.parentElement.style.display = "none";
}

let i2;
for (i2 = 0; i2 < hoverables.length; i2++) {
    setMouseOver(i2);
}

function setMouseOver(index) {
    hoverables[index].onmouseover = function () {
        setSvg(
            anchors[index].getBoundingClientRect(),
            menus[index].getBoundingClientRect(),
            triangles[index]
        );
    };

    hoverables[index].onmouseout = function () {
        deSetSvg(triangles[index]);
    };
}
