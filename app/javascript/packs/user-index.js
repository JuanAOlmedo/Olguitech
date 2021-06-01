class Clicker {
    constructor(element, action, parameters = null) {
        this.element = element;
        this.action = action;
        this.parameters = parameters;

        this.createClick = function () {
            element.tabIndex = 0;
            element.style.cursor = "pointer";

            if (parameters == "event") {
                element.onclick = function (e) {
                    action(e);
                };
                element.onkeydown = function (event) {
                    if (event.keyCode == 32 || event.keyCode == 13) {
                        event.preventDefault();
                        action(event);
                    }
                };
            } else {
                element.onclick = function () {
                    action(parameters);
                };
                element.onkeydown = function (event) {
                    if (event.keyCode == 32 || event.keyCode == 13) {
                        event.preventDefault();
                        action(parameters);
                    }
                };
            }
        };
    }
}

document.querySelectorAll(".times-contacted").forEach(function (contacted) {
    contactClicker = new Clicker(contacted, clickerHandler, "event");
    contactClicker.createClick();
});

document.querySelectorAll(".icon-tabler-x").forEach(function (x) {
    xClicker = new Clicker(x, xClickerHandler, "event");
    xClicker.createClick();
});

function clickerHandler(e) {
    const id = e.target.dataset.id;
    const info = document.querySelector("#article-" + id);
    if (info) {
        info.style.display = "block";
    }
}

function xClickerHandler(e) {
    const id = e.target.dataset.id;
    const info = document.querySelector("#article-" + id);
    if (info) {
        info.style.display = "none";
    }
}

const searchBar = document.querySelector("#searchbar");

function search() {
    let input = document.getElementById("searchbar").value.toLowerCase();
    let rows = document.querySelectorAll(".user-row");

    rows.forEach((row) => {
        if (!row.innerText.toLowerCase().includes(input)) {
            row.style.display = "none";
        } else {
            row.style.display = "table-row";
        }
    });
}

searchBar.addEventListener("input", search);
