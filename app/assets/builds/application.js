// app/javascript/application.js
import { Turbo } from "@hotwired/turbo-rails";
import { Application } from "@hotwired/stimulus";

// app/javascript/controllers/theme_controller.js
import { Controller } from "@hotwired/stimulus";
var theme_controller_default = class extends Controller {
  connect() {
    const theme = localStorage.getItem("theme") || "light";
    document.documentElement.setAttribute("data-theme", theme);
    const themeController = document.querySelector(".theme-controller");
    if (themeController) {
      themeController.checked = theme === "dark";
    }
    themeController?.addEventListener("change", (e) => {
      const newTheme = e.target.checked ? "dark" : "light";
      document.documentElement.setAttribute("data-theme", newTheme);
      localStorage.setItem("theme", newTheme);
    });
  }
};

// app/javascript/controllers/index.js
function registerControllers(application2) {
  application2.register("theme", theme_controller_default);
}

// app/javascript/application.js
window.Turbo = Turbo;
var application = Application.start();
registerControllers(application);
document.addEventListener("turbo:load", () => {
  const themeController = document.querySelector(".theme-controller");
  if (themeController) {
    themeController.addEventListener("change", (e) => {
      const html = document.querySelector("html");
      if (e.target.checked) {
        html.setAttribute("data-theme", "dark");
      } else {
        html.setAttribute("data-theme", "light");
      }
    });
  }
});
//# sourceMappingURL=/assets/application.js.map
