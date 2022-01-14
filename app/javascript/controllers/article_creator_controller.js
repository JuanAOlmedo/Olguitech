import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="article-creator"
export default class extends Controller {
    static targets = [ "fileInput", "image", "preview", 
                        "articleTitle", "articleImg", "articleDescription", "articleText",
                        "formTitle", "formTitle2", "formDescription", "formDescription2", "formText", "formText2" ]

    connect() {
    }

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
        this.articleDescriptionTarget.innerHTML = this.formDescriptionTarget.value;
        this.articleTextTarget.innerHTML = this.formTextTarget.innerHTML;
    }

    stopShowingPreview() {
        this.previewTarget.style.display = "none";
    }
}

// function changeLanguage(lang) {
//     if (true) {
//         articleTitle.innerHTML = formTitle.value;
//         articleDescription.innerHTML = formDescription.value;
//         articleText.innerHTML = formContent.innerHTML;
//     } else {
//         articleTitle.innerHTML =
//             formTitle2.value != "" ? formTitle2.value : formTitle.value;
//         articleDescription.innerHTML =
//             formDescription2.value != ""
//                 ? formDescription2.value
//                 : formDescription.value;
//         articleText.innerHTML =
//             formContent2.value != ""
//                 ? formContent2.innerHTML
//                 : formContent.innerHTML;
//     }
// }