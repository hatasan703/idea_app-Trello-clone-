/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'
import IdeaPublic from '../components/ideaPublic.vue'

window.store = {}

document.addEventListener("turbolinks:load", function() {

  var element = document.querySelector("#boards")
  if (element != undefined) {
    window.store.ideas = JSON.parse(element.dataset.ideas)

    const app = new Vue({
      el: element,
      data: window.store,
      template: "<App :original_ideas='ideas' />",
      components: { App }
    });
  }

  var element = document.querySelector("#idea_public")
  if (element != undefined) {
    window.store.ideas = JSON.parse(element.dataset.ideas)
    const app = new Vue({
      el: element,
      data: window.store,
      template: "<IdeaPublic :comment_ideas='ideas' />",
      components: { IdeaPublic }
    });
  }

});
