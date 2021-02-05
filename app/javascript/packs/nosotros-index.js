const docEl = document.documentElement;

function animateOnScroll(element, scrollTop) {
    const elemRect = element.getBoundingClientRect(),
        bodyRect = document.body.getBoundingClientRect(),
        offset = elemRect.top - bodyRect.top;

    if (offset < scrollTop + 400) {
        return true;
    } else {
        return false;
    }
}

const $profiles = document.querySelector(".profiles");

window.onscroll = function () {
    const scrollTop = this.pageYOffset - docEl.clientTop;

    if (animateOnScroll($profiles, scrollTop)) {
        $profiles.classList.add("move");
    } else {
        $profiles.classList.remove("move");
    }
};
