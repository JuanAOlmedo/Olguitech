const searchBar = document.querySelector("#searchbar");

function search() {
    let input = document.getElementById("searchbar").value;
    input = input.toLowerCase();
    let x = document.getElementsByClassName("user-row");

    for (i = 0; i < x.length; i++) {
        if (!x[i].innerText.toLowerCase().includes(input)) {
        x[i].style.display = "none";
        } else {
        x[i].style.display = "table-row";
        }
    }
}

searchBar.addEventListener("input", search);