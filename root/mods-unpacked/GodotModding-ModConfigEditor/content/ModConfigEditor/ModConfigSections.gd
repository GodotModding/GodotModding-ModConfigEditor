extends VBoxContainer


signal config_data_changed(input_component)

export(PackedScene) var group_component_scene: PackedScene
export(PackedScene) var string_input_component_scene: PackedScene
export(PackedScene) var color_input_component_scene: PackedScene
export(PackedScene) var number_input_component_scene: PackedScene
export(PackedScene) var boolean_input_component_scene: PackedScene

var config: ModConfig


func update_ui() -> void:
	_clear()
	_populate()


func _populate(data := config.data, parent_prop_key := "", parent_prop := {}, current_group_component: Node = null) -> void:
	for key in data.keys():
		# The current prop key plus all parent keys
		var full_prop_key: String = "%s.%s" % [parent_prop_key, key] if parent_prop_key else key
		var prop = data[key]
		var prop_schema := ModLoaderConfig.get_schema_for_prop(config, full_prop_key)

		if prop_schema.type == JSONSchema.JST_OBJECT:
			var group_node := _add_group(prop_schema.title, current_group_component)
			_populate(prop, full_prop_key, prop, group_node)

		if prop_schema.type == JSONSchema.JST_NUMBER:
			_add_number_input(
				key,
				parent_prop,
				prop_schema.title,
				prop,
				prop_schema.minimum,
				prop_schema.maximum,
				prop_schema.multipleOf,
				current_group_component
			)

		if prop_schema.type == JSONSchema.JST_STRING:
			# if the the color format is specified
			if prop_schema.has(JSONSchema.JSKW_FORMAT) and prop_schema.format == JSONSchema.JSKW_COLOR:
				_add_color_input(key, parent_prop, prop_schema.title, prop, current_group_component)
				continue

			_add_string_input(key, parent_prop, prop_schema.title, prop, current_group_component)

		if prop_schema.type == JSONSchema.JST_BOOLEAN:
			_add_boolean_input(key, parent_prop, prop_schema.title, prop, current_group_component)


func _clear() -> void:
	for child in get_children():
		remove_child(child)
		child.free()


func _add_group(group_name: String, parent_node: Node) -> Node:
	var group_component: ModConfigGroup = _add_component(group_component_scene, parent_node)

	group_component.group_name = group_name

	return group_component


func _add_string_input(key: String, parent_data: Dictionary, title: String, value: String, parent_node: Node) -> void:
	var string_input_component: ModConfigInputString = _add_component(string_input_component_scene, parent_node)

	string_input_component.key = key
	string_input_component.parent = parent_data
	string_input_component.title = title
	string_input_component.value = value


func _add_color_input(key: String, parent_data: Dictionary, title: String, value: String, parent_node: Node) -> void:
	var color_input_component: ModConfigInputColor = _add_component(color_input_component_scene, parent_node)

	color_input_component.key = key
	color_input_component.parent = parent_data
	color_input_component.title = title
	color_input_component.value = value


func _add_number_input(key: String, parent_data: Dictionary, title: String, value, min_value = null, max_value = null, step = null, parent_node: Node = null) -> void:
	var number_input_component: ModConfigInputNumber = _add_component(number_input_component_scene, parent_node)

	number_input_component.key = key
	number_input_component.parent = parent_data
	number_input_component.title = title
	number_input_component.step = step
	number_input_component.min_value = min_value
	number_input_component.max_value = max_value
	# Update the value last so it takes the other properties into account
	number_input_component.value = value


func _add_boolean_input(key: String, parent_data: Dictionary, title: String, value: bool, parent_node: Node) -> void:
	var boolean_input_component: ModConfigInputBoolean = _add_component(boolean_input_component_scene, parent_node)

	boolean_input_component.key = key
	boolean_input_component.parent = parent_data
	boolean_input_component.title = title
	boolean_input_component.value = value


func _add_component(component_scene: PackedScene, parent_node: Node) -> Node:
	var component: Node = component_scene.instance()
	component.connect("value_changed", self, "_on_ConfigInput_value_changed")

	if parent_node:
		parent_node.add_component(component)
	else:
		add_child(component)

	return component


func _on_ConfigInput_value_changed(input_component: ModConfigInput) -> void:
	emit_signal("config_data_changed", input_component)
