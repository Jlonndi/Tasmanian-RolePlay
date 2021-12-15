var playerAdmin = false
var rank = 1

$(function() {

  window.onload = (e) => {

    window.addEventListener('message', (event) => {



      if (event.data.type == "ticketdata") {



        time = DisplayCurrentTime()

        sourceID = "#" + event.data.source



        if ( $(this).find(sourceID).length ) {



          $("#" + event.data.source).show();

          $(sourceID).find('.ticket-messagebox').append("<p class='ticket-message'>" + event.data.message + "<span class='time'>" + time + "</span></p>");

          $(sourceID).addClass('ticket-open')

          ticketsRemainingCheck()



        } else {



          $(document).find("#ticket-box").append("<div id=" + event.data.source + " class='ticket' id='" + event.data.source + "'><div class='profile-box'><img src='img/user.png'><div class='details'><span class='username'>" + event.data.name + "</span><span id='user-id' class='badge badge-primary ml-sm'>" + event.data.source + "</span>" + "<span class='ticket-steamid'>" + event.data.identifier + "</span>" + "</div></div></div>");

          $(sourceID).append("<button class='icon-btn tooltip tooltip-top' tooltip='Close' id='close-btn'><i class='fas fa-times'></i></button>");

          $(sourceID).append("<button class='icon-btn tooltip tooltip-top' tooltip='Go-to' id='goto-btn1'><i class='fas fa-arrow-alt-circle-up'></i></button>");

          $(sourceID).append("<button class='icon-btn tooltip tooltip-top' tooltip='Bring' id='bring-btn1'><i class='fas fa-arrow-alt-circle-down'></i></button>");

          $(sourceID).append("<button class='icon-btn tooltip tooltip-top' tooltip='Spectate' id='spectate-btn1'><i class='fas fa-eye'></i></button>");

          $(sourceID).append("<button class='icon-btn tooltip tooltip-top' tooltip='Sync Player' id='sync-btn'><i class='fas fa-sync'></i></button>");

          $(sourceID).append("<button class='icon-btn tooltip tooltip-top' tooltip='Claim Case' id='claim-btn'><i class='fas fa-flag'></i></button>");



          $(sourceID).addClass('ticket-open')



          $(sourceID).append("<div class='ticket-messagebox'></div>");

          $(sourceID).find('.ticket-messagebox').append("<p class='ticket-message'>" + event.data.message + "<span class='time'>" + time + "</span></p>");



        }



        $(this).on("click", "#close-btn", function() {

          $.post('http://trp_admin2/closedticket', JSON.stringify({userid: $(this).closest('.ticket').find('#user-id').html()}));

        });

        $(this).on("click", "#goto-btn1", function() {
          console.log($(this).closest('.ticket').find('#user-id').html());
          console.log('this is JaveScript');
          var targetid = $(this).closest('.ticket').find('#user-id').html()
          console.log(targetid);
          $.post('http://trp_admin2/gototicketPanel', JSON.stringify({userid: $(this).closest('.ticket').find('#user-id').html(), ticketID: $(this).closest('.ticket').find('#user-id').html()}));
          
  

        });

        $(this).on("click", "#bring-btn1", function() {

          $.post('http://trp_admin2/bringticketPanel', JSON.stringify({userid: $(this).closest('.ticket').find('#user-id').html(), ticketID: $(this).closest('.ticket').find('#user-id').html()}));

        });

        $(this).on("click", "#spectate-btn1", function() {

          $.post('http://trp_admin2/spectateticketPanel', JSON.stringify({userid: $(this).closest('.ticket').find('#user-id').html(), ticketID: $(this).closest('.ticket').find('#user-id').html()}));

        });

        $(this).on("click", "#sync-btn", function() {

          $.post('http://trp_admin2/syncticket', JSON.stringify({userid: $(this).closest('.ticket').find('#user-id').html()}));

        });

        $(this).on("click", "#claim-btn", function() {

          $.post('http://trp_admin2/claimticket', JSON.stringify({userid: $(this).closest('.ticket').find('#user-id').html()}));

          $(this).closest('.ticket').addClass('claimed-owner');

        });

      } else if (event.data.type == "closeticket") {



        var ticket = $("#ticket-box").find('#'+event.data.playerid)

        ticket.find('.ticket-message').addClass('old-data')

        $('#' + event.data.playerid + ' .old-data').last().addClass('old-divider')

        ticket.hide();

        ticket.removeClass('ticket-open');

        ticket.removeClass('claimed-owner');

        ticket.removeClass('claimed-others');

        ticket.find('.claimed-by').remove();

        closeTicket()



      } else if (event.data.type == "claimticket") {

        $("#ticket-box").find('#'+event.data.playerid).find('.claimed-by').remove();



        if (event.data.admin == $('#admin-owner').html()) {

          $("#ticket-box").find('#'+event.data.playerid).removeClass('claimed-others');

          $("#ticket-box").find('#'+event.data.playerid).addClass('claimed-owner');

          $("#ticket-box").find('#'+event.data.playerid).append('<div class="claimed-by">You own this ticket!</div>');

        } else {

          $("#ticket-box").find('#'+event.data.playerid).addClass('claimed-others');

          $("#ticket-box").find('#'+event.data.playerid).append('<div class="claimed-by">Claimed by: ' + event.data.adminname + '</div>');

        }



      } else if (event.data.type == "toggleui") {



        if (event.data.display === true) {

          $(document).find('#admin-box')

          $(".admin-panel").show();

        } else {

          $(".admin-panel").hide();

          $('#admin-box .row').empty();

        }



      } else if (event.data.type == "adminlogin") {

        

        $(document).find('#admin-owner').html(event.data.admin)



      } else if (event.data.type == "registerplayers") {

        sourceID = '#admin-' + event.data.playerId

        if (!( $('#admin-box .row').length )) {

          $(document).find('#admin-box').append('<div class="row"></div>')

        }

        if (!( $('#admin-box').find(sourceID).length )) {

          $(document).find('#admin-box').find('.row').append('<div id="admin-' + event.data.playerId + '" class="col-3"><div class="player-box py-md mx-sm">' + "<div class='profile-box'><img src='img/user.png'><div class='details mb-sm'><span class='username color-grey-2'>" + event.data.playerName + "</span><span id='user-id' class='badge badge-success ml-sm'>" + event.data.playerId + "</span>" + '</div></div>')



          playerBox = $(sourceID).find('.player-box')



          playerBox.append("<button class='icon-btn tooltip tooltip-top color-grey-1' tooltip='Go-to (1)' id='goto-btn'><i class='fas fa-arrow-alt-circle-up'></i></button>");

          playerBox.append("<button class='icon-btn tooltip tooltip-top color-grey-1' tooltip='Bring (2)' id='bring-btn'><i class='fas fa-arrow-alt-circle-down'></i></button>");

          playerBox.append("<button class='icon-btn tooltip tooltip-top color-grey-1' tooltip='Spectate (3/Enter)' id='spectate-btn'><i class='fas fa-eye'></i></button>");

          playerBox.append("<button class='icon-btn tooltip tooltip-top color-grey-1' tooltip='Sync Player (4)' id='sync-btn'><i class='fas fa-sync'></i></button>");

        }



        // Commands

        $(this).on("click", "#goto-btn", function() {

          $.post('http://trp_admin2/gototicket', JSON.stringify({userid: $(this).closest('.player-box').find('#user-id').html()}));

        });

        $(this).on("click", "#bring-btn", function() {

          $.post('http://trp_admin2/bringticket', JSON.stringify({userid: $(this).closest('.player-box').find('#user-id').html()}));

        });

        $(this).on("click", "#spectate-btn", function() {

          $.post('http://trp_admin2/spectateticket', JSON.stringify({userid: $(this).closest('.player-box').find('#user-id').html()}));

        });

        $(this).on("click", "#sync-btn", function() {

          $.post('http://trp_admin2/syncticket', JSON.stringify({userid: $(this).closest('.player-box').find('#user-id').html()}));

        });

      }



    });

  };

});



isShifting = false



$(document).keydown(function(e) {

  if (e.key === "Escape" || e.key === "Insert") {

    $.post('http://trp_admin2/closereportpanel', JSON.stringify({}));

  } else if (e.key === "Backspace") {

    if ($('#report-box').is(":hidden") == true) {

      $.post('http://trp_admin2/closereportpanel', JSON.stringify({}));

    }

  }

  if (rank <= 0) {

    if (e.key === "Shift") {

      isShifting = true

    } else if (e.key === "Tab") {

      if (rank <= 0) {

        $(document).find('#admin-on').click()

      }

    } else if (e.key === "ArrowRight") {

      if (isShifting == true) {

        $(document).find('.navigation-menu').find('.nav-active').next().click()

      } else if ($('#admin-box').is(":visible")) {

        if ($(document).find('.player-active').length) {

          location.hash = $(document).find('.player-active').closest('.col-3').next().attr('id')

          $(document).find('.player-active').closest('.col-3').next().find('.player-box').addClass('player-active')

          $(document).find('.player-active').first().removeClass('player-active')

        } else {

          $(document).find('.player-box').first().addClass('player-active')

        }

      }

    } else if (e.key === "ArrowLeft") {

      if (isShifting == true) {

        $(document).find('.navigation-menu').find('.nav-active').prev().click()

      } else if ($('#admin-box').is(":visible")) {

        if ($(document).find('.player-active').length) {

          location.hash = $(document).find('.player-active').closest('.col-3').next().attr('id')

          $(document).find('.player-active').closest('.col-3').prev().find('.player-box').addClass('player-active')

          $(document).find('.player-active').closest('.col-3').next().find('.player-active').removeClass('player-active')

        } else {

          $(document).find('.player-box').first().addClass('player-active')

        }

      }

    } else if (e.key === "ArrowUp") {

      if (isShifting == true) {

        $(document).find('.navigation-menu').find('.nav-active').prev().click()

      } else if ($('#admin-box').is(":visible")) {

        if ($(document).find('.player-active').length) { // If there is an active

          location.hash = $(document).find('.player-active').closest('.col-3').prev().prev().prev().prev().attr('id')

          $(document).find('.player-active').closest('.col-3').prev().prev().prev().prev().find('.player-box').addClass('player-active')

          $(document).find('.player-active').closest('.col-3').next().next().next().next().find('.player-active').removeClass('player-active')

        } else {

          $(document).find('.player-box').first().addClass('player-active')

        }

      }

    } else if (e.key === "ArrowDown") {

      if (isShifting == true) {

        $(document).find('.navigation-menu').find('.nav-active').prev().click()

      } else if ($('#admin-box').is(":visible")) {

        if ($(document).find('.player-active').length) {

          location.hash = $(document).find('.player-active').closest('.col-3').next().attr('id')

          $(document).find('.player-active').closest('.col-3').next().next().next().next().find('.player-box').addClass('player-active')

          $(document).find('.player-active').first().removeClass('player-active')

        } else {

          $(document).find('.player-box').first().addClass('player-active')

        }

      }

    } else if (e.key === "Enter") {

      if ($('#admin-box').is(":visible")) {

        $.post('http://trp_admin2/spectateticket', JSON.stringify({userid: $(document).find('.player-active').find('#user-id').html()}));

      }

    } else if (e.key === "1") {

      if ($('#admin-box').is(":visible")) {

        $.post('http://trp_admin2/gototicket', JSON.stringify({userid: $(document).find('.player-active').find('#user-id').html()}));

      }

    } else if (e.key === "2") {

      if ($('#admin-box').is(":visible")) {

        $.post('http://trp_admin2/bringticket', JSON.stringify({userid: $(document).find('.player-active').find('#user-id').html()}));

      }

    } else if (e.key === "3") {

      if ($('#admin-box').is(":visible")) {

        $.post('http://trp_admin2/spectateticket', JSON.stringify({userid: $(document).find('.player-active').find('#user-id').html()}));

      }

    } else if (e.key === "4") {

      if ($('#admin-box').is(":visible")) {

        $.post('http://trp_admin2/syncticket', JSON.stringify({userid: $(document).find('.player-active').find('#user-id').html()}));

      }

    }

  }

});



$(document).keyup(function(e) {

  if (e.key === "Shift") {

    isShifting = false

  }

});



$(document).on('DOMNodeInserted', '.ticket', function(e) {

  ticketsRemainingCheck()

});



$(document).on('click', '.nav-line-ani-center-blue', function() {

  // initalizing and hiding-previous page

  $(document).find('.tab-active').removeClass('tab-active')

  var previousPage = $(document).find('.nav-active').attr("page-item")

  var newPage = "#" + $(this).attr("page-item")

  $(document).find(newPage).addClass('tab-active')



  // reseting to default

  $(document).find('.nav-active').addClass('nav-line-ani-center-blue')

  $(document).find('.nav-active').removeClass('nav-active')



  // setting to active

  $(this).removeClass('nav-line-ani-center-blue')

  $(this).addClass('nav-active')

})



function closeTicket() {

  ticketsRemainingCheck()

};



function DisplayCurrentTime() {

        var date = new Date();

        var hours = date.getHours() > 12 ? date.getHours() - 12 : date.getHours();

        var am_pm = date.getHours() >= 12 ? "PM" : "AM";

        hours = hours < 10 ? "0" + hours : hours;

        var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();

        var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();

        time = hours + ":" + minutes + ":" + seconds + " " + am_pm;

        var lblTime = document.getElementById("lblTime");

        return time;

    };



function ticketsRemainingCheck() {

  var ticketsAmount = $('.ticket-open').length;

  if (ticketsAmount == 0) {

    $(document).find('.ticket-checker').show()

  } else if (ticketsAmount >= 1) {

    $(document).find('.ticket-checker').hide()

  }

};



$(document).on("click", "#close-interface", function() {

  $.post('http://trp_admin2/closereportpanel', JSON.stringify({}));

});



$(document).on("click", "#btn-submit-report", function() {

  $(this).closest('#report-box').find('#report-message').val($(this).closest('#report-box').find('#report-message').val().replace(new RegExp('<', 'g'),"&lt;"))

  $.post('http://trp_admin2/submitreport', JSON.stringify({

    report: $(this).closest('#report-box').find('#report-message').val()

  }));

  $(this).closest('#report-box').find('#report-message').val('')

});



$(document).on("click", "#admin-on", function() {

  $(this).toggleClass('active')

  console.log("Toggle UI JS")

  $.post('http://trp_admin2/adminonreportpanel', JSON.stringify({}));

});

