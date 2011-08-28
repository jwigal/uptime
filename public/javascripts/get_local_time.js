$(document).ready(function(){
  $.get("/statuses.js", {zone: jstz.determine_timezone().timezone.olson_tz})
});