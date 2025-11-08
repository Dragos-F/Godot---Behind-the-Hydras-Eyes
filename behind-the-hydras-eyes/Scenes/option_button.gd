extends OptionButton
@export var row:int 
signal newOption(row,selectedNo)

func _on_item_selected(index: int) -> void:
	newOption.emit(row, index)
