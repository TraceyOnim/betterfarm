// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
import Player from "./player"
let video = document.getElementById("video")
if(video) {
Player.init(video.id, video.getAttribute("data-player-id"), () => {
console.log("player ready!")
})
}

import Vue from "vue";
import Message from './components/Message'
import AddProducts from './components/AddProducts'

import axios from 'axios'
window.axios = axios;
axios.defaults.headers.common['Accept'] = 'application/json'
let token = document.head.querySelector('meta[name="csrf_token"]');
if(token){
	axios.defaults.headers.common['X-CSRF-TOKEN'] = token.content;
}else {
	console.log('CSRF not found')
}

Vue.component('message', Message);
Vue.component('add-products', AddProducts)

new Vue({
  el: "#app"
});
