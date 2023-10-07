extends Button


signal mod_btn_pressed(mod_data)

var mod_data: ModData: set = _set_mod_data


func _set_mod_data(new_mod_data) -> void:
	mod_data = new_mod_data
	self.text = mod_data.dir_name


func _on_ModButton_pressed():
	emit_signal("mod_btn_pressed", mod_data)
