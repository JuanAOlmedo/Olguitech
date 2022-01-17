import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="article-creator"
export default class extends Controller {
    static targets = [
        "fileInput",
        "image",
        "preview",
        "articleTitle",
        "articleImg",
        "articleDescription",
        "articleText",
        "formTitle",
        "formTitle2",
        "formDescription",
        "formDescription2",
        "formText",
        "formText2",
    ];

    displayNewImage() {
        const [file] = this.fileInputTarget.files;
        if (file) {
            this.imageTarget.src = URL.createObjectURL(file);
        }
    }

    showPreview() {
        this.previewTarget.style.display = "block";

        this.articleTitleTarget.innerHTML = this.formTitleTarget.value;
        this.articleImgTarget.src = this.imageTarget.src;
        this.articleDescriptionTarget.innerHTML =
            this.formDescriptionTarget.value;
        this.articleTextTarget.innerHTML = this.formTextTarget.innerHTML;
    }

    stopShowingPreview() {
        this.previewTarget.style.display = "none";
    }

    changeLanguage(lang) {
        if (lang == "es") {
            this.articleTitleTarget.innerHTML = this.formTitleTarget.value;
            this.articleDescriptionTarget.innerHTML =
                this.formDescriptionTarget.value;
            this.articleTextTarget.innerHTML = this.formTextTarget.innerHTML;
        } else {
            this.articleTitleTarget.innerHTML =
                this.formTitle2Target.value != ""
                    ? this.formTitleTarget2.value
                    : this.formTitleTarget.value;
            this.articleDescriptionTarget.innerHTML =
                this.formDescription2Target.value != ""
                    ? this.formDescription2Target.value
                    : this.formDescriptionTarget.value;
            this.articleTextTarget.innerHTML =
                this.formText2Target.innerHTML != ""
                    ? this.formText2Target.innerHTML
                    : this.formTextTarget.innerHTML;
        }
    }
}
