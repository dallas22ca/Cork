$(document).on "click", ".toggle_sidebar", ->
	$("body").toggleClass "sidebar_open"
	false

$(document).on "click", ".upload_document", ->
	$("#document_file").trigger "click"
	false

$(document).on "change", "input[type='file']", ->
	$(this).closest("form").trigger "submit"
	false

$(document).on "submit", "form", ->
	setTimeout ->
		$(this)[0].reset()
	, 10

$(document).on "click", ".swap_tabs", ->
	next = $(this).data("tab")
	$(".tab:not(.#{next}_tab)").hide()
	$(".#{next}_tab").fadeIn()
	false