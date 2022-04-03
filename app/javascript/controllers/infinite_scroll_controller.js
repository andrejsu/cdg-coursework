import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
    static targets = ["entries"]
    static values = {url: String}

    scroll() {
        const {scrollTop, scrollHeight, clientHeight} = document.documentElement

        if (clientHeight + scrollTop >= scrollHeight - 200) {
            this.loadMore()
        }
    }

    loadMore() {
        if (this.loading || this.urlValue === "/?page=") { return }
        this.loading = true

        Rails.ajax({
            type: 'GET',
            url: this.urlValue,
            dataType: 'json',
            success: (data) => {
                this.entriesTarget.insertAdjacentHTML("beforeend", data.entries)
                this.urlValue = data.pagy.next_url
                console.log(data.pagy.next_url)
                this.loading = false
            }
        })
    }
}