extends Area2D

const NEXT_SCENE_PATH = "res://Scenes/EndingError.tscn"

func _on_body_entered(body: Node2D) -> void:
	print("🚨 SOMETHING TOUCHED THE ZONE!")
	
	print("The thing touching it is named: ", body.name)
	
	if body is CharacterBody2D:
		print("✅ It is a CharacterBody2D! Changing scene now...")
		get_tree().change_scene_to_file(NEXT_SCENE_PATH)
	else:
		print("❌ It is NOT a CharacterBody2D. It is a: ", body.get_class())
