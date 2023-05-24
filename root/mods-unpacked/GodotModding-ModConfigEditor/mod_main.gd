extends Node


var GodotModding_Mod_Config_MOD_DIR := "GodotModding-ModConfig"
var GodotModding_Mod_Config_LOG_NAME := "GodotModding-ModConfig"

var mod_dir_path := ""
var extensions_dir_path := ""
var translations_dir_path := ""


func _init(modLoader = ModLoader) -> void:
	ModLoaderLog.info("Init", GodotModding_Mod_Config_LOG_NAME)
	mod_dir_path = ModLoaderMod.get_unpacked_dir().plus_file(GodotModding_Mod_Config_MOD_DIR)

	# Add extensions
	install_script_extensions(modLoader)

	# Add translations
	add_translations(modLoader)


func install_script_extensions(modLoader) -> void:
	extensions_dir_path = mod_dir_path.plus_file("extensions")


func add_translations(modLoader) -> void:
	translations_dir_path = mod_dir_path.plus_file("translations")


func _ready():
	var mod_config_dialog = load("res://mods-unpacked/GodotModding-ModConfig/content/ModSelection/ModSelection.tscn").instance()
	get_tree().root.call_deferred("add_child", mod_config_dialog)


func handle_config() -> void:
	# Get the mod config
	var config := ModLoaderConfig.get_current_config(GodotModding_Mod_Config_MOD_DIR)
	print(JSON.print(config, '\t'))

