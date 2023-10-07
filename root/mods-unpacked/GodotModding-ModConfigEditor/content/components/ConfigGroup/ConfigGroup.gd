class_name ModConfigGroup
extends VBoxContainer


var group_name: String: set = _set_group_name

@onready var label_group_name = $"%GroupName"
@onready var group_components = $"%GroupComponents"


func _set_group_name(new_group_name: String) -> void:
	group_name = new_group_name
	label_group_name.text = new_group_name


func add_component(group_child_component: Node) -> void:
	group_components.add_child(group_child_component)
