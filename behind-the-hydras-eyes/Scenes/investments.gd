extends BoxContainer

@export var totals: Array[Label]
@export var prices: Array[int]
@export var totalCosts:int
@export var red:Color
@export var green:Color
@export var symbol:Label
@export var remainingBudget:Label




	


func _on_option_button_new_option(row: Variant, selectedNo: Variant) -> void:
	totals[row].text = "£"+str(prices[row]*selectedNo)
	recalculate()
	
func recalculate():
	totalCosts = 0
	for i in totals:
		totalCosts += int(i.text)
	remainingBudget.text = str(1000000-totalCosts)
	if totalCosts < 1000000:
		symbol.modulate = green
		remainingBudget.modulate = green
	elif totalCosts > 1000000:
		symbol.modulate = red
		remainingBudget.modulate = red
	elif totalCosts == 1000000:
		symbol.modulate = Color.WHITE
		remainingBudget.modulate = Color.WHITE
		
	
	
