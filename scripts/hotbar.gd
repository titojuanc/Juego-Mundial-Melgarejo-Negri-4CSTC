extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Control/Slot1.index = 0
	$Control/Slot2.index = 1
	$Control/Slot3.index = 2
	$Control/Slot4.index = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
