extends VBoxContainer
class_name EmailBrain
@export var textLabel:RichTextLabel
@export var Sender_Name:String
@export var ToAddress:String
@export var Subject:String
@export var PreviewText:String
@export var replyChoice:bool
@export var choiceDialog1:String
@export var choiceDialog2:String
@export_multiline var MainBody:String
@export_multiline var ReplyBody1:String
@export_multiline var ReplyBody2:String
@onready var screen_ui: Computer
@export var alltexts:Array[String]
@onready var own_label: RichTextLabel = $Button/RichTextLabel
@export var boss:bool = false
@export var ownDel:Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	own_label.text ="[b]"+Sender_Name+"[/b]\n" +Subject+"\n"+"[i]"+PreviewText+"[/i]"
	screen_ui = get_tree().current_scene.get_node("ScreenUI")
	ownDel.disabled = true
	
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
	alltexts.append(ReplyBody2)
	screen_ui.open_email(alltexts,boss,replyChoice)
	screen_ui.selectedPreview = self
	if replyChoice:
		reset_choices()
		Dialogic.VAR.Option1 = choiceDialog1
		Dialogic.VAR.Option2 = choiceDialog2
	ownDel.disabled = false

func reset_choices()->void:
	Dialogic.VAR.Option1 = ""
	Dialogic.VAR.Option2 = ""


func _on_delete_pressed() -> void:
	screen_ui.emailsDone +=1
	screen_ui.MainEmailBody.text= ""
	screen_ui.Sender.text=""
	screen_ui.ToBox.text= ""
	screen_ui.selectedTexts.clear()
	screen_ui.reply.visible = false
	screen_ui.reply.disabled = true
	screen_ui.hint_text.visible = false
	PermanentGlobal.deleted +=1
	self.queue_free()
