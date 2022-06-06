import { Controller } from "stimulus";
import { geolocateUser, getdistance, calculateDistance } from "lib/gmap";
export default class extends Controller {
  static targets = ["inarea", "outarea", "gmap"];
  connect() {
    console.log("已連接");
    geolocateUser();
    getdistance();
  }
}
