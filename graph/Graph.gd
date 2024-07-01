extends GraphEdit

@export var connectables:Array[Array] = [
	["Miner","Storage"],
	["Storage","Storage"]
]
# Next Uppdate Try {name of var}:Array[Array[String]]

func _on_connection_request(from_node:StringName, from_port:int, to_node:StringName, to_port:int) -> void:
	if compatible(from_node,to_node):
		connect_node(from_node,from_port,to_node,to_port)
		
		var to_node_storage := get_node(NodePath(to_node)) as Storage
		if to_node_storage != null:
			to_node_storage.conncetions += [get_node(NodePath(from_node))]


func _on_disconnection_request(from_node:StringName, from_port:int, to_node:StringName, to_port:int) -> void:
	disconnect_node(from_node,from_port,to_node,to_port)
	
	var to_node_storage := get_node(NodePath(to_node)) as Storage
	if to_node_storage != null:
		to_node_storage.conncetions.erase(get_node(NodePath(from_node)))



func compatible(n1:StringName,n2:StringName) -> bool:
	for connectable:Array in connectables:
		if n1.contains(connectable[0]) and n2.contains(connectable[1]):
			return true
	return false
