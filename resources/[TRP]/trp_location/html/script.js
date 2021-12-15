var elementStyle = document.getElementById("priority").style;



$(function() {window.onload = (e) => {

    window.addEventListener('message', (event) => {

        if (event.data.type == "togglemenu") {

            if (event.data.status == true) {

                showUI()

            } else {

                hideUI()

            }

        } else if (event.data.type == "updatedata") {

            $('.info2').html(event.data.info1)

        } else if (event.data.type == "togglepriority") {

            if (event.data.status == true) {

                showUI2()

            } else {

                hideUI2()

            }

        } else if (event.data.type == "updatepriority") {

            $('.info').html(event.data.priorityinfo)

        } else if (event.data.type == "inVehicle") {

            if (event.data.status == true) {

                elementStyle.bottom = elementStyle.bottom = "3.5%";

            } else {

                elementStyle.bottom = elementStyle.bottom = "0.5%";

            }

        }

    })

}})



function hideUI() {

    $('.alpr').hide();

    $('.alpr').addClass('bg-transparent');

}



function showUI() {

    $('.alpr').show();

    $('.alpr').removeClass('bg-transparent');

}



function hideUI2() {

    $('.priority').hide();

    $('.priority').addClass('bg-transparent');

}



function showUI2() {

    $('.priority').show();

    $('.priority').removeClass('bg-transparent');

}

