extends RigidBody3D

@onready var bat_model = %bat_model
var player: Node3D

var health = 3
var is_dying = false
var speed = randf_range(2.0, 4.0)

func _ready():
	add_to_group("enemies")
	randomize_color()
	find_player()

func find_player():
	# Find player by group (most reliable)
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
		print("Player found via group!")
		return
	
	print("Player not found. Bat won't move.")
	set_physics_process(false)

func _physics_process(_delta):
	if is_dying or player == null:
		return
	
	# Move toward player
	var direction = global_position.direction_to(player.global_position)
	direction.y = 0.0  # Keep movement horizontal
	linear_velocity = direction * speed
	
	# Rotate bat model to face movement direction
	bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) + PI

func randomize_color():
	# Find ALL MeshInstance3D nodes in the bat
	var all_meshes = find_children("*", "MeshInstance3D", true)
	
	# Choose a random theme
	var themes = ["fire", "ice", "forest", "electric", "shadow"]
	var chosen_theme = themes[randi() % themes.size()]
	
	# Color all meshes with theme colors (alternating for variety)
	for i in range(all_meshes.size()):
		var mesh = all_meshes[i]
		if mesh is MeshInstance3D:
			if mesh.material_override == null:
				mesh.material_override = StandardMaterial3D.new()
			
			# Alternate colors based on mesh index
			match chosen_theme:
				"fire":
					mesh.material_override.albedo_color = [Color(1.0, 0.3, 0.2), Color(1.0, 0.5, 0.3), Color(1.0, 0.7, 0.4)][i % 3]
				"ice":
					mesh.material_override.albedo_color = [Color(0.7, 0.9, 1.0), Color(0.5, 0.8, 1.0), Color(0.3, 0.7, 1.0)][i % 3]
				"forest":
					mesh.material_override.albedo_color = [Color(0.0, 0.3, 0.1), Color(0.0, 0.4, 0.2), Color(0.1, 0.5, 0.3)][i % 3]
				"electric":
					mesh.material_override.albedo_color = [Color(0.2, 0.6, 1.0), Color(0.9, 0.9, 0.3), Color(0.4, 0.8, 1.0)][i % 3]
				"shadow":
					mesh.material_override.albedo_color = [Color(0.1, 0.1, 0.1), Color(0.3, 0.3, 0.3), Color(0.5, 0.5, 0.5)][i % 3]

func take_damage():
	if is_dying:
		return
	
	health -= 1
	
	# Play hurt animation
	bat_model.hurt()
	
	if health <= 0:
		die()

func die():
	is_dying = true
	linear_velocity = Vector3.ZERO  # Stop moving when dying
	queue_free()
