extends Area2D

@export var target_cell: Node2D
@export var material_type: String = "lipid"
var speed = 30
var absorbed = false
var absorbing = false  # ← Nuevo estado

func _process(delta):
	if target_cell and not absorbed:
		var direction = (target_cell.global_position - global_position).normalized()
		position += direction * speed * delta

		if global_position.distance_to(target_cell.global_position) < 10:
			absorbing = true
			absorbed = true  # Ya no se mueve, solo se absorbe

	if absorbing:
		scale -= Vector2(0.5, 0.5) * delta
		if scale.x <= 0.1:
			inform_cell()
			queue_free()

func inform_cell():
	if target_cell and target_cell.has_method("add_ingredient"):
		var percentage = randf_range(0.25, 1.0)
		target_cell.add_ingredient(material_type, percentage)
