class_name ModConfigInputString
extends ModConfigInput


@onready var line_edit: LineEdit = $"%LineEdit"


func _set_value(new_value: String) -> void:
	super._set_value(new_value)
	line_edit.text = new_value


func _on_LineEdit_text_changed(new_text: String) -> void:
	super._set_value(new_text)
	emit_value_changed()
