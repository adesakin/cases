// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery.remotipart
//= require jquery.ui.all
//= require foundation
//= require turbolinks
//= require cocoon
//= require_tree .
//= require best_in_place
//= require best_in_place.purr

$(function(){ 
	$(document).foundation(); 

	$(document).ready(function() {
      jQuery(".best_in_place").best_in_place();
    });


$(document).ready(function() {
  $('body').on('ajax:beforeSend', 'a[data-remote="true"]', function(event, xhr, settings) {
    if (settings.type == 'GET') {
      xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    }
  });
});


});
