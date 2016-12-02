/* Filename: custom.js */
$(document).ready(function() {

 $("#newdiv").click(function() {
        alert("Hello world!");
 });
$("<style type='text/css'> .highlight { color:yellow; font-weight:bold;} </style>").appendTo("head");
 
$("#2div").click(function() {
       $(this).toggleClass("highlight");
});

$("img[src^=images]").attr("src", "http://i.imgur.com/PpDGw59.jpg");
$("img[alt$=ism]").attr("src", "http://www.reactiongifs.com/wp-content/uploads/2013/01/liz-lemon-oh-brother.gif");
$("img[alt$=ism").css({"height":200, "width":200});
$("html").css("background-color", "blue");
$("p:not(:contains(Lizbeanism))").hide();
$("p:last").css("font-weight", "bolder");

$(document).click(function() {
        $("p:not(:contains(Lizbeanism))").toggle();
});

});