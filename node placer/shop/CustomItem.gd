extends VBoxContainer
class_name Item

@export var draggable := true

@export var graph_element:PackedScene = preload("res://nodes/miners/godot_miner.tscn")

@onready var icon : TextureRect = $TextureRect
@onready var label : Label = $Label

@onready var area : Area2D = $Area2D
@onready var collide : CollisionShape2D = $Area2D/CollisionShape2D

@onready var graph : GraphEdit = %GraphEdit

var dragging := false

func _process(_delta:float) -> void:
	if draggable:
		if dragging:
			position = get_global_mouse_position() - size/2
			if Input.is_action_just_released("click"):
				stopped_dragging()
		elif !dragging and Input.is_action_just_pressed("click"):
			var mouse_point := PhysicsPointQueryParameters2D.new()
			mouse_point.collide_with_bodies = false
			mouse_point.collide_with_areas = true
			mouse_point.position = get_global_mouse_position()
			mouse_point.collision_mask = 64
			if get_world_2d().direct_space_state.intersect_point(mouse_point).any(func(item): return item["collider"] == area):
				dragging = true
	(collide.shape as RectangleShape2D).size = size
	area.position = size/2


func set_item_data(text:String, icon_texture:Texture, element:PackedScene) -> void:
	icon = $VBoxContainer/TextureRect
	label = $VBoxContainer/Label
	label.text = text
	icon.texture = icon_texture
	if element:
		graph_element = element


func stopped_dragging() -> void:
	dragging = false
	
	var graph_found:bool = false
	
	for shape in area.get_overlapping_areas():
		if (shape is GraphArea):
			graph_found = true
			break
	
	if graph_found:
		var new_node:GraphNode = graph_element.instantiate()
		graph.add_child(new_node)
		new_node.position_offset = (global_position - graph.global_position + graph.scroll_offset) / graph.zoom
		#queue_free()
	
	var container_parent := get_parent() as Container
	if container_parent:
		container_parent.queue_sort()

func e(i):
	print(i["collider"] == self)
	return true
