// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


// product/new & product/edit
$(function() {
	$("#select_left").multiSelect("#select_right", {trigger: "#options_right"});
	$("#select_right").multiSelect("#select_left", {trigger: "#options_left"});
});