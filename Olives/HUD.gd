extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var health = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	$Health.text="Health: %d"%health


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
