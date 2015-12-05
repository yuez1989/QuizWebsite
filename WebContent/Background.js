/**
 * 
 */
var srcBgArray = [
	"images/aurora.jpeg",
  "images/lightSpot.jpg",
  "images/hikers.jpg",
  "images/blueberry.jpg",
  
  "images/brooklyn.jpg",
  "images/greece.jpg",
  "images/heart.jpg",
  "images/moon.jpg",
  
  "images/bottle.jpeg",
  "images/hikers.jpg",
  "images/heart.jpg",
  "images/mist.jpeg",
  "images/mountain.jpg",
  "images/Sedona.jpg",
  
  "images/panAndEgg.jpg",
  "images/smilieToy.jpeg",
  "images/starNight.jpeg",
  
  "images/tomato.jpg",
  "images/toronto.jpg",
  "images/valley.jpeg",

];
 
$(document).ready(function() {
  $('body').bcatBGSwitcher({
    urls: srcBgArray,
    alt: 'Alt text',
    timeout: 15000,
    speed: 5000
  });
});