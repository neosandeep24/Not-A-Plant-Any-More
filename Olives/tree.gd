extends RigidBody2D

signal go

func _ready():
	pass


func _on_tree_body_entered(body):
	if body.name=="dino":
		body.queue_free()
		emit_signal("go")
		
func sizer(l):
	scale.x=l
	scale.y=l
