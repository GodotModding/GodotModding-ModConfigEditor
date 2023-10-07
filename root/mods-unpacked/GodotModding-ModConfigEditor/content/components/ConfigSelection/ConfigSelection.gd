extends HBoxContainer


signal config_selected(config)
signal add_config_pressed
signal remove_config_pressed

@onready var current_config_select: ModConfigCurrentConfigSelect = $"%CurrentConfigSelect"


func populate(mod_data: ModData) -> void:
	# Clear the Select Button
	current_config_select.clear()

	# Set the mod_id
	current_config_select.mod_id = mod_data.dir_name

	# Add each config name
	current_config_select.add_mod_configs(mod_data.configs)

	# Set it to the current_config
	current_config_select.select_item(mod_data.current_config.name)


func _on_CurrentConfigSelect_current_config_selected(mod_id: String, config_name: String) -> void:
	var config := ModLoaderConfig.get_config(mod_id, config_name)
	emit_signal("config_selected", config)


func _on_ButtonNewConfig_pressed():
	emit_signal("add_config_pressed")


func _on_ButtonDeleteConfig_pressed():
	emit_signal("remove_config_pressed")
