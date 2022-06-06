import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";
import Flatpickr from "stimulus-flatpickr";

const application = Application.start();
const context = require.context("controllers", true, /_controller\.js$/);
application.load(definitionsFromContext(context));

require("flatpickr/dist/flatpickr.css");

application.register("flatpickr", Flatpickr);
