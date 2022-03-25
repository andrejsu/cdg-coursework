import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
    static targets = [ "comments", "content", "button" ]
    static classes = [ "disabled" ]
    static values = { url: String }

    connect() {
        this.buttonTarget.classList.add(this.disabledClass)
    }

    active() {
        if (this.contentTarget.value === "") {
            this.buttonTarget.classList.add(this.disabledClass)
        } else {
            this.buttonTarget.classList.remove(this.disabledClass)
        }
    }

    post() {
        Rails.ajax({
            type: 'POST',
            url: this.urlValue,
            data: `comment[content]=${this.contentTarget.value}`,
            dataType: 'json',
            success: (data) => {
                this.commentsTarget.insertAdjacentHTML("beforeend", data.entries);
                this.contentTarget.value = ""
            }
        })
    }
}