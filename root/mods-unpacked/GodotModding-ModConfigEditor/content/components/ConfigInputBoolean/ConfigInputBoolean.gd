class_name ModConfigInputBoolean
extends ModConfigInput


onready var check_box: CheckBox = $"%CheckBox"


func _set_value(new_value: bool) -> void:
	._set_value(new_value)
	check_box.pressed = new_value


func _on_CheckBox_toggled(button_pressed: bool) -> void:
	value = button_pressed
	emit_value_changed()
