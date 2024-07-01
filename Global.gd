extends Node

var savers:Array[Node] = [self]

var material_icons:Dictionary = {
	"Godot":preload("res://nodes/mineable/godot/Godot Material Icon.png")
}

func save_game() -> void:
	var the_saved_game:Dictionary = {}
	
	for saver in savers:
		@warning_ignore("unsafe_method_access", "unsafe_cast")
		the_saved_game.merge(saver.call("save") as Dictionary)
	
	var save1 := FileAccess.open("user://save1.nodered",FileAccess.WRITE)
	var json_string := JSON.stringify(the_saved_game)
	save1.store_string(json_string)

func save() -> Dictionary:
	return {}

func load_game() -> void:
	var the_saved_game := FileAccess.open("user://save1.nodered", FileAccess.READ)
	
	while the_saved_game.get_position() < the_saved_game.get_length():
		var json_string := the_saved_game.get_line()
		var json := JSON.new()
		var parse_result := json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		
		var data:Dictionary = json.get_data() #a dictionary?
		print(data)

# https://docs.godotengine.org/en/stable/classes/class_configfile.html#class-configfile
