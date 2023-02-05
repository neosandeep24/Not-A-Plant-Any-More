extends Node

export(PackedScene) var attack_scene
export(PackedScene) var dino_scene
# Called when the node enters the scene tree for the first time.
var score
var dinoLimit=3
var dinos=0
var level=1
var addDinoSpeed=30
func _ready():
	randomize()
	$StartRetry.text="GO!"
	$ScoreLabel.hide()
	$tree.sizer(level)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("attack"):
		var attack = attack_scene.instance()
		var atcfun = funcref(self, "on_dino_dhit")
		attack.fun=atcfun
		attack.position.x = $player.position.x
		attack.position.y = $player.position.y-10
		if $player.dirright:
			attack.rotation = 0
			attack.direction=1
		else:
			attack.rotation = PI
			attack.direction=-1
		add_child(attack)



func _on_DinoWaitTimer_timeout():
	var dino = dino_scene.instance()
	if int(randi()%2)==0:
		dino.position = $DinoSpawnPosition.position
	else:
		dino.position = $DinoSpawnPosition2.position
		dino.get_node("AnimatedSprite").scale.x=-1
		dino.direction=-1
	dino.speed+=addDinoSpeed*(level-1)
	add_child(dino)
	$DinoWaitTimer.start()

func _on_player_phit():
	print_debug("got: phit")
	$HUD.health-=10 
	$HUD/Health.text="Health: %d"%$HUD.health
	if $HUD.health==0:
		gameOver("Retry", "Your Score: %d")
		
func gameOver(var st, var st2):
	$player.hide()
	$DinoWaitTimer.stop()
	$StartRetry.show()
	$StartRetry.text=st
	$ScoreLabel.text = st2%score
	$ScoreLabel.show()

func on_dino_dhit():
	print_debug("here")
	score+=1
	dinos+=1
	if dinos==dinoLimit:
		dinos=0
		dinoLimit+=2
		if level==5:
			gameOver("Game Over","Your Score: %d")
		else:
			level+=1
			$tree.sizer(level)
			gameOver("Next: Level: %d"%(level),"Your Score: %d")
		

func _on_StartRetry_pressed():
	score=0
	$HUD.health=50
	
	if($StartRetry.text=="Retry"):
		dinos=0
		level=1
		$tree.sizer(level)
	$HUD/Health.text="Health: %d"%$HUD.health
	$ScoreLabel.hide()
	$player.start($StartPosition.position) # Replace with function body.
	$DinoWaitTimer.start()
	$StartRetry.hide()

func _on_tree_go():
	pass#gameOver() # Replace with function body.


func _on_BACK_pressed():
	get_tree().change_scene("res://screens/startmenu.tscn")
	
