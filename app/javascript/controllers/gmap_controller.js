import { Controller } from "stimulus";
import { geolocateUser, getdistance, calculateDistance } from "lib/gmap";
export default class extends Controller {
  static targets = ["inarea", "outarea", "gmap"];
  connect() {
    geolocateUser();
    getdistance();
    const company_latitude = this.element.dataset.latitude;
    const company_longitude = this.element.dataset.longitude;
    console.log(company_latitude);
    console.log(company_longitude);
  }
}
