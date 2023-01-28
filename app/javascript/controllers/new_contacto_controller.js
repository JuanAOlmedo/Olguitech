import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-contacto"
export default class extends Controller {
    static targets = ["select", "article", "project", "product"]
    id = -1

    duplicateFrametag(event) {
        if (this.id >= 2) return;
        let clone = event.target.parentElement.cloneNode(true);

        event.target.parentElement.insertAdjacentElement('afterend', clone);
        clone.src = window.location.href;
        clone.reload();
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

    frametagChange(event) {
        let form = event.target.querySelector('.form');

        if (form) {
            this.id++;

            form.children[0].innerHTML = this.replaceZeroById(form.children[0].innerHTML);
            form.children[1].innerHTML = this.changeIds(form.children[1]);
            this.changeDisplayedArticles(form.querySelector('select'));
        }
    }

    selectChange(event) {
        this.changeDisplayedArticles(event.target);
    }

    changeDisplayedArticles(select) {
        let id = select.dataset.id;

        console.log(this.articleTargets);
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
