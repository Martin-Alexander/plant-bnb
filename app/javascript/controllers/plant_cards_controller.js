import ApplicationController from "./application_controller";

export default class PlantCardsController extends ApplicationController {
  static targets = ["card", "spinner", "container"];

  connect() {
    this.containerTarget.style.display = "none";
  
    const backgroundImagesDownloaded = this.cardTargets.map((plantPhotoDiv) => {
      return new Promise((res, rej) => {
        const image = new Image();
        image.src = plantPhotoDiv.dataset.backgroundImageUrl; 
        image.onload = () => res();
        image.onerror = () => rej();
        plantPhotoDiv.style.backgroundImage = `url(${plantPhotoDiv.dataset.backgroundImageUrl})`;
      });
    })

    Promise.all(backgroundImagesDownloaded).then(() => {
      this.containerTarget.style.display = "flex";
    }).catch(() => this.containerTarget.style.display = "flex");
  }
}
