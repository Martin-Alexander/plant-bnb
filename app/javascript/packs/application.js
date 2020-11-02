require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "select2/dist/css/select2.min.css";

import jQuery from "jquery";
window.$ = jQuery;

import "controllers"
import { setupSelect2, tearDownSelect2 } from "../components/select2";

document.addEventListener("turbolinks:load", () => setupSelect2());
document.addEventListener("turbolinks:before-cache", () => tearDownSelect2());