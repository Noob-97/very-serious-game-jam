extends AudioStreamPlayer

# Grab a reference to your audio node
@onready var break_sfx = $AudioStreamPlayer2D 

func break_object():
	remove_child(break_sfx)
	
	get_tree().root.add_child(break_sfx)
	
	break_sfx.play()
	
	break_sfx.finished.connect(break_sfx.queue_free)
	
	queue_free()
