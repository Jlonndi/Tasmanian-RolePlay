// Assume each square can have a max of 4 images
// Have values 1-4, randomize them in an array, have the script take each one at a time to use in the classname
// When that is done, randomize them again and repeat
var k0 = '';
var k1 = '';
var k2 = '';
var k3 = '';
var k4 = '';
var k5 = '';
var k6 = '';
var k7 = '';
var k8 = '';
var k9 = '';
var k10 = '';
var k11 = '';
var k12 = '';
var k13 = '';
var number;
var squareEl = document.getElementById('square1');
var numerals = [];
var j = 0;

function getRandomInt() {
    // number = Math.floor(Math.random() * Math.floor(max));
    //return number;
    console.log(number + "number");
    
    for (i = 0; i < 13; i++) {
        number = Math.floor(Math.random() * Math.floor(13));
    }
    return number;
}

function changeBg1() {
    squareEl.className = "mystyle";
}

function changeBg0() {
    //squareEl.style["background-image"] = "url('https://www.jaxhumane.org/wp-content/uploads/2018/03/kitten-300x300.jpg')";
    getRandomInt(13);
    squareEl.className = "square k" + number;
}

function changeBg() {
    //squareEl.style["background-image"] = "url('http://facts.net/wp-content/uploads/2015/01/Kitten-Facts.jpg')";
    
    console.log(squareEl);
    //qqq();
    //for (i = 0; i < squareEl.length; i++) {
    //setTimeout(qqq(), 3000);
    
    // do {
    //     getRandomInt(3);
    //     squareEl.classList.add('k' + number);
    //     console.log(number);
    // }
    // while (j < 10);
    
    //}
}

function qqq() {
    while (j < 3) {
        getRandomInt(13)
        console.log(number);
        //var bgUrl = "kitten" + numeral;
        setTimeout(changeBg2, 1000);
        //changeBg2();
        //setTimeout(function() {j++;}, 3000);
        j++;
    }
}

function changeBg2() {
    squareEl.classList.add('k' + number);
}

window.onload = changeBg0;
window.setInterval(changeBg0, 8000);