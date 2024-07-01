extends Area2D
class_name GraphArea

@onready var Shape := $CollisionShape2D as CollisionShape2D
@onready var graph := %GraphEdit as GraphEdit
@onready var SnapeShape := Shape.shape as RectangleShape2D

func _process(_delta:float) -> void:
	SnapeShape.size = graph.size
	global_position = graph.global_position + Vector2(graph.size.x/2, graph.size.y/2)
