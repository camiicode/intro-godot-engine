extends Button

@export var ingredient_scene: PackedScene  # Asignas scn_lipid.tscn desde el editor
@export var cell_node: Node2D  # Asignás la célula desde el editor

func _on_pressed() -> void:
	print("Botón de lípido presionado")

	var microscope_area = get_node("/root/level-1/StaticBody2D/CollisionPolygon2D")
	
	if microscope_area == null:
		push_error("No se encontró el CollisionPolygon2D")
		return

	var polygon = microscope_area.polygon
	var microscope_offset = microscope_area.global_position

	var spawn_pos = get_random_point_inside_polygon(polygon, microscope_offset)

	var ingredient = ingredient_scene.instantiate()
	ingredient.material_type = "protein" # Aqui se especifica que material se le va agregar
	ingredient.target_cell = cell_node
	ingredient.position = spawn_pos
	get_tree().current_scene.add_child(ingredient)

	ingredient.position = spawn_pos
	ingredient.target_cell = cell_node
	get_tree().current_scene.add_child(ingredient)


func get_random_point_inside_polygon(polygon: PackedVector2Array, offset_position: Vector2) -> Vector2:
	var min_x = INF
	var max_x = -INF
	var min_y = INF
	var max_y = -INF

	# Recorremos todos los puntos del polígono para encontrar los límites
	for point in polygon:
		if point.x < min_x:
			min_x = point.x
		if point.x > max_x:
			max_x = point.x
		if point.y < min_y:
			min_y = point.y
		if point.y > max_y:
			max_y = point.y

	var attempts = 0
	while attempts < 1000:
		var rand_x = randf_range(min_x, max_x)
		var rand_y = randf_range(min_y, max_y)
		var test_point = Vector2(rand_x, rand_y)

		if Geometry2D.is_point_in_polygon(test_point, polygon):
			return test_point + offset_position

		attempts += 1

	# Si no encontró uno válido después de 1000 intentos, da el centro
	return Vector2((min_x + max_x) / 2, (min_y + max_y) / 2) + offset_position
