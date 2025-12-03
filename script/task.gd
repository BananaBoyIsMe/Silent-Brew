extends Node2D

@onready var task_list = $task_list

func label_change(labell: String) -> void:
	task_list.get_child(0).text = labell
