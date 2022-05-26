import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "stylesheets";
import "controllers";

Rails.start();
Turbolinks.start();
ActiveStorage.start();
