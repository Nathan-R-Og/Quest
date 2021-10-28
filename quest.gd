extends Node2D


var quest = [["Woah","dassa quest", false, "default", false, Vector2(0,0), "res://Node2D"],
["I KNOW RIGHT","its so cool", false, "default"],
["not really","(i am a pessimist)", true, "default"],
["shut up","i didnt ask", true, "default"]
]


var deleteId = 0

func _ready():
	list()

#####
#use get_tree().edited_scene_root.filename to check the current scene this is being ran in


func list():
	var deleteAtor = $Quests.get_child_count()
	while deleteAtor > 0:
		$Quests.get_child(deleteAtor - 1).queue_free()
		deleteAtor -= 1
	
	var iterateor = 0
	while iterateor < quest.size():
		var curr = quest[iterateor]
		var questInstance = preload("res://questAsset.tscn").instance()
		var textNode = questInstance.get_node("HBoxContainer/Text")
		textNode.get_node("header").text = curr[0]
		textNode.get_node("text").text = curr[1]
		var stateRead = ""
		match curr[2]:
			false:
				stateRead = "UNCOMPLETED"
			true:
				stateRead = "COMPLETED"
		textNode.get_node("state").text = stateRead
		questInstance.get_node("HBoxContainer/img/icon").animation = curr[3]
		var size = 64
		var base = textNode.rect_size.y / size
		questInstance.get_node("HBoxContainer/img/icon").scale = questInstance.get_node("HBoxContainer/img/icon").scale * base
		
		var Secondbase = questInstance.get_node("HBoxContainer/img/icon").scale.x * size
		questInstance.get_node("HBoxContainer/img/waypointEnable").scale = questInstance.get_node("HBoxContainer/img/icon").scale / 4
		questInstance.get_node("HBoxContainer/img/waypointEnable").position.x = Secondbase - (questInstance.get_node("HBoxContainer/img/waypointEnable").scale.x * (size / 2))
		questInstance.get_node("HBoxContainer/img/waypointEnable").modulate.r = int(curr[3])
		questInstance.get_node("Button").rect_size.x = textNode.rect_size.x + (base * (size / 4))
		questInstance.get_node("Button").rect_size.y = textNode.rect_size.y
		questInstance.get_node("Button").connect("pressed", self, "_questSelect", [iterateor])
		questInstance.get_node("HBoxContainer/img/waypointEnable/wayPoint").rect_size = questInstance.get_node("HBoxContainer/img/waypointEnable").scale * size
		questInstance.get_node("HBoxContainer/img/waypointEnable/wayPoint").connect("pressed", self, "_wayPointSelect", [iterateor])
		$Quests.add_child(questInstance)
		curr.append(questInstance)
		iterateor += 1


func _questSelect(id):
	deleteId = id
	var yeah = quest[id]
	var nodeHandle = yeah[4]
	$Quest_Delete.popup()
	$Quest_Delete.rect_position.y = get_global_mouse_position().y
	$Quest_Delete.rect_global_position.x = get_global_mouse_position().x - ($Quest_Delete.rect_size.x / 2)


func _on_questHideNo_pressed():
	$Quest_Delete.hide()


func _on_questHideYes_pressed():
	quest.remove(deleteId)
	list()
	$Quest_Delete.hide()


func _questAdd(data):
	quest.append(data)
	list()


func _on_Button_pressed():
	var header = $debug/headerData/LineEdit
	var text = $debug/textData/LineEdit
	var state = $debug/stateData/LineEdit
	var anim = $debug/IconData/LineEdit
	var dataAdd = [header.text, text.text, state.pressed, anim.text]
	_questAdd(dataAdd)
	header.text = ""
	text.text = ""
	anim.text = ""
	state.pressed = false

func _wayPointSelect(index):
	var point = quest[index]
	var enabled = point[3]
	var pos = point[4]
	var scene = point[5]
	
	enabled = !enabled
	
