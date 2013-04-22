// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
  $(".red, .yellow").tooltip({ offset: [10, 2],
      predelay: 200,
      effect: 'slide'  
    });
    //.dynamic({ bottom: { direction: 'down', bounce: true } });
	/*
  $("div.red").tooltip(
    { offset: [10, 2],
      predelay: 1000,
      effect: 'slide'  
    }      
    );
    //.dynamic({ bottom: { direction: 'down', bounce: true } });
*/  
});
