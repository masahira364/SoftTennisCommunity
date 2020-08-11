# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('#team_postcode').jpostal({
		postcode : ["#team_postcode"],
		address  : {
						"#team_prefecture_code" : "%3",
						"#team_address"    : "%4%5%6",
		}
	})