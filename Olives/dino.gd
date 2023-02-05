extends RigidBody2D
# Declare member variables here. Examples:
export var speed=300
var dinoHealth 
var direction=1
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	dinoHealth = 10 + 10* int(randi()%3)
	$DinoHealth.text="Health: %d"%dinoHealth
	$AnimatedSprite.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x-=speed*delta*direction


func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # Replace with function body.


func _on_AnimatedSprite_animation_finished():
	if($AnimatedSprite.animation=="dead"):
		queue_free()
