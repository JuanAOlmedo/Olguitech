const searchBar = document.querySelector("#searchbar");

function search() {
    let input = document.getElementById("searchbar").value.toLowerCase();
    let rows = document.getElementsByClassName("user-row");

    rows.forEach((row) => {
        if (!row.innerText.toLowerCase().includes(input)) {
            row.style.display = "none";
        } else {
            row.style.display = "table-row";
        }
    });
}

searchBar.addEventListener("input", search);
