var colors = ["blue", "cerulean", "indigo", "navy"]
var horseNames = ["Mr. Ed", "Bojack Horseman", "Secretariat", "Seabiscuit"]

colors.push("aquamarine");
horseNames.push("Rapidash");
console.log(colors);
console.log(horseNames);

var horses = {};
for (var i = 0; i < horseNames.length; i++) {
  horses[horseNames[i]] = colors[i];
}
console.log(horses);

function Car(color, model, numOfRiders){
 this.color = color;
 this.model = model;
 this.numOfRiders = numOfRiders;
 this.isTotaled = false;

 this.getWreckt = function(){
  this.isTotaled = true;
  console.log("Hot Jesus! Look out for that... Oh NO!!!");
 }
}

// CREATING SOME CARS

var iansCar = new Car('DarrRRrRk Blue','Yukon XL', 8);
var justinsCar = new Car('invisible, but tinted','Tesla iPad Deluxe ++++',1);
var someShitCar = new Car('like poop brown?', 'Pinto', 12);

console.log("The "+someShitCar.color+' '+someShitCar.model+' is totaled?');
console.log(someShitCar.isTotaled);
someShitCar.getWreckt();
console.log("The "+someShitCar.color+' '+someShitCar.model+' is totaled NOW!?');
console.log("Oh... so "+someShitCar.isTotaled+"!");