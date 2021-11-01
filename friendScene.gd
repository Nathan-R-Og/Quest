extends Node2D


var friend = [["Name","prettyCool", "default", 25,
"Takes long walks on the beach.\nIsn't very popular.",
"Likes: Tomatoes, Raddishes, and salty things.\nDislikes: Sweet things, water, fluid of any kind."]
]

var deleteId = 0

func _ready():
	list()



#####
#use get_tree().edited_scene_root.filename to check the current scene this is being ran in


func list():
	var deleteAtor = $friends.get_child_count()
	while deleteAtor > 0:
		$friends.get_child(deleteAtor - 1).queue_free()
		deleteAtor -= 1
	
	var iterateor = 0
	while iterateor < friend.size():
		var curr = friend[iterateor]
		var friendInstance = preload("res://friend.tscn").instance()
		$friends.add_child(friendInstance)
		var textNode = friendInstance.get_node("TopBar/Text")
		var header = textNode.get_node("header")
		header.text = curr[0]
		var textt = textNode.get_node("text")
		textt.text = curr[1]
		var icon = friendInstance.get_node("TopBar/img/icon")
		icon.animation = curr[2]
		var base = icon.frames.get_frame(icon.animation, icon.frame).get_height() / 4
		var Secondbase = icon.frames.get_frame(icon.animation, icon.frame).get_height() / 1.5
		header.rect_size.y = base
		textt.rect_size.y = Secondbase
		var widddth = icon.frames.get_frame(icon.animation, icon.frame).get_width() + header.rect_size.x
		friendInstance.get_node("TopBar").set("custom_constants/separation", icon.frames.get_frame(icon.animation, icon.frame).get_width())
		var heiiiight = base * 4
		var buTOUN = friendInstance.get_node("Info")
		buTOUN.rect_position = Vector2(0,0)
		buTOUN.rect_size = Vector2(widddth, heiiiight)
		friendInstance.get_node("Info").connect("pressed", self, "_friendSelect", [iterateor])
		
		
		var bar = "bar"
		
		
		iterateor += 1


func _friendSelect(id):
	deleteId = id
	var yeah = friend[id]
	$InfoPopup.popup()
	
	var infoIco = $InfoPopup/Control/AnimatedSprite
	var infoHeader = $InfoPopup/Control/Header
	var infoText = $InfoPopup/Control/Text
	var infoBio = $InfoPopup/Control/Bio
	var infoStats = $InfoPopup/Control/Stats
	###get frames of npc, for now just show icon
	infoIco.animation = yeah[2]
	infoHeader.text = yeah[0]
	infoText.text = yeah[1]
	infoBio.text = yeah[4]
	infoStats.text = yeah[5]
	
	
	
	
	
	
	
	$InfoPopup.rect_position.y = get_global_mouse_position().y
	$InfoPopup.rect_global_position.x = get_global_mouse_position().x


func _friendAdd(data):
	friend.append(data)
	list()


func _on_Button_pressed():
	var header = $debug/headerData/LineEdit
	var text = $debug/textData/LineEdit
	var state = $debug/stateData/LineEdit
	var anim = $debug/IconData/LineEdit
	var dataAdd = [header.text, text.text, state.pressed, anim.text]
	_friendAdd(dataAdd)
	header.text = ""
	text.text = ""
	anim.text = ""
	state.pressed = false

