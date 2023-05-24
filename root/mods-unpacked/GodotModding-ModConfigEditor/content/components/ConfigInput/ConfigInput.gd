class_name ModConfigInput
extends HBoxContainer


signal value_changed(value, key)

var parent: Dictionary
var key: String
var title: String setget _set_title
var value setget _set_value

onready var title_label: Label = $"%TitleLabel"


func _set_title(new_title: String) -> void:
	title = new_title
	title_label.text = new_title


func _set_value(new_value) -> void:
	value = new_value


func emit_value_changed() -> void:
	emit_signal("value_changed", self)
