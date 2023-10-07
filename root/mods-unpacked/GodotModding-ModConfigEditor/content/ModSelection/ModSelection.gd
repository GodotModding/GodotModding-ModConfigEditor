extends PanelContainer


@onready var mod_list = $"%ModList"
@onready var config_editor = $"%ConfigEditor"


func _ready() -> void:
	mod_list.populate()


func _input(event) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_C:
			show() if not visible else hide()


func _on_ModList_mod_btn_pressed(mod_data: ModData) -> void:
	config_editor.mod_data = mod_data
	config_editor.update_ui()
	config_editor.show()


func apply_config(config: ModConfig) -> void:
	var material_settings: Dictionary = config.data.material_settings
