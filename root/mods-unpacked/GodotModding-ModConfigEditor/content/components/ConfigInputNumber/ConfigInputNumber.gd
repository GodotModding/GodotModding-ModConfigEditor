class_name ModConfigInputNumber
extends ModConfigInput


var step setget _set_step
var max_value setget _set_max_value
var min_value setget _set_min_value

onready var h_slider: HSlider = $"%HSlider"
onready var spin_box: SpinBox = $"%SpinBox"


func _ready() -> void:
	# Connect the SpinBox with the Slider
	spin_box.share(h_slider)


func _set_value(new_value) -> void:
	._set_value(new_value)
	spin_box.value = new_value


func _set_step(new_step) -> void:
	if new_step == null:
		step = 0
		spin_box.step = 0
		return

	step = new_step
	spin_box.step = new_step


func _set_max_value(new_max_value) -> void:
	if new_max_value == null:
		spin_box.allow_greater = true
		return

	spin_box.allow_greater = false
	max_value = new_max_value
	spin_box.max_value = new_max_value


func _set_min_value(new_min_value) -> void:
	if new_min_value == null:
		spin_box.allow_lesser = true
		return

	spin_box.allow_lesser = false
	min_value = new_min_value
	spin_box.min_value = new_min_value


func _on_SpinBox_value_changed(new_value: float) -> void:
	value = new_value
	emit_value_changed()
