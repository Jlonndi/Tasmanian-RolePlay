$(document).ready(function () {
    window.addEventListener('message', function (event) {
        var item = event.data;
        if (item.show == true) {
          openHome();
        }
        if (item.show == false) {
          close();
        }
    
      });
// Function Declaration
const _$ = (query) => {
    const elm = document.querySelectorAll(query);
    if(elm.length == 1) return elm[0];
    else return elm;
},
_messageBomb = {

    toggleUI: (isShow) => {
        // Check UI toggle status.
        if(isShow) {
            // Remove old animation and show it on screen.
            _$('#allELM').style.animation = "";
            _$('#allELM').style.display = "block";
            _$('#mainGUI').style.height = "39px";
        } else {
            // Set fade out animation before hide element
            _$('#allELM').style.animation = "fadeOutDown .5s forwards";
            setTimeout(() => {
                _$('#allELM').style.display = "";
            }, 500);
        }
    },

    updateInfo: (data) => {

        /**
         * This event will update about the vehicle status:
         * 
         * - Vehicle's health progress.
         * - Vehicle's fuel progress.
         * - Current vehicle's speed.
         * - Current gear's number.
         * - The name of street where player is driving.
         */

        _$('#yeetHealth').style.width = data.carHealth + "%";
        _$('#yeetFuel').style.width = data.carFuel + "%";
        _$('#numSpeed').innerHTML = data.speed;
        _$('#gearNum').innerHTML = data.gear;
        _$('#placeName').innerHTML = data.streetName;
        _$('#speedUnit').innerHTML = data.speedUnit;
    },

    toggleBelt: (data) => {

        /**
         * Check if belts is available for use then update the status.
         * Hide the belts's icon and red text status when it doesn't available.
         */

       // if(!data.hasBelt) {
         //   _$('#belt').style.display = "none";
           // _$('#mainGUI').style.height = "39px";
            //return false;
       // }
        
        // Show belt icon.
        _$('#belt').style.display = "";
        //_$('#txtNotice').style.display = "";d
     
        // Check belt toggle and update ui.
        if(data.beltOn) {
          //  _
            // Active belt status.
          // _$('#mainGUI').style.height = "39px";
            //_$('#txtNotice').style.display = "none";
            _$('#belt').classList.add('active');
           Buckle()
           // post event for seatbelt on sound sv wide
        } else {
            //_
            UnBuckle();
            
            // Deactive belt status.
           // _$('#mainGUI').style.height = "39px";
        //    / _$('#txtNotice').style.display = "";
            _$('#belt').classList.remove('active');
           
           // post event for seatbelt off sound sv wide
        }
    },
    
    toggleCruise: (data) => {
        
        /**
         * Check if cruise is available for use then update the status.
         * Hide the cruise's icon when it doesn't available.
         */

        if(!data.hasCruise) {
            _$('#cruise').style.display = "none";
            return false;
        }

        // Show cruise icon.
        _$('#cruise').style.display = "";

        // Check cruise toggle and update ui.
        if(data.cruiseStatus)
            _$('#cruise').classList.add('active'); // Active cruise status.
        else
            _$('#cruise').classList.remove('active'); // Deactive cruise status.
    },

    toggleEngine: (isEngineOn) => {
        if(isEngineOn)
            _$('#engine').classList.add('active'); // Active engine status.
        else
            _$('#engine').classList.remove('active'); // Deactive engine status.
    }
}

window.addEventListener('message', function(e) {
    if(_messageBomb[e.data.event])
        _messageBomb[e.data.event](e.data.payload); // Drop the bomb.
})


function Buckle() {
    $.post(`https://trp_carhud/seatbeltbuckle`, JSON.stringify({}));
  }
  
  function UnBuckle() {
    $.post(`https://trp_carhud/seatbeltunbuckle`, JSON.stringify({}));
  }
});