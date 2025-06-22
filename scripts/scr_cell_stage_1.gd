extends CharacterBody2D

@export var rotation_speed_degrees := 15.0 # grados por segundo, editable desde el editor
var random_velocity: Vector2 = Vector2.ZERO
var min_force := 0.5
var max_force := 1

func _ready():
	random_velocity = get_random_direction()

func _physics_process(delta):
	velocity = random_velocity
	move_and_slide()

	# Rotación en su propio eje
	rotation += deg_to_rad(rotation_speed_degrees) * delta

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		random_velocity = random_velocity.bounce(collision.get_normal()).normalized() * randf_range(min_force, max_force)
		break

func get_random_direction() -> Vector2:
	return Vector2(
		randf_range(-1, 1),
		randf_range(-1, 1)
	).normalized() * randf_range(min_force, max_force)
