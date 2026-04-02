// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "controllers";
import "trix-editor-overrides";
import "webp";
import "@hotwired/turbo-rails";
import "@hotwired/stimulus";
import "@hotwired/stimulus-loading";
import "@rails/actiontext";

// app/javascript/turnstile.js

window.onloadTurnstile = function () {
    const el = document.querySelector(".cf-turnstile");
    if (!el) return;

    turnstile.render(el, {
        sitekey: el.dataset.sitekey,
        execution: "execute",
    });
};

document.addEventListener("click", (e) => {
    if (!e.target.matches("#subscribe-btn")) return;
    e.preventDefault();

    const el = document.querySelector(".cf-turnstile");
    if (!el) return;

    turnstile.execute(el, {
        callback: () => {
            el.closest("form").requestSubmit();
        },
    });
});

document.addEventListener("turbo:before-cache", () => {
    document.querySelectorAll(".cf-turnstile").forEach((el) => {
        try {
            turnstile.remove(el);
        } catch (_) {}
        el.innerHTML = "";
    });
});
