/* Take in a string
for each letter starting from the end of the string
add the letter into a new array
return a joined version of the array
*/

var reverse = function(str) {
 var new_arr = [];
 for (var i = str.length - 1; i >= 0; i--) {
  new_arr.push(str[i]);
 }
  return new_arr.join('');
}

var say = "hello";
if (say === "olleh") {
console.log(say);
}
say = reverse(say);
if (say === "olleh") {
console.log(say);
}