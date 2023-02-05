extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed=700
signal dhit
var direction = 1
var fun
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("default")
	var main = get_node("./Main.tscn")
	connect("dhit", main, "_on_dino_dhit")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x+=speed*delta*direction


func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # Replace with function body.


func _on_attack_body_entered(body):
	if body.name == "dino":
		queue_free()
		body.dinoHealth-=10
		body.get_node("DinoHealth").text="Health: %d"%body.dinoHealth
		if body.dinoHealth==0:
			emit_signal("dhit")
			body.get_node("CollisionShape2D").set_deferred("disabled", true)
			body.get_node("AnimatedSprite").animation="dead"


func _on_attack_dhit():
	fun.call_func()
