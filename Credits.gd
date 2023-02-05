extends Node2D



func _on_VideoPlayer_finished():
	$VideoPlayer.play()


func _on_Button_pressed():
	get_tree().change_scene("res://screens/startmenu.tscn")
