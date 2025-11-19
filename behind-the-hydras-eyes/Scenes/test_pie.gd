extends Control
class_name BudgetData

@export var chart:LabellessPieChart
@export var colors:Array[Color]
@export var values:Array[float]
@export var buttonDifference:float = 0.02 # var used to increase/decrease buttons
@export var additionalsDifference:float = 0.05
@export var savingsText:Label
@export var LifeStyleText:Label
@export var LifeStyleTextCost:Label
@export var totalSalary:float
@export var totalRent:float
@export var totalBills:float
@export var additionalCosts:float
@export var startingSavings:float
@export var savingsContribution:float = 0
@export var savingsContributionText:Label
@export var lifestyleTypes:Array[String]
@export var lifestyleCosts:Array[float]
@export var lifestyleChoice:int = 1
var chartTotal:float



func _ready() -> void:
	startingSavings = PermanentGlobal.Savings
	savingsText.text = str(startingSavings)

	
func _process(_delta: float) -> void:
	savingsContribution = totalSalary-(totalBills+totalRent+lifestyleCosts[lifestyleChoice]+additionalCosts)
	
	
	savingsText.text = "£"+str(startingSavings+savingsContribution)
	if savingsContribution < 0:
		savingsText.modulate = colors[0]
		LifeStyleTextCost.modulate = colors[0]
		savingsContributionText.modulate = colors[0]
	elif savingsContribution >0:
		savingsText.modulate = colors[2]
		LifeStyleTextCost.modulate = colors[2]
		savingsContributionText.modulate = colors[2]
	else:
		savingsText.modulate = Color.WHITE
		LifeStyleTextCost.modulate = Color.WHITE
		savingsContributionText.modulate = Color.WHITE
	LifeStyleText.text = lifestyleTypes[lifestyleChoice]
	LifeStyleTextCost.text = "£"+str(lifestyleCosts[lifestyleChoice])
	savingsContributionText.text = "£" + str(savingsContribution)
	
	if savingsContribution >0:
		values[0] = totalRent/(totalSalary+startingSavings)
		values[1] = totalBills/(totalSalary+startingSavings)
		values[2] = lifestyleCosts[lifestyleChoice]/(totalSalary+startingSavings)
		values[3] = savingsContribution/(totalSalary+startingSavings)
	else:
		values[0] = totalRent/(totalSalary+startingSavings)
		values[1] = totalBills/(totalSalary+startingSavings)
		values[2] = (lifestyleCosts[lifestyleChoice]-savingsContribution)/(totalSalary+startingSavings)
		values[3] = 0
	#print (values[0], values[1], values[2], values[3])
	chart.all_entries = [
			LabellessPieChartEntry.new(values[0],colors[0]), #RENt
			LabellessPieChartEntry.new(values[1],colors[1]), #BILLS
			LabellessPieChartEntry.new(values[2],colors[2]), #LIFESTYLE
			LabellessPieChartEntry.new(values[3],colors[3]) #SAVINGS
	]
	

func _on_decrease_pressed() -> void:
	if lifestyleChoice>0:
		lifestyleChoice-=1
	else:
		lifestyleChoice = 2
	
func _on_increase_pressed() -> void:
	if lifestyleChoice<2:
		lifestyleChoice+=1
	else:
		lifestyleChoice = 0


func _on_check_button_toggled(toggled_on: bool) -> void:
	pass
	if toggled_on:
		additionalCosts +=15
	else:
		additionalCosts -=15


func _on_save_button_toggled(_toggled_on: bool) -> void:
	pass
	#if toggled_on == true:
		#var buttons = get_tree().get_nodes_in_group("Buttons")
		#for i in buttons:
			#if i is Button:
				#i.disabled = true
	#if toggled_on == false:
		#var buttons = get_tree().get_nodes_in_group("Buttons")
		#for i in buttons:
			#if i is Button:
				#i.disabled = false
	
