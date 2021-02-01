const backToTop = document.querySelector('#back-to-top')

window.onscroll = function() {
    if (document.documentElement.scrollTop > 100) {
        backToTop.style.display = 'block'
    } else {
        backToTop.style.display = 'none'
    }
}

backToTop.onclick = function(event) {
    event.preventDefault();
    document.animate({ scrollTop: 0 }, "slow");
}

const scrollToTop = () => {
  const c = document.documentElement.scrollTop || document.body.scrollTop;
  if (c > 0) {
    window.requestAnimationFrame(scrollToTop);
    window.scrollTo(0, c - c / 15);
  }
}

backToTop.onclick = function(e) {
    e.preventDefault();
    scrollToTop();
  }