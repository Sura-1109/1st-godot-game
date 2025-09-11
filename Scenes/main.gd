extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = "HELLO WORLD"
	$Label.modulate = Color.BLUE
	
func _input(event):
	if event.is_action_pressed("action"):
		$Label.modulate = Color.BLACK
	
	if event.is_action_released("action"):
		
			$Label.modulate = Color.BLUE
