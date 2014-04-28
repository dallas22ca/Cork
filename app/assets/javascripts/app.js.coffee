$(document).on "click", ".toggle_sidebar", ->
	$("body").toggleClass "sidebar_open"
	false

$(document).on "click", ".upload_document", ->
	$("#document_file").trigger "click"
	false

$(document).on "change", "input[type='file']", ->
	$(this).closest("form").trigger "submit"
	false

$(document).on "click", ".swap_tabs", ->
	next = $(this).data("tab")
	$(".tab:not(.#{next}_tab)").hide()
	$(".#{next}_tab").fadeIn()
	false

$(document).on "click", ".show_password_fields", ->
	$(".password_fields").slideToggle()
	$(this).closest("p").hide()
	false

$(document).on "click", "#sidebar a:not(.toggle_sidebar)", ->
	$("body").removeClass "sidebar_open"
	
$(document).on "paste", ".task .content[contenteditable]", (e) ->
	content = (e.originalEvent || e).clipboardData.getData("text/plain") || prompt("Paste something...")
	pasteHtmlAtCaret content
	false

$(document).on "keypress", ".task .content[contenteditable]", (e) ->
	code = if e.keyCode then e.keyCode else e.which
	false if code == 13

$(document).on "blur", ".task .content", ->
	task = $(this).closest(".task")
	url = task.data("url")
	content = $(this).text()
	
	if task.data("content") != content
		task.data "content", content

		$.post "#{url}.js",
			_method: "patch"
			task:
				content: content

pasteHtmlAtCaret = (html) ->
  sel = undefined
  range = undefined
  if window.getSelection
    sel = window.getSelection()
    if sel.getRangeAt and sel.rangeCount
      range = sel.getRangeAt(0)
      range.deleteContents()
      el = document.createElement("div")
      el.innerHTML = html
      frag = document.createDocumentFragment()
      node = undefined
      lastNode = undefined
      lastNode = frag.appendChild(node) while (node = el.firstChild)
      range.insertNode frag
      if lastNode
        range = range.cloneRange()
        range.setStartAfter lastNode
        range.collapse true
        sel.removeAllRanges()
        sel.addRange range
  else document.selection.createRange().pasteHTML html if document.selection and document.selection.type isnt "Control"
	

unload = ->
	$(".loading").fadeIn()

load = ->
	$(".loading").fadeOut 100

document.addEventListener "page:fetch", unload
document.addEventListener "page:change", load