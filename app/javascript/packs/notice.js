const closeNotice = document.querySelector(".close-notice"),
    notice = document.querySelector(".notice");

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

function close() {
    notice.style.transition = "transform 0.5s";

    notice.classList.add("disappear");

    setTimeout(() => (notice.style.display = "none"), 1000);
}

notice.addEventListener("touchstart", startTouch, false);
notice.addEventListener("touchmove", moveTouch, false);
notice.addEventListener("touchend", endTouch, false);

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
    notice.style.transform = `translateY(${Math.sign(-diffY) * nY}px)`;
    if (ended) {
        return;
    }
    window.requestAnimationFrame(move);
}
