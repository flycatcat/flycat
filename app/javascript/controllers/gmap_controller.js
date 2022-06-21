import { Controller } from "stimulus";
import { geolocateUser, getdistance } from "lib/gmap";
export default class extends Controller {
  connect() {
    const companyLat = Number(this.element.dataset.companyLat);
    const companyLon = Number(this.element.dataset.companyLon);
    const allowDistance = Number(this.element.dataset.pubchcardDistance);
    geolocateUser();
    getdistance(companyLat, companyLon, allowDistance);
  }
}
