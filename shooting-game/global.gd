extends Node
var points = 0
var camera = null
func instance_node(node, position, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = position
	return node_instance
