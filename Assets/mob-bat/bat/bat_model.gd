extends Node3D
@onready var animation_tree: AnimationTree = %AnimationTree

func hurt():
	# For boolean parameters, use 'true' instead of 1
	animation_tree.set("parameters/OneShot/request", true)  # Changed from 1 to true
	
	# If it's a trigger parameter, you might need to use this instead:
	# animation_tree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_START)w 	
