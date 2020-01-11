extends LineEdit

export var regexLimitString = '[0-9]'

func _on_NumericLineEdit_text_changed(new_text):
	if regexLimitString.length() != 0:
		var cursorPos = get_cursor_position()
		set_text(returnSpecificSymbolsOnly(new_text, regexLimitString))
		set_cursor_position(cursorPos)

func returnSpecificSymbolsOnly(enteredText,regex):
	var word = ''
	for letter in enteredText:
		var resultingText = RegEx.new()
		resultingText.compile(regex)
		
		if resultingText.search(letter, 0, -1): 
			word += letter
	return word