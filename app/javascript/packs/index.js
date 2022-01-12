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

const icon = document.querySelector(".icon-tabler-minus-vertical"),
    path = document.querySelector(".icon-tabler-minus-vertical path"),
    menu = document.querySelector(".menu"),
    children = Array.from(menu.children);
children.splice(0, 1);

if ("IntersectionObserver" in window) {
    const categoryObserver = new IntersectionObserver(
        (entries, categoryObserver) => {
            entries.forEach((entry) => {
                if (!entry.isIntersecting) {
                    entry.target.classList.remove("visible1");

                    children[
                        Number(entry.target.dataset.index)
                    ].classList.remove("visible");

                    setSvg();
                    return;
                }

                entry.target.classList.add("visible1");
                document
                    .querySelectorAll(".visible1")
                    .forEach(function (category) {
                        children[Number(category.dataset.index)].classList.add(
                            "visible"
                        );
                    });
                setSvg();
            });
        },
        { threshold: 0 }
    );

    document.querySelectorAll(".category").forEach((category) => {
        categoryObserver.observe(category);
    });
}

function setSvg() {
    const categories = Array.from(document.querySelectorAll(".visible1"));
    icon.style.height = `${
        menu.getBoundingClientRect().y + menu.getBoundingClientRect().height
    }px`;

    let categoriesIndex = [];
    categories.forEach(function (category) {
        categoriesIndex.push(Number(category.dataset.index));
    });

    let category1 =
            children[
                Math.min.apply(Math, categoriesIndex)
            ].getBoundingClientRect(),
        category2 =
            children[
                Math.max.apply(Math, categoriesIndex)
            ].getBoundingClientRect();

    const firstTitle = Array.from(
            document.querySelectorAll(".menu-title")
        )[0].getBoundingClientRect(),
        lastTitle = Array.from(document.querySelectorAll(".menu-title"))[
            document.querySelectorAll(".menu-title").length - 1
        ].getBoundingClientRect();

    let pathStart = category1.y - firstTitle.y,
        pathEnd = category2.y + category2.height - firstTitle.y,
        pathLength = pathEnd - pathStart;

    path.attributes.d.value = `
    M ${firstTitle.x} ${firstTitle.y}
    V ${lastTitle.y + lastTitle.height}
    `;

    path.setAttribute(
        "stroke-dasharray",
        `0 ${pathStart} ${pathLength} ${10000}`
    );
}

menu.addEventListener("scroll", setSvg);
