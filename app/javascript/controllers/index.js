// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application";

import AlertController from "./alert_controller";
application.register("alert", AlertController);

import ArticleCreatorController from "./article_creator_controller";
application.register("solution-creator", ArticleCreatorController);

import CaptchaController from "./captcha_controller";
application.register("captcha", CaptchaController);

import ContactoController from "./contacto_controller";
application.register("contacto", ContactoController);

import DashboardController from "./dashboard_controller";
application.register("dashboard", DashboardController);

import DropdownBarsController from "./dropdown_bars_controller";
application.register("dropdown-bars", DropdownBarsController);

import DropdownController from "./dropdown_controller";
application.register("dropdown", DropdownController);

import ImageDisplayerController from "./image_displayer_controller";
application.register("image-displayer", ImageDisplayerController);

import IndexController from "./index_controller";
application.register("index", IndexController);

import IntersectionObserverController from "./intersection_observer_controller";
application.register("intersection-observer", IntersectionObserverController);

import NewContactoController from "./new_contacto_controller";
application.register("new-contacto", NewContactoController);

import ResetFormController from "./reset_form_controller";
application.register("reset-form", ResetFormController);

import UserIndexController from "./user_index_controller";
application.register("user-index", UserIndexController);
