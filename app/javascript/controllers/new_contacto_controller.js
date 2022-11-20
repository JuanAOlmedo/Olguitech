import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="new-contacto"
export default class extends Controller {
    static targets = ["fields", "select", "article", "project", "product"]
    id = 0
   
    initialize() {
        this.selectTargets.forEach(select => {
            this.changeDisplayedArticles(select);
        });
    }

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

    selectChange(event) {
        this.changeDisplayedArticles(event.target);
    }

    changeDisplayedArticles(select) {
        let id = select.dataset.id;

        if (this.articleTargets[id].name != '') {
            select.dataset.name = this.articleTargets[id].name;
        }

        this.remove(this.articleTargets[id]);
        this.remove(this.projectTargets[id]);
        this.remove(this.productTargets[id]);

        switch (select.selectedOptions[0].value) {
            case 'Article':
                this.add(this.articleTargets[id], select.dataset.name);
                break;
            case 'Project':
                this.add(this.projectTargets[id], select.dataset.name);
                break;
            case 'Product':
                this.add(this.productTargets[id], select.dataset.name);
                break;
        }
    }

    remove(node) {
        node.style.display = 'none';
        node.name = '';
    }

    add(node, name) {
        node.style.display = 'block';
        node.name = name;
    }
}
