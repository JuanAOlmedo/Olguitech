const closeAlert = document.querySelector(".close-alert"),
      alertPrompt = document.querySelector(".alert");

closeAlert.onclick = () => {
    close();
};
closeAlert.addEventListener("keyup", actionButtonKeyupHandler);
closeAlert.addEventListener("keydown", actionButtonKeydownHandler);

function actionButtonKeydownHandler(event) {
    if (event.keyCode === 32) {
        event.preventDefault();
    } else if (event.keyCode === 13) {
        event.preventDefault();
        close();
    }
}

function actionButtonKeyupHandler(event) {
    if (event.keyCode === 32) {
        event.preventDefault();
        close();
    }
}

function close() {
    alertPrompt.classList.add("disappear")

    setTimeout(() => alertPrompt.style.display = "none", 1000)
}
