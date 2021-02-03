const closeNotice = document.querySelector(".close-notice"),
      notice = document.querySelector(".notice");

function close() {
  notice.style.display = "none";
}

closeNotice.onclick = () => {
  close();
};
closeNotice.addEventListener("keyup", actionButtonKeyupHandler);
closeNotice.addEventListener("keydown", actionButtonKeydownHandler);

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
