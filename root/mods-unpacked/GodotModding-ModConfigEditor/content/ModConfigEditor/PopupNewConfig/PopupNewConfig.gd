extends WindowDialog


signal pressed_submit(config_name)

onready var input_config_name = $"%InputConfigName"


func _on_ButtonConfigNameSubmit_pressed():
	emit_signal("pressed_submit", input_config_name.text)
