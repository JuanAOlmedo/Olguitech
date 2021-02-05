window.addEventListener("trix-file-accept", function (event) {
    const acceptedTypes = ["image/jpeg", "image/png"];
    if (!acceptedTypes.includes(event.file.type)) {
        event.preventDefault();
        alert("Solo se soportan imagenes de tipo jpeg o png");
    }
});
