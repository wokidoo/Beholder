extends Resource
class_name Entity

func _init():
	self.resource_local_to_scene = true
	
@export var Properties: Array[Field]

# ------ SAVE TO DISK FUNCTION ------
## Saves the current Field resource to the given file path.
func save_to_disk(file_path: String) -> void:
	var error = ResourceSaver.save(self, file_path)
	if error == OK:
		print("Resource saved successfully at: ", file_path)
	else:
		print("Failed to save resource. Error code: ", error)
