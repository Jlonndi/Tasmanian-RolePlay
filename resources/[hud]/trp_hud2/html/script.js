let togglehud = false;

window.addEventListener('message', function (event) {

	switch (event.data.action) {
        case 'updateStatusHud':
            $("body").css("display", event.data.show ? "block" : "none");
            $("#boxSetHealth").css("width", event.data.health + "%");
            $("#boxSetArmour").css("width", event.data.armour + "%");

            widthHeightSplit(event.data.hunger, $("#boxSetHunger"));
            widthHeightSplit(event.data.thirst, $("#boxSetThirst"));
            widthHeightSplit(event.data.oxygen, $("#boxSetOxygen"));
            widthHeightSplit(event.data.stress, $("#boxSetStress"));
			break;
    }
	var data = event.data;
	if (data.action === "togglehud") {
		if (togglehud === false) {
			console.log("hi")
			$("#statusHud").hide();
			togglehud = true;
		} else if (togglehud === true) {
			togglehud = false;
			$("#statusHud").show();
		}
	}
});

function widthHeightSplit(value, ele) {
    let height = 25.5;
    let eleHeight = (value / 100) * height;
    let leftOverHeight = height - eleHeight;
	
	if (eleHeight > height) {
		eleHeight = height;
		leftOverHeight = 0;
	}
    ele.css("height", eleHeight + "px");
    ele.css("top", leftOverHeight + "px");
};