import { Controller } from "stimulus"
import { useClickOutside } from "stimulus-use";

export default class NavbarAccountController extends Controller {
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
