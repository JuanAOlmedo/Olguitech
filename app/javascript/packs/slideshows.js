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

// SLIDESHOW 1 //
const articles = document.querySelectorAll(".article");

if (articles.length > 0) {
    const next = document.querySelector("#next");
    const previous = document.querySelector("#previous");

    let sliderVariable = 0;

    articles[0].classList.add("show");

    articles.forEach((article) => {
        article.children[1].children[0].children[3].style.display = "none";
    });

    articles[0].children[1].children[0].children[3].style.display = "block";

    sliderVariable = 0;

    nextClicker = new Clicker(next, display, 1);
    nextClicker.createClick();

    previousClicker = new Clicker(previous, display, -1);
    previousClicker.createClick();

    function display(num) {
        if (articles.length > 1) {
            articles[sliderVariable].classList.remove("show");
            articles[
                sliderVariable
            ].children[1].children[0].children[3].style.display = "none";

            if (sliderVariable === articles.length - 1 && num === 1) {
                sliderVariable = 0;
            } else if (sliderVariable === 0 && num === -1) {
                sliderVariable = articles.length - 1;
            } else {
                sliderVariable += num;
            }

            articles[sliderVariable].classList.add("show");
            articles[
                sliderVariable
            ].children[1].children[0].children[3].style.display = "block";
        }
    }

    window.setInterval(function () {
        display(1);
    }, 10000);
}
// SLIDESHOW 2 //

const proyects = document.querySelectorAll(".proyect");

if (proyects.length > 0) {
    const nextP = document.querySelector("#proyects-next");
    const previousP = document.querySelector("#proyects-previous");

    let sliderVariableP = 0;

    proyects[0].classList.add("show");

    proyects.forEach((article) => {
        article.children[0].children[0].children[3].style.display = "none";
    });

    proyects[0].children[0].children[0].children[3].style.display = "block";

    sliderVariableP = 0;

    nextPClicker = new Clicker(nextP, displayP, 1);
    nextPClicker.createClick();

    previousPClicker = new Clicker(previousP, displayP, -1);
    previousPClicker.createClick();

    function displayP(num) {
        if (proyects.length > 1) {
            proyects[sliderVariableP].classList.remove("show");
            proyects[
                sliderVariableP
            ].children[0].children[0].children[3].style.display = "none";

            if (sliderVariableP === proyects.length - 1 && num === 1) {
                sliderVariableP = 0;
            } else if (sliderVariableP === 0 && num === -1) {
                sliderVariableP = proyects.length - 1;
            } else {
                sliderVariableP += num;
            }

            proyects[sliderVariableP].classList.add("show");
            proyects[
                sliderVariableP
            ].children[0].children[0].children[3].style.display = "block";
        }
    }

    window.setInterval(function () {
        displayP(1);
    }, 10000);
}
