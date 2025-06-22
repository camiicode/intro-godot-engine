extends Sprite2D

@export var lipid_scene: PackedScene

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			print("clicked")
			
			# Crea un nuevo lípido
			var lipid = lipid_scene.instantiate()
			
			# Posición aleatoria cerca del centro (ajústalo como gustes)
			var random_pos = Vector2(randf_range(-100, 100), randf_range(-100, 100))
			lipid.position = get_global_position() + random_pos
			
			# Añade el lípido a la escena principal
			get_tree().current_scene.add_child(lipid)
