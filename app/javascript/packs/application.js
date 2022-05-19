import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "stylesheets/application";

import "controllers"

Rails.start();
Turbolinks.start();
ActiveStorage.start();

import "../controllers"
