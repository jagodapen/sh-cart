// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./src/jquery"
import "./src/jquery-ui"
import "./controllers"
// import "./custom/recipes"
import * as bootstrap from "bootstrap"


let popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
let popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
  return new bootstrap.Popover(popoverTriggerEl)
})
