extends PanelContainer

const customItemScene = preload("res://node placer/shop/CustomItem.tscn")

@onready var grid:GridContainer = $VBoxContainer/GridContainer

func _ready() -> void:
	var c = customItemScene.instantiate()
	var s = """6 Metal"""
	c.set_item_data(s, preload("res://nodes/miners/Godot Miner Icon.png"), preload("res://nodes/miners/godot_miner.tscn"))
	grid.add_child(c)
