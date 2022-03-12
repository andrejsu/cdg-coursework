import { Controller } from "stimulus"

export default class extends Controller {
    static targets = [ "content", "button" ]
    static values = { length: Number, content: String }

    connect() {
        this.contentValue = this.contentTarget.innerText
        if (this.contentValue.length < this.lengthValue) {
            this.buttonTarget.hidden = true
        } else {
            this.contentTarget.innerText = this.contentValue.substring(0, this.lengthValue) + "..."
        }
    }

    view() {
        this.contentTarget.innerText = this.contentValue
        this.buttonTarget.hidden = true
    }
}