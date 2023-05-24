extends WindowDialog


onready var mod_list = $"%ModList"
onready var config_editor = $"%ConfigEditor"


func _ready() -> void:
 mod_list.populate()


func _input(event) -> void:
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_C:
			popup_centered() if not visible else hide()


func _on_ModList_mod_btn_pressed(mod_data: ModData) -> void:
	config_editor.mod_data = mod_data
	config_editor.update_ui()
	config_editor.show()


func apply_config(config: ModConfig) -> void:
	var material_settings: Dictionary = config.data.material_settings

	material.set_shader_param("animate", material_settings.animate)
	material.set_shader_param("square_scale", material_settings.square_scale)
	material.set_shader_param("blur_amount", material_settings.blur_amount)
	material.set_shader_param("mix_amount", material_settings.mix_amount)
	material.set_shader_param("color_over", Color(material_settings.color))
