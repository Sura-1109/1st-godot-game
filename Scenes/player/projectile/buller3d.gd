extends Node3D

const SPEED = 55.0
const RANGE = 40.0

var travelled_distance = 0.0


func _physics_process(delta): #to add a leftward degree curve
	var left_direction = -transform.basis.z.rotated(Vector3.UP, deg_to_rad(10.5))
	position += left_direction * SPEED * delta
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()


func _on_bullet_3d_body_entered(body: Node3D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
