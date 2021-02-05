// SLIDESHOW 1 //

const articles = document.querySelectorAll(".article");

const next = document.querySelector("#next");
const previous = document.querySelector("#previous");

let sliderVariable = 0;

articles[0].classList.add("show");

articles.forEach((article) => {
    article.children[1].children[0].children[2].style.display = "none";
});

articles[0].children[1].children[0].children[2].style.display = "block";

sliderVariable = 0;

next.onclick = () => {
    display(1);
};

next.addEventListener("keydown", actionButtonKeydownHandler1);
next.addEventListener("keyup", actionButtonKeyupHandler1);

previous.onclick = () => {
    display(-1);
};

window.onclick = function (event) {
    console.log(event.target);
};

previous.addEventListener("keydown", actionButtonKeydownHandler_1);
previous.addEventListener("keyup", actionButtonKeyupHandler_1);

function actionButtonKeydownHandler1(event) {
    if (event.keyCode === 32) {
        event.preventDefault();
    } else if (event.keyCode === 13) {
        event.preventDefault();
        display(1);
    }
}

function actionButtonKeyupHandler1(event) {
    if (event.keyCode === 32) {
        event.preventDefault();
        display(1);
    }
}

function actionButtonKeydownHandler_1(event) {
    if (event.keyCode === 32) {
        event.preventDefault();
    } else if (event.keyCode === 13) {
        event.preventDefault();
        display(-1);
    }
}

function actionButtonKeyupHandler_1(event) {
    if (event.keyCode === 32) {
        event.preventDefault();
        display(-1);
    }
}

function display(num) {
    articles[sliderVariable].classList.remove("show");
    articles[sliderVariable].children[1].children[0].children[2].style.display =
        "none";

    if (sliderVariable === articles.length - 1 && num === 1) {
        sliderVariable = 0;
    } else if (sliderVariable === 0 && num === -1) {
        sliderVariable = articles.length - 1;
    } else {
        sliderVariable += num;
    }

    articles[sliderVariable].classList.add("show");
    articles[sliderVariable].children[1].children[0].children[2].style.display =
        "block";
}

// SLIDESHOW 2 //

const proyects = document.querySelectorAll(".proyect");

const nextP = document.querySelector("#proyects-next");
const previousP = document.querySelector("#proyects-previous");

let sliderVariableP = 0;

proyects[0].classList.add("show");

proyects.forEach((article) => {
    article.children[0].children[0].children[2].style.display = "none";
});

proyects[0].children[0].children[0].children[2].style.display = "block";

sliderVariableP = 0;

nextP.onclick = () => {
    displayP(1);
};

nextP.addEventListener("keydown", actionButtonKeydownHandler1P);
nextP.addEventListener("keyup", actionButtonKeyupHandler1P);

previousP.onclick = () => {
    displayP(-1);
};

previousP.addEventListener("keydown", actionButtonKeydownHandler_1P);
previousP.addEventListener("keyup", actionButtonKeyupHandler_1P);

function actionButtonKeydownHandler1P(event) {
    if (event.keyCode === 32) {
        event.preventDefault();
    } else if (event.keyCode === 13) {
        event.preventDefault();
        displayP(1);
    }
}

function actionButtonKeyupHandler1P(event) {
    if (event.keyCode === 32) {
        event.preventDefault();
        displayP(1);
    }
}

function actionButtonKeydownHandler_1P(event) {
    if (event.keyCode === 32) {
        event.preventDefault();
    } else if (event.keyCode === 13) {
        event.preventDefault();
        displayP(-1);
    }
}

function actionButtonKeyupHandler_1P(event) {
    if (event.keyCode === 32) {
        event.preventDefault();
        displayP(-1);
    }
}

function displayP(num) {
    proyects[sliderVariableP].classList.remove("show");
    proyects[sliderVariableP].children[0].children[0].children[2].style.display = "none";

    if (sliderVariableP === proyects.length - 1 && num === 1) {
        sliderVariableP = 0;
    } else if (sliderVariableP === 0 && num === -1) {
        sliderVariableP = proyects.length - 1;
    } else {
        sliderVariableP += num;
    }

    proyects[sliderVariableP].classList.add("show");
    proyects[sliderVariableP].children[0].children[0].children[2].style.display = "block";
}

window.setInterval(function () {
    displayP(1);
    display(1);
}, 10000);
