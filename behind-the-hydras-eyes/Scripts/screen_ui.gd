extends Control
class_name Computer
@export var MainEmailBody:RichTextLabel
@export var replyTarget:Control #needed since I've decided to make the typing system dependent on a control node
@export var Sender:RichTextLabel
@export var ToBox:RichTextLabel
@onready var send: Button = $MainEmail/Send
@onready var reply: Button = $MainEmail/Reply
@onready var selectedTexts:Array[String]
@onready var typing_brain: Node = %TypingBrain
@onready var hint_text: RichTextLabel = $MainEmail/Hint
@onready var summaries_container: VBoxContainer = $EmailList/SummariesContainer
@onready var inbox_buttons:Array[Button]
@onready var selectedPreview:Node
@export var emailsProgressionQuota:int
@export var emailsDone:int
@export var EmailList:Array[Panel]
@export var Budget:Panel
@export var BrowserThing:Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	send.visible = false
	send.disabled = true
	
	reply.visible = false
	reply.disabled = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func open_email(text:Array[String],boss:bool)->void:
	selectedTexts = text.duplicate(true)
	Sender.text = text[0]
	ToBox.text = text[1]
	MainEmailBody.text ="[b]"+text[2]+"[/b]\n\n" + text[3]
	MainEmailBody.visible_ratio = 0.9
	MainEmailBody.visible_ratio = 1
	if (!boss):
		reply.visible = true
		reply.disabled = false
	else:
		reply.visible = false
		reply.disabled = true
		
	

func _on_reply_pressed() -> void:
	reply.visible = false #set the reply button false
	reply.disabled = true
	
	Sender.text = selectedTexts[2]
	ToBox.text = selectedTexts[0]
	MainEmailBody.visible_characters = 0
	hint_text.visible = true
	MainEmailBody.text = selectedTexts[4]
	typing_brain.start_new_type(replyTarget)
	#code to get and disable all buttons
	inbox_buttons.assign(summaries_container.find_children("Button"))
	if (inbox_buttons!=null):
		for i in inbox_buttons:
			i.disabled = true
			
	

func _on_typing_brain_typing_finished() -> void: #custom signal from the typing brain
	hint_text.visible = false
	send.visible = true
	send.disabled = false
	

func _on_send_pressed() -> void:
	selectedPreview.queue_free()
	MainEmailBody.text= ""
	Sender.text=""
	ToBox.text= ""
	selectedTexts.clear()
	send.visible = false
	send.disabled = true
	if (inbox_buttons!=null):
		for i in inbox_buttons:
			i.disabled = false
	inbox_buttons.clear()
	emailsDone+=1
	MainEmailBody.visible_ratio = 0.9
	MainEmailBody.visible_ratio = 1
	


func _on_emails_pressed() -> void:
	if Budget != null:
		Budget.visible = false
	if BrowserThing != null:
		BrowserThing.visible = false
	for i in EmailList:
		i.visible = true

func _on_budget_pressed() -> void:
	Budget.visible = true
	if BrowserThing!=null:
		BrowserThing.visible = false
	for i in EmailList:
		i.visible = false


func _on_job_thing_pressed() -> void:
	BrowserThing.visible = true
	Budget.visible = false
	for i in EmailList:
		i.visible = false


func _on_save_button_pressed() -> void:
	pass # Replace with function body.


func _on_internet_pressed() -> void:
	if Budget.visible:
		Budget.visible = false
	for i in EmailList:
		i.visible = false
	BrowserThing.visible = true
