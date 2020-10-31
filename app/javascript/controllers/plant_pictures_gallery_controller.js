import { Controller } from "stimulus";

export default class PlantPicturesGalleryController extends Controller  {
  static targets = ["mainPicture", "thumbnail"];

  selectPicture(event) {
    const currentActiveThumnail = this.thumbnailTargets.find(thumbnail => thumbnail.dataset.active)
    const newActiveThumnail = event.currentTarget;

    currentActiveThumnail.classList.remove("plant-picture-gallery__thumbnail--selected");
    currentActiveThumnail.removeAttribute("data-active");

    newActiveThumnail.classList.add("plant-picture-gallery__thumbnail--selected");
    newActiveThumnail.setAttribute("data-active", true);

    this.mainPictureTarget.style.backgroundImage = newActiveThumnail.style.backgroundImage;
  }
}