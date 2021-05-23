const fileInput = document.querySelector(" #fileInput"),
    imageUpload = document.querySelector(".image-upload");

fileInput.onchange = () => {
    const [file] = fileInput.files;
    if (file) {
        imageUpload.src = URL.createObjectURL(file);
    }
};