extends Node2D

export var friendListPath = NodePath()
onready var friendlist = get_node(friendListPath)

var friend = [["Name","prettyCool", "default", 25, 200,
"Takes long walks on the beach.\nIsn't very popular.",
"Likes: Tomatoes, Raddishes, and salty things.\nDislikes: Sweet things, water, fluid of any kind."],
["Name","prettyCool", "default", 25, 200,
"Takes long walks on the beach.\nIsn't very popular.",
"Likes: Tomatoes, Raddishes, and salty things.\nDislikes: Sweet things, water, fluid of any kind."],
["Name","prettyCool", "default", 25, 200,
"Takes long walks on the beach.\nIsn't very popular.",
"Likes: Tomatoes, Raddishes, and salty things.\nDislikes: Sweet things, water, fluid of any kind."],
["Name","prettyCool", "default", 25, 200,
"Takes long walks on the beach.\nIsn't very popular.",
"Likes: Tomatoes, Raddishes, and salty things.\nDislikes: Sweet things, water, fluid of any kind."],
["Name","prettyCool", "default", 25, 200,
"Takes long walks on the beach.\nIsn't very popular.",
"Likes: Tomatoes, Raddishes, and salty things.\nDislikes: Sweet things, water, fluid of any kind."],
["Name","prettyCool", "default", 25, 200,
"Takes long walks on the beach.\nIsn't very popular.",
"Likes: Tomatoes, Raddishes, and salty things.\nDislikes: Sweet things, water, fluid of any kind."],
["Name","prettyCool", "default", 25, 200,
"Takes long walks on the beach.\nIsn't very popular.",
"Likes: Tomatoes, Raddishes, and salty things.\nDislikes: Sweet things, water, fluid of any kind."],
["Name","prettyCool", "default", 25, 200,
"Takes long walks on the beach.\nIsn't very popular.",
"Likes: Tomatoes, Raddishes, and salty things.\nDislikes: Sweet things, water, fluid of any kind."],
["Name","prettyCool", "default", 25, 200,
"Takes long walks on the beach.\nIsn't very popular.",
"Likes: Tomatoes, Raddishes, and salty things.\nDislikes: Sweet things, water, fluid of any kind."],
["Name","prettyCool", "default", 25, 200,
"Takes long walks on the beach.\nIsn't very popular.",
"Likes: Tomatoes, Raddishes, and salty things.\nDislikes: Sweet things, water, fluid of any kind."],
["Name","prettyCool", "default", 25, 200,
"Takes long walks on the beach.\nIsn't very popular.",
"Likes: Tomatoes, Raddishes, and salty things.\nDislikes: Sweet things, water, fluid of any kind."]
]

var deleteId = 0

func _ready():
	list()

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		friend[0][3] = clamp(friend[0][3] + 1, 0, friend[0][4])
		list()
	if Input.is_action_pressed("ui_select"):
		friend[0][3] = clamp(friend[0][3] - 1, 0, friend[0][4])
		list()

#####
#use get_tree().edited_scene_root.filename to check the current scene this is being ran in


func list():
	var deleteAtor = friendlist.get_child_count() - 1
	while deleteAtor >= 0:
		friendlist.get_child(deleteAtor).queue_free()
		deleteAtor -= 1
	
	var iterateor = 0
	while iterateor < friend.size():
		var curr = friend[iterateor]
		var friendInstance = preload("res://friend.tscn").instance()
		friendlist.add_child(friendInstance)
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
		
		
		var bar = friendInstance.get_node("Bar")
		var barScale = bar.get_node("Bar")
		var outOf = float(curr[3]) / float(curr[4])
		var awayEdge = 20
		var stretch = widddth - (awayEdge * 6)
		barScale.scale.x = outOf * stretch
		barScale.position.x = -92.5 + barScale.scale.x
		bar.position.x = widddth / 2
		barScale.position.y = -10
		var ticker1 = bar.get_node("ticker")
		var ticker2 = bar.get_node("ticker2")
		var ticker3 = bar.get_node("ticker3")
		var ticker4 = bar.get_node("ticker4")
		var ticker5 = bar.get_node("ticker5")
		ticker1.position.x = (-stretch) - 8.5
		ticker2.position.x = ((stretch * 0.5) - stretch) - 8.5
		ticker3.position.x = ((stretch) - stretch) - 8.5
		ticker4.position.x = ((stretch * 1.5) - stretch) - 8.5
		ticker5.position.x = ((stretch * 2) - stretch) - 8.5
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
	infoBio.text = yeah[5]
	infoStats.text = yeah[6]
	
	
	
	
	
	
	
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

