extends GraphNode
class_name Storage

@export var max_storage := 5
@export var auto_dump := false
@export var auto_store := true

@export var material_icons:Dictionary = Global.material_icons

@onready var item_list := $ItemList as ItemList
@onready var progress_bar:ProgressBar = $Full as ProgressBar
@onready var auto_dump_button := $"HBoxContainer/VBoxContainer/Auto Dump" as CheckButton
@onready var auto_store_button := $"HBoxContainer/VBoxContainer/Auto Store" as CheckButton

var stored:Array[String] = []

var conncetions:Array[Node] = []

func store(item:String) -> void:
	if stored.size() < max_storage:
		stored.append(item)
		item_list.add_item(item,material_icons[item] as Texture2D)
	elif auto_dump:
		stored.pop_front()
		item_list.remove_item(0)
		store(item)

func _ready() -> void:
	progress_bar.max_value = max_storage
	auto_dump_button.button_pressed = auto_dump
	auto_store_button.button_pressed = auto_store
	item_list.clear()

func _process(_delta:float) -> void:
	
	if auto_store:
		for connection in conncetions:
			
			var miner := connection as Miner
			
			if miner != null:
				if miner.current_minable > -1 and miner.mining_progress >= 100 and ((stored.size() < max_storage and !auto_dump) or auto_dump): # last "and" is to check if storage would overflow
					miner.take_minable()
					store(miner.mineables[miner.current_minable])
	
	progress_bar.value = stored.size()
	
	#item_list.custom_minimum_size = Vector2(0,floor(stored.size() as float /5)*32)


func _on_remove_item_pressed() -> void:
	stored.pop_front()
	item_list.remove_item(0)


func _on_auto_store_toggled(toggled_on:bool) -> void:
	auto_store = toggled_on


func _on_auto_dump_toggled(toggled_on:bool) -> void:
	auto_dump = toggled_on


func _on_node_selected() -> void:
	pass # Replace with function body.

# saver code
func _enter_tree():
	Global.savers.append(self)

func _exit_tree():
	Global.savers.erase(self)

func save() -> Dictionary:
	return {
		"position":position_offset
	}

func load_from_save(node_data:Dictionary) -> void:
	pass
