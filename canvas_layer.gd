extends CanvasLayer

@onready var debug_label: Label = $ColorRect/DebugLabel  # Adjust path based on your structure

func _ready():
	# Make sure we're on top
	layer = 100
	visible = true

func add_message(message: String, duration: float = 5.0):
	if debug_label:
		debug_label.text += "\n" + message
		
		# Optional: Auto-remove after duration
		if duration > 0:
			await get_tree().create_timer(duration).timeout
			remove_message(message)

func remove_message(message: String):
	if debug_label:
		var lines = debug_label.text.split("\n")
		var new_text = ""
		for line in lines:
			if line != message and line != "Debug Messages:":
				new_text += line + "\n"
		debug_label.text = "Debug Messages:" + ("\n" + new_text.strip_edges() if new_text else "")

func clear_messages():
	if debug_label:
		debug_label.text = "Debug Messages:"

# Optional: Toggle visibility with a key press
func _input(event):
	if event.is_action_pressed("ui_cancel"):  # Press ESC to toggle
		visible = !visible
