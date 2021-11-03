extends Node2D

export var questListPath = NodePath()
onready var questList = get_node(questListPath)

var quest = [["Woah","dassa quest", false, "default", false, Vector2(0,0), "res://Node2D"],
["I KNOW RIGHT","its so cool", false, "default", false, Vector2(0,0), "res://Node2D"],
["not really","(i am a pessimist)", true, "default", false, Vector2(0,0), "res://Node2D"],
["shut up","i didnt ask", true, "default", false, Vector2(0,0), "res://Node2D"]
]


var deleteId = 0

func _ready():
	list()

#####
#use get_tree().edited_scene_root.filename to check the current scene this is being ran in


func list():
	var deleteAtor = questList.get_child_count()
	while deleteAtor > 0:
		questList.get_child(deleteAtor - 1).queue_free()
		deleteAtor -= 1
	
	var iterateor = 0
	while iterateor < quest.size():
		var curr = quest[iterateor]
		var questInstance = preload("res://questAsset.tscn").instance()
		var hungryBox = questInstance.get_node("HBoxContainer")
		var textNode = hungryBox.get_node("Text")
		textNode.get_node("header").text = curr[0]
		textNode.get_node("text").text = curr[1]
		var stateRead = ""
		match curr[2]:
			false:
				stateRead = "UNCOMPLETED"
			true:
				stateRead = "COMPLETED"
		textNode.get_node("state").text = stateRead
		var img = hungryBox.get_node("img")
		var icon = img.get_node("icon")
		icon.animation = curr[3]
		var size = (icon.frames.get_frame(icon.animation, icon.frame).get_width() * icon.scale.x)
		var base = textNode.rect_size.y / size
		icon.scale = icon.scale * base
		
		var Secondbase = icon.scale.x * size
		var waypoint = img.get_node("waypointEnable")
		waypoint.scale = icon.scale / 4
		waypoint.position.x = Secondbase - (waypoint.scale.x * (size / 2))
		waypoint.modulate.r = int(curr[3])
		var deleteButton = questInstance.get_node("Button")
		var reCOunt = textNode.rect_size.x
		print(reCOunt)
		deleteButton.rect_size.x = reCOunt + (size / 2)
		deleteButton.rect_size.y = textNode.rect_size.y
		deleteButton.rect_position = Vector2(0,0)
		deleteButton.connect("pressed", self, "_questSelect", [iterateor])
		var waypointToggle = waypoint.get_node("wayPoint")
		waypointToggle.connect("pressed", self, "_wayPointSelect", [iterateor])
		
		
		
		questList.add_child(questInstance)
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
	
