import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ["score"]
    static values = {score: Number}

    add() {
        this.scoreValue++
    }

    subtract() {
        this.scoreValue--
    }

    scoreValueChanged() {
        this.showCurrentScore()
    }

    showCurrentScore() {
        this.scoreTarget.innerText = this.scoreValue
    }
}