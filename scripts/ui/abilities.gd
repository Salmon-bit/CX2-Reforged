extends Control


func _ready():
	if Autoload.data.lang == "ru":
		$Info.texture = $Sprite981.texture
	
	for i in range(len($MarginContainer/VBoxContainer.get_children())):
		
