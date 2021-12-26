// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@hotwired/turbo-rails")
require("@rails/activestorage").start();
require("channels");
// require("controllers");
require("trix");
require("@rails/actiontext");
import "./trix-editor-overrides";

import { Turbo } from "@hotwired/turbo-rails";

let select;

window.addEventListener('DOMContentLoaded', (event) => {
    select = document.getElementById("lang");

    select.addEventListener("change", () => {
        Turbo.visit(document.getElementById(`${select.value}`).dataset.url);
    });
});
