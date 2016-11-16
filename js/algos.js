// take in an array of strings
// set an empty string as longest
// iterate through array and compare length of string  to longest
// replace longest if current string is longest
// return that longest string after iteration
var longestString = function(arr) {
      longest = ""
      for (var i = 0; i < arr.length; i++) {
        if (arr[i].length > longest.length) {
          longest = arr[i];
        }
      }
      return longest
}

// set a false result 
// iterate through all keys of first object1
// for each key iterate through all keys in object2
// if you get a match change result to true
// return result
var keyValueMatch = function(object1,object2) {
  result = false;
  for (var key1 in object1) {
        for(var key2 in object2) {
                if (key1 === key2 && object1[key1] === object2[key2]) {
                       result = true;
                }
        }
 }
 return result
}
//method for generating random int between min/max inclusive
function getRandomIntInclusive(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min + 1)) + min;
}
//input acceptable char for words
//take in an int
//loop that many times 
//in each loop build a string of random length
//fill in string with random letters by using a random applied to alphabet string
//push string into array
//return array after all loops
var randomWords = function(arrayLength){
  alphabet = "abcdefghijklmnopqrstuvwxyz"
  arr = [];
        for (var i = 0; i < arrayLength; i++) {
               string = "";
               var randomInt = getRandomIntInclusive(1,10);
               for (var j = 0; j < randomInt; j++) {
                  string += alphabet[getRandomIntInclusive(0,25)];
               }
               arr.push(string);
        }
  return arr;      
}

console.log(randomWords(10))

console.log(keyValueMatch({name: "Steven", age: 54} , {name: "Tamir", age: 54}));
console.log(keyValueMatch({name: "Steven", age: 54} , {name: "Tamir", age: 53}));
console.log(keyValueMatch({name: "Steven", age: 54} , {name: "Tamir", ge: 54}));

console.log(longestString(["long phrase","longest phrase","longer phrase"]))
console.log(longestString(["a"]))
console.log(longestString([]))
someArr = randomWords(10)
console.log(someArr)
console.log(longestString(someArr))