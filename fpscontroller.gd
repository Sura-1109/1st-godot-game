extends CharacterBody3D  # or whatever your player extends

func _ready():
	add_to_group("player")  # Add this line
