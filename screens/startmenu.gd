extends Control



func _on_Startbtn_pressed():
	get_tree().change_scene("res://Main.tscn")

func _on_Controls_pressed():
  get_tree().change_scene("res://Controls.tscn")

func _on_CreditBtn_pressed():
	get_tree().change_scene("res://Credits.tscn")
	

func _on_QuitBtn_pressed():
	get_tree().quit()





