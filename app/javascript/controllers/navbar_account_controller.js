import ApplicationController from "./application_controller";
import { useClickOutside } from "stimulus-use";

export default class NavbarAccountController extends ApplicationController {
  static targets = ["dropdown"];

  connect() {
    useClickOutside(this);

    document.addEventListener("turbolinks:before-cache", () => this.dropdownTarget.hidden = true);
  }

  toggleDropdown() {
    this.dropdownTarget.hidden = !this.dropdownTarget.hidden;
  }

  clickOutside() {
    this.dropdownTarget.hidden = true;
  }
}
