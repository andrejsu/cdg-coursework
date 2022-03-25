import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
    static targets = ["switcher"]
    static values = { url: String, params: String }

    on() {
        Rails.ajax({
            type: 'POST',
            url: this.urlValue,
            data: this.paramsValue,
            dataType: 'json',
            success: (data) => {
                this.switcherTarget.outerHTML = data.entries
            }
        })
    }

    off() {
        Rails.ajax({
            type: 'DELETE',
            url: this.urlValue,
            dataType: 'json',
            success: (data) => {
                this.switcherTarget.outerHTML = data.entries
            }
        })
    }
}