extends Area2D
class_name Material_type

@export var type := ""

func _process(delta):
	var parent_p = get_parent().get_parent()
	parent_p.move_child(get_parent(),0)
