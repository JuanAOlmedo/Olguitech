const dropdownBars = document.querySelector("#dropdown-bars"),
      dropdown = document.querySelector("#dropdown"),
      dropdownNavLinks = document.querySelectorAll(".dropdown-navbar-link"),
      dropdownAccess = document.querySelector(".dropdown-access");

window.onclick = function (event) {
  if (
    !event.target.matches(".dropdown") &&
    dropdown.classList.contains("show")
  ) {
    dropdown.classList.remove("show");
  }
};

dropdownBars.onclick = () => {
  dropdown.classList.toggle("show");

  dropdownNavLinks.forEach((link) => {
    link.classList.toggle("show");
  });

  dropdownAccess.classList.toggle("show");
};

document.addEventListener("DOMContentLoaded", function () {
  const lazyloadImages = document.querySelectorAll("img.lazy");
  let lazyloadThrottleTimeout;

  function lazyload() {
    if (lazyloadThrottleTimeout) {
      clearTimeout(lazyloadThrottleTimeout);
    }

    lazyloadThrottleTimeout = setTimeout(function () {
      const scrollTop = window.pageYOffset;
      lazyloadImages.forEach(function (img) {
        if (img.offsetTop < window.innerHeight + scrollTop) {
          img.src = img.dataset.src;
          img.classList.remove("lazy");
        }
      });
      if (lazyloadImages.length == 0) {
        document.removeEventListener("scroll", lazyload);
        window.removeEventListener("resize", lazyload);
        window.removeEventListener("orientationChange", lazyload);
      }
    }, 20);
  }

  document.addEventListener("scroll", lazyload);
  window.addEventListener("resize", lazyload);
  window.addEventListener("orientationChange", lazyload);
  window.addEventListener("DOMContentLoaded", lazyload);
});

const articlesHoverableDiv = document.querySelector(".articles-hoverable-div");
const proyectsHoverableDiv = document.querySelector(".proyects-hoverable-div");

function lazyload2() {
  const lazyloadImages2 = document.querySelectorAll("img.articles-lazy");

  lazyloadImages2.forEach(function (img) {
    img.src = img.dataset.src;
    img.classList.remove("lazy2");
  });
}

articlesHoverableDiv.addEventListener("mouseover", lazyload2);

function lazyload3() {
  const lazyloadImages3 = document.querySelectorAll("img.proyects-lazy");

  lazyloadImages3.forEach(function (img) {
    img.src = img.dataset.src;
    img.classList.remove("lazy2");
  });
}

proyectsHoverableDiv.addEventListener("mouseover", lazyload3);

const docEl = document.documentElement;

function animateOnScroll(element) {
  const elemRect = element.getBoundingClientRect(),
    bodyRect = document.body.getBoundingClientRect(),
    offset = elemRect.top - bodyRect.top,
    scrollTop = this.pageYOffset - docEl.clientTop;

  if (offset < scrollTop + 400) {
    return true;
  } else {
    return false;
  }
}

const stills = document.querySelectorAll(".still");

function scroll() {
  stills.forEach(function (still) {
    if (animateOnScroll(still)) {
      still.classList.add("move");
    } else {
      still.classList.remove("move");
    }
  });
}

document.addEventListener("scroll", scroll);
window.addEventListener("DOMContentLoaded", scroll);
window.addEventListener("resize", scroll);
window.addEventListener("orientationChange", scroll);
