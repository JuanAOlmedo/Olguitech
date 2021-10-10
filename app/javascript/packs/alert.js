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
    alertPrompt.style.transition = "transform 0.5s";

    alertPrompt.classList.add("disappear");

    setTimeout(() => (alertPrompt.style.display = "none"), 1000);
}

alertPrompt.addEventListener("touchstart", startTouch, false);
alertPrompt.addEventListener("touchmove", moveTouch, false);
alertPrompt.addEventListener("touchend", endTouch, false);

let initialY = null,
    currentY = null,
    diffY = null,
    nY = null,
    ended = false;

function startTouch(e) {
    ended = false;
    initialY = e.touches[0].clientY;
    window.requestAnimationFrame(move);
}

function moveTouch(e) {
    if (initialY === null) {
        return;
    }

    currentY = e.touches[0].clientY;
    diffY = initialY - currentY;
    nY = 30 - (1 / 1.12) ** (Math.abs(diffY) - 30);

    e.preventDefault();
}

function endTouch() {
    if (diffY > 12) {
        close();
    }

    diffY = 0;
    nYY = 0;
    ended = true;
}

function move() {
    alertPrompt.style.transform = `translateY(${Math.sign(-diffY) * nY}px)`;
    if (ended) {
        return;
    }
    window.requestAnimationFrame(move);
}
