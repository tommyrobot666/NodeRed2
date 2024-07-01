extends PanelContainer

const customItemScene = preload("res://node placer/shop/CustomItem.tscn")

@onready var grid:GridContainer = $VBoxContainer/GridContainer

func _ready() -> void:
	grid.add_child(customItemScene.instantiate())
	grid.get_child(0). set_item_data("Godot Miner", preload("res://nodes/miners/Godot Miner Icon.png"), preload("res://nodes/miners/godot_miner.tscn"))
