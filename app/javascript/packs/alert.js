const closeAlert = document.querySelector('.close-alert'),
      alert = document.querySelector('.alert');

function close() {
    alert.style.display = 'none'
}

closeAlert.onclick = () => {
    close()
}
closeAlert.addEventListener('keyup', actionButtonKeyupHandler)
closeAlert.addEventListener('keydown', actionButtonKeydownHandler)

function actionButtonKeydownHandler (event) {
    if (event.keyCode === 32) {
        event.preventDefault();
    } else if (event.keyCode === 13) {
        event.preventDefault();
        close();
    }
}
  
function actionButtonKeyupHandler (event) {
    if (event.keyCode === 32) {
        event.preventDefault();
        close();
    }
}