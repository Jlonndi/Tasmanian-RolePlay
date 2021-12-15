// Element
let cityElement = document.querySelector(".city");
let tempElement = document.querySelector(".temperature");
let dateElement = document.querySelector(".time");
let msgElement = document.querySelector(".welcome-msg");
let weatherIcon = document.querySelector(".weather-icon");

// Date
let date = new Date().toLocaleString("en-gb", {timeZone: 'Australia/Tasmania'});
let days = new Date().getDay({timeZone: 'Australia/Tasmania'});
let day;
let time = date.split(",");
let hour = time[1].split(":")[0];
let mint = time[1].split(":")[1];
let ampm;
let msg;

// Get Full Week Day
switch (days) {
    case 0:
        day = "Sunday";
        break;
    case 1:
        day = "Monday";
        break;
    case 2:
        day = "Tuesday";
        break;
    case 3:
        day = "Wednesday";
        break;
    case 4:
        day = "Thursday";
        break;
    case 5:
        day = "Friday";
        break;
    case 6:
        day = "Saturday";
        break;
    default:
        day = "Day";
}

if (hour >= 6 && hour < 12) {
    ampm = "AM";
    msg = "Morning";
} else if (hour >= 12 && hour < 18) {
    hour -= 12;
    ampm = "PM";
    msg = "Afternoon";
} else if (hour >= 18 && hour < 24) {
    hour -= 12;
    ampm = "PM";
    msg = "Evening";
} else if (hour >= 0 && hour < 6) {
    ampm = "AM";
    msg = "Night";
}

// Open Weather
let apiKey = "b767fb23baf1b2f7280ae2ea86f2f8c5";
let city = "tasmania";

const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}&units=metric`;

fetch(url)
    .then(response => response.json())
    .then(data => {
        const { main, name, sys, weather } = data;

        let icon = weather[0].icon;

        cityElement.innerHTML = city;
        tempElement.innerHTML = Math.round(main.temp) + "°C";
        dateElement.innerHTML = `${day}, ${hour}:${mint} ${ampm}`;
        msgElement.innerHTML = msg + ", <span><span>";

        switch (icon) {
            case "01d":
                weatherIcon.src = "https://image.flaticon.com/icons/svg/615/615503.svg";
                break;
            case "01n":
                weatherIcon.src = "https://image.flaticon.com/icons/svg/615/615488.svg";
                break;
            case "02d":
                weatherIcon.src = "https://image.flaticon.com/icons/svg/615/615500.svg";
                break;
            case "02n":
                weatherIcon.src = "https://image.flaticon.com/icons/svg/615/615479.svg";
                break;
            case "03d":
            case "03n":
                weatherIcon.src = "https://image.flaticon.com/icons/svg/615/615468.svg";
                break;
            case "04d":
                weatherIcon.src = "https://image.flaticon.com/icons/svg/615/615480.svg";
                break;
            case "04n":
                weatherIcon.src = "https://image.flaticon.com/icons/svg/615/615477.svg";
                break;
            case "09d":
            case "09n":
                weatherIcon.src = "https://image.flaticon.com/icons/svg/615/615467.svg";
                break;
            case "10d":
            case "10n":
                weatherIcon.src = "https://image.flaticon.com/icons/svg/615/615494.svg";
                break;
            case "11d":
            case "11n":
                weatherIcon.src = "https://image.flaticon.com/icons/svg/615/615507.svg";
                break;
            case "13d":
            case "13n":
                weatherIcon.src = "https://image.flaticon.com/icons/svg/615/615499.svg";
                break;
            case "50d":
                weatherIcon.src = "https://image.flaticon.com/icons/svg/615/615501.svg";
                break;
            case "50n":
                weatherIcon.src = "https://image.flaticon.com/icons/svg/615/615471.svg";
                break;
            default:
                weatherIcon.src = "";
        }

        
    })
    .catch(() => {
        
    });