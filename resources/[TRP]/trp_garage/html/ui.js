var toggle = false;
var globalstate = '1';
var states = { // car table lmao
	0: "<span class='status' style='color: orange'>Impounded</span>",
	1: "<span class='status' style='color: #4ed69c;'>Garage</span>",
	2: "<span class='status' style='color: #ff1b28;'>Crushed</span>",
	3: "<span class='status' style='color: #ff1b28;'>Crushed</span>",
	4: "<span class='status' style='color: #ff1b28;'>Crushed</span>",
	7: "<span class='status' style='color: #ff1b28;'>Reported Stolen</span>",
	8: "<span class='status' style='color: #038ef5'>Active In World</span>",
	9: "<span class='status' style='color: darkgray'>Held at Rapid Repo</span>",
};

var Config = new Object();

Config.closeKeys = [27]; //Array of keys used to close inventory. Default ESC and F2. Check https://keycode.info/ to get your key code

//LANGUAGE CAN BE CHANGED IN ui.html, SEARCH FOR <script src="locales/en.js"></script> AND CHANGE IT THERE


$(document).keydown(function(e) {

  if (Config.closeKeys.includes(e.which)) {
    $('.container').css('display', 'none');
    $.post('http://trp_garage/escape', JSON.stringify({}));
   

  }

});
$(document).ready(function(){
    window.addEventListener('message', function( event ) {       
      if (event.data.action == 'open') {

        $(".head-switch-in").removeClass("selected"); 
        $(".head-switch-out").removeClass("selected");  
        $(".head-switch-in").addClass("selected"); 

        const vehicles = document.getElementById("vehicle-list");
          vehicles.innerHTML = '';

        $.post('http://trp_garage/enable-parkout', JSON.stringify({}));

        toggle = false;

        $('.container').css('display', 'block');        
		
      } else if (event.data.action == 'add') {
                
        AddCar(event.data.plate, event.data.model, event.data.state, event.data.garage);        

      } else {
        $('.container').css('display', 'none');
      }
    });
 
    $( ".close" ).click(function() {
      $('.container').css('display', 'none');
      $('.container1').css('display', 'none');

      $.post('http://trp_garage/escape', JSON.stringify({}));
    }); 

    $( ".head-switch-in" ).click(function() {      
      $(".head-switch-in").removeClass("selected"); 
      $(".head-switch-out").removeClass("selected");  
      $(".head-switch-in").addClass("selected"); 

      const vehicles = document.getElementById("vehicle-list");
        vehicles.innerHTML = '';

      $.post('http://trp_garage/enable-parkout', JSON.stringify({}));

      toggle = false;
    }); 

    $( ".head-switch-out" ).click(function() {     
      $(".head-switch-in").removeClass("selected");  
      $(".head-switch-out").removeClass("selected"); 
      $(".head-switch-out").addClass("selected");   
      
      const vehicles = document.getElementById("vehicle-list");
        vehicles.innerHTML = '';

      $.post('http://trp_garage/enable-parking', JSON.stringify({}));

      toggle = true;
    }); 

    function AddCar(plate, modelname, state, garage) {
// todo add filter for state so garage vehicles don't show up lol
     

    $("#vehicle-list").append // Pulls IMP
     // if (garage == 1) { // garage name
      (`
      
      <div class="vehicle" onclick="parkOut('` + plate + `','` + state + `','` + garage + `');" data-plate="` + plate + `"> 
        <div class="vehicle-inner">
            
            <p class="inner-label-knz">` + modelname + ' - ' + plate + '  <br>[' + states[state]+']' +`</p>
        </div>
      </div>

      `);
      if (garage == 1) { // checks if garage then states garage
        $('#title').text('Garage');

        $('#last-name').text('');
      }
  else if  (garage == 0) { // else state impound
    $('#title').text('Impound');

    $('#last-name').text('$500 Impound Fee');
  }

    
    }});



function parkOut(plate, state, garage) { // pull impound
  console.log('garage:' + garage); // debug console log to check state callback works 1 = Garage 0 = Imp
  if (garage == 1) { // garage
  if (state == 1) { // garage vehicles
    $('.container').css('display', 'none');
    //$.post('http://trp_garage/cargarage', JSON.stringify({plate: plate}));
    $.post('http://trp_garage/escape', JSON.stringify({}));
    $.post('http://trp_garage/park-outGarage', JSON.stringify({plate: plate}));
   
  } else if (state == 0) { // impounded vehicles
    $('.container').css('display', 'none');
    $.post('http://trp_garage/escape', JSON.stringify({}));
    $.post('http://trp_garage/carimp', JSON.stringify({plate: plate}));
    //$.post('http://trp_garage/park-out', JSON.stringify({plate: plate}));
 
  }else if (state == 8){
    $('.container').css('display', 'none'); // out in world vehiclesw
   // $.post('http://trp_garage/escape', JSON.stringify({}));
    $.post('http://trp_garage/caractive', JSON.stringify({plate: plate}));
  }
  // // // // // // 
} else if (garage == 0) { // impound
  if (state == 1) { // garage vehicles
    $('.container').css('display', 'none');
    $.post('http://trp_garage/cargarage', JSON.stringify({plate: plate}));
   
  } else if (state == 0) { // impounded vehicles
    $('.container').css('display', 'none');
    $.post('http://trp_garage/escape', JSON.stringify({}));
    $.post('http://trp_garage/park-out', JSON.stringify({plate: plate}));
 
  }else if (state == 8){
    $('.container').css('display', 'none'); // out in world vehiclesw
   // $.post('http://trp_garage/escape', JSON.stringify({}));
    $.post('http://trp_garage/caractive', JSON.stringify({plate: plate}));
  }
  //
  }
  //
}