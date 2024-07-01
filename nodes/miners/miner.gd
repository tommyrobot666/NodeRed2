extends GraphNode
class_name Miner

@export var time:bool = true

@export var mineables:Array[String] = ["Godot"]
@export var speeds:Array[float] = [5.1]

@onready var progress_bar:ProgressBar = $VBoxContainer/ProgressBar as ProgressBar
@onready var area2d:Area2D = $Area2D as Area2D

var mining_progress := 0.0

var current_minable := -1 #none
var stored_minable := -1

func _ready() -> void:
	generate_area_shape()

func _process(_delta:float) -> void:
	if current_minable > -1:
		if time:
			mining_progress = min(100, mining_progress + speeds[current_minable])
		else:
			mining_progress = 100
			stored_minable = current_minable
	
	if progress_bar != null:
		progress_bar.value = mining_progress
		if !time:
			progress_bar.add_theme_color_override("font_color",Color(0,0,0,0))
		else:
			progress_bar.remove_theme_color_override("font_color")


func _on_dragged(_from:Vector2, _to:Vector2) -> void:
	get_current_minable()


func get_current_minable() -> void:
	current_minable = -1
	
	for area in area2d.get_overlapping_areas():
		var mat := area as Material_type
		if mat == null:
			return
		
		for minable:int in range(mineables.size()):
			if mineables[minable] == mat.type:
				current_minable = minable
				break

func generate_area_shape() -> void:
	var shape:CollisionShape2D = area2d.get_node("CollisionShape2D") as CollisionShape2D
	
	if shape == null:
		return
	
	var new_shape:RectangleShape2D = RectangleShape2D.new()
	new_shape.size = size/2
	
	shape.position = size/2
	shape.shape = new_shape

func take_minable():
	mining_progress = 0
	stored_minable = -1

