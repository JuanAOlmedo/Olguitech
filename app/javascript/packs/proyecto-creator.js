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

const fileInput = document.querySelector(" #fileInput"),
    imageUpload = document.querySelector(".image-upload"),
    preview = document.querySelector("#preview"),
    articleTitle = document.querySelectorAll(".article-title")[2],
    articleImg = document.querySelector(".article-img"),
    articleDescription = document.querySelector(".article-description"),
    articleText = document.querySelector(".article-text");

let formTitle = document.querySelector("#proyecto_title"),
    formDescription = document.querySelector("#proyecto_description"),
    formContent = document.querySelector("#proyecto_content"),
    formTitle2 = document.querySelector("#proyecto_title2"),
    formDescription2 = document.querySelector("#proyecto_description2"),
    formContent2 = document.querySelector("#proyecto_content2");

fileInput.onchange = () => {
    const [file] = fileInput.files;
    if (file) {
        imageUpload.src = URL.createObjectURL(file);
    }
};

preview.onclick = show;
xClicker = new Clicker(document.querySelector(".x"), stopShow).createClick();

function stopShow() {
    document.querySelector("#show").style.display = "none";
}

function show() {
    document.querySelector("#show").style.display = "block";

    articleTitle.innerHTML = formTitle.value;
    articleImg.src = imageUpload.src;
    articleDescription.innerHTML = formDescription.value;
    articleText.innerHTML = formContent.innerHTML;
}

flag1Clicker = new Clicker(
    document.querySelectorAll(".preview-flag")[0],
    changeLanguage,
    "en"
).createClick();
flag2Clicker = new Clicker(
    document.querySelectorAll(".preview-flag")[1],
    changeLanguage,
    "es"
).createClick();

function changeLanguage(lang) {
    if (lang == "es") {
        articleTitle.innerHTML = formTitle.value;
        articleDescription.innerHTML = formDescription.value;
        articleText.innerHTML = formContent.innerHTML;
    } else {
        articleTitle.innerHTML =
            formTitle2.value != "" ? formTitle2.value : formTitle.value;
        articleDescription.innerHTML =
            formDescription2.value != ""
                ? formDescription2.value
                : formDescription.value;
        articleText.innerHTML =
            formContent2.value != ""
                ? formContent2.innerHTML
                : formContent.innerHTML;
    }
}
