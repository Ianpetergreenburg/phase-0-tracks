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
