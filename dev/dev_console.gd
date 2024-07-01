#some parts by The Shaggy Dev
extends CanvasLayer

@onready var line_edit:LineEdit = %DevConsoleLineEdit
@onready var label:RichTextLabel = %DevConsoleRichTextLabel

var history: Array[String] = []
var history_index: int = -1

var global := Global

var vars:Array[String] = []

func on_run_command(cmd: String) -> void:
	label.newline()
	label.append_text("- [b]"+cmd+"[/b]")
	
	var expression:Expression = Expression.new()
	var parse_error:int = expression.parse(cmd,vars)
	if parse_error != OK:
		#printerr(parse_error)
		label.newline()
		label.append_text("[color=red]"+error_string(parse_error)+"[/color]")
		#label.add_text("\n"+str(parse_error))
		return
	
	var result:Variant = expression.execute(vars, self)
	if result != null:
		label.add_text("\n"+str(result))
		#print(result)

func reload() -> void:
	get_tree().reload_current_scene()


func _on_line_edit_text_submitted(new_text:String) -> void:
	on_run_command(new_text)
	history.push_front(line_edit.text)
	history_index = -1
	line_edit.clear()


func _unhandled_input(event:InputEvent) -> void:
	if !event.is_echo() and event.is_action_pressed("dev_console"):
		if visible:
			hide()
		else:
			show()
	if visible:
		if !history.is_empty() and (event.is_action("ui_up") or event.is_action("ui_down")):
			if history_index == -1:
				history_index = 0
			#print(history_index,history,wrapi(history_index, 0, history.size()),wrapi(history_index+1, 0, history.size()),wrapi(history_index-1, 0, history.size()))
			if !event.is_echo() and event.is_action("ui_up"):
				history_index = wrapi(history_index+1, 0, history.size())
			elif !event.is_echo() and event.is_action("ui_down"):
				history_index = wrapi(history_index-1, 0, history.size())
			line_edit.text = history[history_index]
			line_edit.caret_column = line_edit.text.length()


func _on_dev_console_line_edit_text_changed(new_text:String) -> void:
	if !history.has(new_text):
		history_index = -1

