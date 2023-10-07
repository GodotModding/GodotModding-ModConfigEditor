extends PanelContainer


var mod_data: ModData: set = _set_mod_data
var selected_config: ModConfig: set = _set_selected_config
var edited_config: ModConfig

@export var error_text_add_config := "ERROR: Creating new config - check logs"
@export var error_text_remove_config := "ERROR: Deleting config - check logs"
@export var error_text_update_config := "ERROR: Updating config - check logs"
@export var info_default_config := "INFO: The default config cannot be modified. \n Please create a new config instead."

const LABEL_CONFIG_FOR_TEXT := "Configs for"

@onready var label_config_for := $"%LabelConfigFor"
@onready var config_selection := $"%ConfigSelection"
@onready var config_sections := $"%ConfigSections"
@onready var popup_new_config := $"%PopupNewConfig"
@onready var info_text := $"%InfoText"
@onready var button_save: Button = $"%ButtonSave"


func _set_mod_data(new_mod_data: ModData) -> void:
	mod_data = new_mod_data
	self.selected_config = mod_data.current_config


func _set_selected_config(new_selected_config: ModConfig) -> void:
	mod_data.current_config = new_selected_config
	selected_config = new_selected_config
	edited_config = ModConfig.new(
		new_selected_config.mod_id,
		new_selected_config.data.duplicate(true),
		new_selected_config.save_path,
		new_selected_config.schema
	)

	# Disable save button if default config
	if new_selected_config.name == ModLoaderConfig.DEFAULT_CONFIG_NAME:
		button_save.disabled = true
		info_text.text = info_default_config
	else:
		button_save.disabled = false
		info_text.text = ""


func update_ui() -> void:
	label_config_for.text = "%s %s" % [LABEL_CONFIG_FOR_TEXT, mod_data.dir_name]
	config_selection.populate(mod_data)
	_populate_config_sections()


func apply_config(config: ModConfig) -> void:
	var material_settings: Dictionary = config.data.material_settings


func _populate_config_sections() -> void:
	config_sections.config = edited_config
	config_sections.update_ui()


func _on_ButtonBack_pressed() -> void:
	hide()


func _on_ButtonSave_pressed() -> void:
	self.selected_config = edited_config
	var updated_config := ModLoaderConfig.update_config(edited_config)

	if not updated_config:
		info_text.text = error_text_update_config
		return

	update_ui()


func _on_ConfigSelection_config_selected(config: ModConfig) -> void:
	self.selected_config = config
	update_ui()


func _on_ConfigSelection_add_config_pressed() -> void:
	popup_new_config.show()


func _on_ConfigSelection_remove_config_pressed() -> void:
	var is_success := ModLoaderConfig.delete_config(selected_config)

	if not is_success:
		info_text.text = error_text_remove_config
		return

	update_ui()


func _on_PopupNewConfig_pressed_submit(config_name: String) -> void:
	var default_config := ModLoaderConfig.get_default_config(mod_data.dir_name)
	var new_config := ModLoaderConfig.create_config(mod_data.dir_name, config_name, default_config.data)

	if not new_config:
		info_text.text = error_text_add_config
		return

	ModLoaderConfig.set_current_config(new_config)
	self.selected_config = new_config
	update_ui()

	popup_new_config.hide()


func _on_ConfigSections_config_data_changed(input_component) -> void:
	if input_component.parent.is_empty():
		edited_config.data[input_component.key] = input_component.value
		return

	input_component.parent[input_component.key] = input_component.value
