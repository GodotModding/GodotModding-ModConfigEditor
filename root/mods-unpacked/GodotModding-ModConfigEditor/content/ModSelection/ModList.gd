extends VBoxContainer


signal mod_btn_pressed(mod_id)

@export var mod_button_scene: PackedScene


func populate() -> void:
	# Add a button for each mod with a default config
	for mod_data in ModLoaderConfig.get_mods_with_config():
		var mod_button := mod_button_scene.instantiate()
		add_child(mod_button)
		# dir_name is the same as mod_id
		mod_button.mod_data = mod_data
		mod_button.connect("mod_btn_pressed", Callable(self, "_on_mod_button_pressed"))


func _on_mod_button_pressed(mod_data: ModData) -> void:
	emit_signal("mod_btn_pressed", mod_data)
