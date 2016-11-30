// Set background to BLACK
var html = document.getElementsByTagName("html");
html = html[0];
html.style.backgroundColor = "black";

// Change First Image Border to Thick Rounded
var image = document.getElementsByTagName("img");
image = image[0];
image.style.borderRadius = "20px";
image.style.borderWidth = "8px";

// Turn First Image to Dancing Yeti (if included)
function makeYetiDance(event){
  event.target.style.border = "10px solid pink";
  event.target.src = "images/dancing_yeti.gif";
}

image.addEventListener("click",makeYetiDance);