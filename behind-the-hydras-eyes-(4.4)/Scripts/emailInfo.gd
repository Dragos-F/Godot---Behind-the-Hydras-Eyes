extends VBoxContainer
class_name EmailBrain
@export var textLabel:RichTextLabel
@export var Sender_Name:String
@export var ToAddress:String
@export var Subject:String
@export var PreviewText:String
@export_multiline var MainBody:String
@export_multiline var ReplyBody1:String
@export_multiline var ReplyBody2:String
@onready var screen_ui: Control
@export var alltexts:Array[String]
@onready var own_label: RichTextLabel = $Button/RichTextLabel
@export var boss:bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	own_label.text ="[b]"+Sender_Name+"[/b]\n" +Subject+"\n"+"[i]"+PreviewText+"[/i]"
	screen_ui = get_tree().current_scene.get_node("ScreenUI")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#made this so that when pressed, it calls a function that permanently exists at the scene level
#primary issue is that the email summary object gets despawned/i might have multiple
#so using a center point to communicate to all the mapping.
func _on_button_pressed() -> void:
	alltexts.append(Sender_Name)
	alltexts.append(ToAddress)
	alltexts.append(Subject)
	alltexts.append(MainBody)
	alltexts.append(ReplyBody1)
	screen_ui.open_email(alltexts,boss)
	screen_ui.selectedPreview = self
