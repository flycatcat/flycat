import { Controller } from "stimulus";
// import { geolocateUser, getdistance, calculateDistance } from "lib/gmap";
export default class extends Controller {
  static targets = ["inarea", "outarea", "gmap"];
  connect() {
    geolocateUser();
    getdistance();
    function geolocateUser() {
      // If the browser supports the Geolocation API
      if (navigator.geolocation) {
        let positionOptions = {
          enableHighAccuracy: true,
          timeout: 3 * 1000, // 3 seconds
        };
        navigator.geolocation.getCurrentPosition(
          geolocationSuccess,
          geolocationError,
          positionOptions
        );
      } else
        document.getElementById("error").innerHTML +=
          "Your browser doesn't support the Geolocation API";
    }

    function geolocationSuccess(position) {
      let userLatLng = new google.maps.LatLng(
        position.coords.latitude,
        position.coords.longitude
      );
      let myOptions = {
        zoom: 16,
        center: userLatLng,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
      };
      // Draw the map
      let mapObject = new google.maps.Map(
        document.getElementById("gmap"),
        myOptions
      );
      //
      // Place the marker
      new google.maps.Marker({
        map: mapObject,
        position: userLatLng,
      });
      // Draw a circle around the user position to have an idea of the current localization accuracy
      let circle = new google.maps.Circle({
        center: userLatLng,
        radius: position.coords.accuracy,
        map: mapObject,
        fillColor: "#FF0000",
        fillOpacity: 0.2,
        strokeColor: "#FF0000",
        strokeOpacity: 1.0,
      });
      mapObject.fitBounds(circle.getBounds());
    }

    function geolocationError(positionError) {
      document.getElementById("error").innerHTML +=
        "Error: " + positionError.message + "<br />";
    }

    function getdistance() {
      let startPos;
      let startPosLat;
      let startPosLong;
      let distance;

      if (navigator.geolocation) {
        startPosLat = 25.04264418555442;
        startPosLong = 121.51370557791132;

        document.getElementById("startLat").innerHTML = startPosLat;
        document.getElementById("startLon").innerHTML = startPosLong;

        navigator.geolocation.watchPosition(function (position) {
          document.getElementById("currentLat").innerHTML =
            position.coords.latitude;
          document.getElementById("currentLon").innerHTML =
            position.coords.longitude;
          // document.getElementById("currentLat1").innerHTML =
          //   position.coords.latitude;
          // document.getElementById("currentLon1").innerHTML =
          //   position.coords.longitude;

          distance = calculateDistance(
            startPosLat,
            startPosLong,
            position.coords.latitude,
            position.coords.longitude
          );
          document.getElementById("distance").innerHTML = (
            distance * 1000
          ).toFixed(0);
          document.getElementById("distance_in").innerHTML = (
            distance * 1000
          ).toFixed(0);
          document.getElementById("distance_out").innerHTML = (
            distance * 1000
          ).toFixed(0);

          let allow_area = 100;
          document.getElementById("allow_area").innerHTML = allow_area;

          if ((distance * 1000).toFixed(0) < allow_area) {
            document.getElementById("inarea").style.display = "block";
            document.getElementById("outarea").style.display = "none";
            document.getElementById("punch_enable").style.display = "block";
            document.getElementById("punch_disable").style.display = "none";
          } else {
            document.getElementById("outarea").style.display = "block";
            document.getElementById("inarea").style.display = "none";
            document.getElementById("punch_disable").style.display = "block";
            document.getElementById("punch_enable").style.display = "none";
          }
        });
      }
    }

    function calculateDistance(lat1, lon1, lat2, lon2) {
      let R = 6371; // km
      let dLat = (lat2 - lat1).toRad();
      let dLon = (lon2 - lon1).toRad();
      let a =
        Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(lat1.toRad()) *
          Math.cos(lat2.toRad()) *
          Math.sin(dLon / 2) *
          Math.sin(dLon / 2);
      let c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
      let d = R * c;
      return d;
    }
    Number.prototype.toRad = function () {
      return (this * Math.PI) / 180;
    };
  }
}
