$(document).ready(function(){
  // Mouse Controls
  var documentWidth = document.documentElement.clientWidth;
  var documentHeight = document.documentElement.clientHeight;
  //var cursor = $('#cursorPointer');
  var cursorX = documentWidth / 2;
  var cursorY = documentHeight / 2;
  var idEnt = 0;

  function UpdateCursorPos() {
    $('#cursorPointer').css('left', cursorX);
    $('#cursorPointer').css('top', cursorY);
  }

  function triggerClick(x, y) {
    var element = $(document.elementFromPoint(x, y));
    element.focus().click();
    return true;
  }

  // Listen for NUI Events
  window.addEventListener('message', function(event){
    // Crosshair
    if(event.data.crosshair == true){
      $(".crosshair").addClass('fadeIn');
      // $("#cursorPointer").css("display","block");
    }
    if(event.data.crosshair == false){
      $(".crosshair").removeClass('fadeIn');
      // $("#cursorPointer").css("display","none");
    }

    // Menu
    if(event.data.menu == 'vehicle'){
      $(".crosshair").addClass('active');
      $(".menu-car").addClass('fadeIn');
      idEnt = event.data.idEntity;
      // $("#cursorPointer").css("display","none");
    }
    if(event.data.menu == 'user'){
      $(".crosshair").addClass('active');
      $(".menu-user").addClass('fadeIn');
      idEnt = event.data.idEntity;
      // $("#cursorPointer").css("display","none");
    }
    if(event.data.menu == 'police'){
      $(".crosshair").addClass('active');
      $(".menu-police").addClass('fadeIn');

      // $("#cursorPointer").css("display","none");
    }
    if(event.data.menu == 'ambulance'){
      $(".crosshair").addClass('active');
      $(".menu-ambulance").addClass('fadeIn');

      // $("#cursorPointer").css("display","none");
    }
    if(event.data.menu == 'barista'){
      $(".crosshair").addClass('active');
      $(".menu-barista").addClass('fadeIn');

      // $("#cursorPointer").css("display","none");
    }
    if((event.data.menu == false)){
      $(".crosshair").removeClass('active');
      $(".menu").removeClass('fadeIn');
      idEnt = 0;
    }

    // Click
    if (event.data.type == "click") {
      //triggerClick(cursorX - 1, cursorY - 1);
    }
  });

  // Mousemove
  $(document).mousemove(function(event) {
    cursorX = event.pageX;
    cursorY = event.pageY;
  });


 
// event post events
  $('.showid').on('click', function(e){

    e.preventDefault();
 
    $.post('http://menu/showid', JSON.stringify({
 
      id: idEnt
 
    }));
 
  });


  $('.mainmenu').on('click', function(e){

    e.preventDefault();

    $.post('http://menu/mainmenu', JSON.stringify({

      id: idEnt

    }));

   });

   
  $('.showlicense').on('click', function(e){

    e.preventDefault();
 
    $.post('http://menu/showlicense', JSON.stringify({
 
      id: idEnt
 
    }));
 
  });

  $('.carcontrols').on('click', function(e){

    e.preventDefault();
 
    $.post('http://menu/carcontrols', JSON.stringify({
 
      id: idEnt
 
    }));
 
  });



  $('.jobmenu').on('click', function(e){

    e.preventDefault();
 
    $.post('http://menu/jobmenu', JSON.stringify({
 
      id: idEnt
 
    }));
 
    
  });
 
  
  $('.policeDrag').on('click', function(e){

    e.preventDefault();
  
    $.post('http://menu/policeDrag', JSON.stringify({
  
      id: idEnt
  
    }));
  
  });
  
  $('.baristaBill').on('click', function(e){

    e.preventDefault();
  
    $.post('http://menu/baristaBill', JSON.stringify({
  
      id: idEnt
  
    }));
  
  });
  $('.policePutVehicle').on('click', function(e){

    e.preventDefault();
  
    $.post('http://menu/policePutVehicle', JSON.stringify({
  
      id: idEnt
  
    }));
  
  });
  $('.policePullVehicle').on('click', function(e){

    e.preventDefault();
  
    $.post('http://menu/policePullVehicle', JSON.stringify({
  
      id: idEnt
  
    }));
  
  });

  
  $('.robplayer').on('click', function(e){

    e.preventDefault();
  
    $.post('http://menu/RobPlayer', JSON.stringify({
  
      id: idEnt
  
    }));
  
  });
// POLICE NUI CALLBACKS

$('.policeID').on('click', function(e){

  e.preventDefault();

  $.post('http://menu/policeID', JSON.stringify({

    id: idEnt

  }));

});
// Barista Send bill menu?
$('.baristaBill').on('click', function(e){

  e.preventDefault();

  $.post('http://menu/baristaBill', JSON.stringify({

    id: idEnt

  }));

});


$('.policeBodySearch').on('click', function(e){

  e.preventDefault();

  $.post('http://menu/policeBodySearch', JSON.stringify({

    id: idEnt

  }));

});


$('.policeFines').on('click', function(e){

  e.preventDefault();

  $.post('http://menu/policeFines', JSON.stringify({

    id: idEnt

  }));

});


$('.policeManageLicenses').on('click', function(e){

  e.preventDefault();

  $.post('http://menu/policeManageLicenses', JSON.stringify({

    id: idEnt

  }));

});


$('.policeDV').on('click', function(e){

  e.preventDefault();

  $.post('http://menu/policeDV', JSON.stringify({

    id: idEnt

  }));

});


$('.policeJailSuspekt').on('click', function(e){

  e.preventDefault();

  $.post('http://menu/policeJailSuspekt', JSON.stringify({

    id: idEnt

  }));

});


  // Click Crosshair
  $('.crosshair').on('click', function(e){
    e.preventDefault();
    $(".crosshair").removeClass('fadeIn').removeClass('active');
    $(".menu").removeClass('fadeIn');
    $.post('http://menu/disablenuifocus', JSON.stringify({
      nuifocus: false
    }));
  });

  var Config = new Object();
  
// Table of keys that can close menu instead of repeating function 100x for different keycodes
  Config.closeKeys = [48 ,49, 50, 51, 52, 53, 54, 55, 56, 57, 112, 113, 114, 27, 192, 87, 65, 83, 68]; 

  $(document).keydown(function(e) {

    if (Config.closeKeys.includes(e.which)) {

      $(".crosshair").removeClass('fadeIn').removeClass('active');

      $(".menu").removeClass('fadeIn');

      $.post('http://menu/disablenuifocus', JSON.stringify({

        nuifocus: false

      }));

    }});
    
  }); 

