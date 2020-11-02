import ApplicationController from "./application_controller";
import consumer from "../channels/consumer"

export default class ChatController extends ApplicationController {
  static targets = ["input", "form", "messageList"];

  connect() {
    this.messageListTarget.scrollTo(0, this.messageListTarget.scrollHeight);

    consumer.subscriptions.create({ channel: "ChatChannel", id: this.element.dataset.chatId }, {
      received: (data) => {
        this.messageListTarget.insertAdjacentHTML("beforeend", data);
        this.messageListTarget.scrollTo(0, this.messageListTarget.scrollHeight);
      }
    });
  }

  clearInput() {
    setTimeout(() => this.inputTarget.value = "");
  }

  submitForm() {
    this.formTarget.submit();
    this.clearInput();
  }
}
