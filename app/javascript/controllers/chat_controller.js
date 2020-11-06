import ApplicationController from "./application_controller";
import consumer from "../channels/consumer"
import StimulusReflex from 'stimulus_reflex'

export default class ChatController extends ApplicationController {
  static targets = ["input", "form", "messageList"];

  connect() {
    StimulusReflex.register(this)
    this.scrollDown();

    consumer.subscriptions.create({ channel: "ChatChannel", id: this.element.dataset.chatId }, {
      received: (data) => {
        this.stimulate().then(() => this.scrollDown());
      }
    });
  }

  submitWithReflex(event) {
    event.preventDefault();

    this.stimulate("Messages#create", this.formTarget);
  }

  scrollDown() {
    this.messageListTarget.scrollTo(0, this.messageListTarget.scrollHeight);
  }

  afterCreate() {
    this.scrollDown();
    this.inputTarget.value = "";
  }
}
