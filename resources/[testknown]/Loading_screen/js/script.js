



// Runtime util for the loadingbar
function loadingbar() {
  var count, thisCount = 0;
  const handlers = {
    startInitFunctionOrder(data) {
      count = data.count;
      // data.type could be INIT_BEFORE_MAP_LOADED, INIT_AFTER_MAP_LOADED, or INIT_SESSION
    },
    initFunctionInvoking(data) {
      document.querySelector('.bar span').style.width = ((data.idx / count) * 100) + '%';
    },
    performMapLoadFunction(data) {
      ++thisCount;
      document.querySelector('.bar span').style.width = ((thisCount / count) * 100) + '%';
    }
  }
  window.addEventListener('message', (e) => {
    (handlers[e.data.eventName] || function() {})(e.data);
  }); // Event listener for loading bar
}

function meta() {
  document.getElementById('server-name').innerHTML = conf.serverName;
  document.getElementById("footer-alt").innerHTML = conf.serverFooter
}

window.addEventListener("DOMContentLoaded", () => {
  document.body.style.opacity = "1";
  init();
  if (document.getElementById("server-logo").naturalHeight === 0) {
    return logo();
  }
}); // Hides page until loaded