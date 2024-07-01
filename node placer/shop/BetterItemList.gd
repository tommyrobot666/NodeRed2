@icon("res://icon.svg")

extends ItemList
class_name BetterItemList

enum Expand {
	UpLeft, Up, UpRight,
	Left, None, Right,
	DownLeft, Down, DownRight}
enum ExpandFill {RowsToCollums,CollumsToRows}

@export var expand:Expand = Expand.DownRight
@export var expand_fill:ExpandFill = ExpandFill.CollumsToRows

@export var rows := 3
@export var collums := 3

@export var item_fixed_h_lengh:int = 0
@export var item_fixed_v_lengh:int = 0

@export var item_margin:Vector2

var items:Array[Item] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#clear()
	stuff(1)
	stuff(2)
	stuff(3)
	stuff(21)
	stuff(22)
	stuff(23)
	stuff(31)
	stuff(32)
	stuff(33)
	stuff(41)
	stuff(42)
	stuff(43)
	
	arrange_children()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta:float) -> void:
	#set_max_columns(item_count)
	arrange_children()
	pass


func stuff(item_num:int) -> void:
	var custom_item_scene := preload("res://node placer/CustomItem.tscn") as PackedScene
	var custom_item = custom_item_scene.instantiate()
	custom_item.set_item_data("Item " + str(item_num), preload("res://icon.svg"))
	custom_item.name = str(item_num)
	add_child(custom_item)


func arrange_children():
	items.clear()
	
	var next_pos = Vector2(0,0)
	
	var row = 1
	var collum = 1
	
	size = Vector2(0,0)
	
	for child in get_children():
		var item_child := child as Item
		
		items.append(item_child)
		
		if expand_fill == ExpandFill.CollumsToRows:
			print(item_child)
			if (expand == Expand.DownRight or expand == Expand.DownLeft) and row > rows:
				print("m")
				next_pos.y = 0
				row = 1
				if item_fixed_h_lengh > 0:
					print("y")
					if expand == Expand.UpRight or expand == Expand.Right or expand == Expand.DownRight or true:
						print(1)
						item_child.position = next_pos
						next_pos.x = next_pos.x + item_margin.x + item_fixed_h_lengh
						size.x += item_margin.x + item_fixed_h_lengh
					elif expand == Expand.UpLeft or expand == Expand.Left or expand == Expand.DownLeft:
						print(2)
						item_child.position = next_pos
						next_pos.x = next_pos.x - item_margin.x - item_fixed_h_lengh
						size.x -= item_margin.x - item_fixed_h_lengh
				else:
					pass
			elif (expand == Expand.DownRight or expand == Expand.DownLeft) and row <= rows:
				print("l")
				
				collum += 1
				
				if item_fixed_v_lengh > 0:
					print("x")
					if expand == Expand.UpRight or expand == Expand.Up or expand == Expand.UpRight or true:
						print(1)
						item_child.position = next_pos
						next_pos.y = next_pos.y + item_margin.y + item_fixed_v_lengh
						size.y += item_margin.y + item_fixed_v_lengh
					elif expand == Expand.DownLeft or expand == Expand.Down or expand == Expand.DownLeft:
						print(2)
						item_child.position = next_pos
						next_pos.y = next_pos.y - item_margin.y - item_fixed_v_lengh
						size.y -= item_margin.y - item_fixed_v_lengh
				else:
					pass
				row += 1
		
		
		if expand_fill == ExpandFill.RowsToCollums:
			print(item_child)
			if (expand == Expand.DownRight or expand == Expand.DownLeft) and collum > collums:
				print("m")
				next_pos.y = 0
				row = 1
				if item_fixed_h_lengh > 0:
					print("y")
					if expand == Expand.UpRight or expand == Expand.Right or expand == Expand.DownRight or true:
						print(1)
						item_child.position = next_pos
						next_pos.x = next_pos.x + item_margin.x + item_fixed_h_lengh
						size.x += item_margin.x + item_fixed_h_lengh
					elif expand == Expand.UpLeft or expand == Expand.Left or expand == Expand.DownLeft:
						print(2)
						item_child.position = next_pos
						next_pos.x = next_pos.x - item_margin.x - item_fixed_h_lengh
						size.x -= item_margin.x - item_fixed_h_lengh
				else:
					pass
			elif (expand == Expand.DownRight or expand == Expand.DownLeft) and collum <= collums:
				print("l")
				
				collum += 1
				
				if item_fixed_v_lengh > 0:
					print("x")
					if expand == Expand.UpRight or expand == Expand.Up or expand == Expand.UpRight or true:
						print(1)
						item_child.position = next_pos
						next_pos.y = next_pos.y + item_margin.y + item_fixed_v_lengh
						size.y += item_margin.y + item_fixed_v_lengh
					elif expand == Expand.DownLeft or expand == Expand.Down or expand == Expand.DownLeft:
						print(2)
						item_child.position = next_pos
						next_pos.y = next_pos.y - item_margin.y - item_fixed_v_lengh
						size.y -= item_margin.y - item_fixed_v_lengh
				else:
					pass
				row += 1
		
		print(item_child.position)
	
	print(size)
	print("######################")
