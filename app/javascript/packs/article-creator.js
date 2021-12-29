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
    articleTitle = document.querySelector(".a-title"),
    articleImg = document.querySelector(".article-img"),
    articleDescription = document.querySelector(".subtitle"),
    articleText = document.querySelector(".article-text");

let formTitle = document.querySelector("#title-1"),
    formDescription = document.querySelector("#desc-1"),
    formContent = document.querySelector("#content-1"),
    formTitle2 = document.querySelector("#title-2"),
    formDescription2 = document.querySelector("#desc-2"),
    formContent2 = document.querySelector("#content-2");

fileInput.onchange = () => {
    const [file] = fileInput.files;
    if (file) {
        imageUpload.src = URL.createObjectURL(file);
    }
};
previewClicker = new Clicker(preview, show).createClick();

function stopShow() {
    document.querySelector("#preview-div").style.display = "none";
}

function show() {
    document.querySelector("#preview-div").style.display = "block";

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
    if (true) {
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
