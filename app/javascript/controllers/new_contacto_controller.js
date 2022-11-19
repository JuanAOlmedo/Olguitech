import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="new-contacto"
export default class extends Controller {
    static targets = ["fields"]
    id = 0
   
    addFields(event) {
        this.id++;

        let clone = this.fieldsTarget.cloneNode(true);

        clone.children[0].innerHTML = this.replaceZeroById(clone.children[0].innerHTML);
        console.log(this.changeIds(clone.children[1]));
        clone.children[1].innerHTML = this.changeIds(clone.children[1]);

        event.target.parentElement.insertBefore(clone, event.target);
    }

    changeIds(node) {
        node.children[0].innerHtml = this.replaceZeroById(node.children[0].innerHTML);
        node.children[1].attributes.name.value = this.replaceZeroById(node.children[1].attributes.name.value);
        node.children[1].attributes.id.value = this.replaceZeroById(node.children[1].attributes.id.value);

        return node.innerHTML;
    }

    replaceZeroById(str) {
        return str.replace(new RegExp('0', 'g'), this.id);
    }
}
