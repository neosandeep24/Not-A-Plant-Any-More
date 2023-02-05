extends RigidBody2D

signal phit

export var speed = 400
var screen_size
var dirright=true

func _ready():
	screen_size = get_viewport_rect().size 
	hide()


func _process(delta):
	var velocity = Vector2.ZERO
	velocity.y+=80*delta
	var duck=false
	var attack=false
	if Input.is_action_pressed("attack"):
		attack=true
	if Input.is_action_pressed("mv_right"):
		velocity.x += 1
		dirright=true
	if Input.is_action_pressed("mv_left"):
		velocity.x -= 1
		dirright=false
	if Input.is_action_pressed("duck"):
		duck=true
	if Input.is_action_just_pressed("jump") && position.y==screen_size.y-(600-450):
		velocity.y -= 20
	if velocity.length()!=0:
		velocity = velocity * speed
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y-(600-450))
	if velocity.x != 0:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.x == 0:
		$AnimatedSprite.animation = "walk"
	if duck:
		$AnimatedSprite.animation = "duck"
	if attack:
		$AnimatedSprite.animation = "attack"
func start(pos):
	position = pos
	$CollisionShape2D.disabled = false
	show()
	$AnimatedSprite.play()


func _on_player_body_entered(body):
	if body.name == "dino":
		print_debug("emitted: phit")
		body.get_node("CollisionShape2D").set_deferred("disabled", true)
		body.get_node("AnimatedSprite").animation="dead"
		emit_signal("phit")
