class_name ModConfigInputColor
extends ModConfigInput


onready var color_picker_button: ColorPickerButton = $"%ColorPickerButton"


func _set_value(new_value: String) -> void:
	value = new_value
	color_picker_button.color = Color(new_value)


func _on_ColorPickerButton_color_changed(color: Color) -> void:
	value = color.to_html()
	emit_value_changed()
