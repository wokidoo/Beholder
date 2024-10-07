@tool
extends Resource
class_name Field  ## Class representing a Field resource that can hold various data types.

## Enum that defines the different types a field can represent: Integer, Float, String, and Boolean.
enum FieldTypeEnum { 
	INTEGER,  ## Integer: represents whole numbers.
	FLOAT,    ## Float: represents decimal numbers.
	STRING,   ## String: represents text.
	BOOL      ## Bool: represents true (1) or false (0) values.
}

## The icon of the field. Represents the icon associated with the field
@export var icon: Texture2D = preload("res://scripts/field/default_field_icon.svg")
## The name of the field, initialized to " ". Represents the name of the field. (Example: AC, Strength, HP, etc.)
@export var name: String = "":
	set(t_name):
		name = t_name
		self.resource_name = name
## The type of the field, initialized to INTEGER. Determines how the value_string is interpreted.
@export var type: FieldTypeEnum = FieldTypeEnum.INTEGER: set = _SetType
## The value stored in the field as a string. This value is converted based on the type.
@export var value_string: String: get = _GetValueString, set = _SetValueString
## Internal value based on the `type`. The value adapts dynamically to the `FieldTypeEnum`.
var value: Variant: get = _GetValue

func _init():
	self.resource_local_to_scene = true
	
# ------ VALUE SETTERS & GETTERS ------
## Returns the actual value of the field, converting `value_string` based on `type`.
func _GetValue() -> Variant:
	match type:
		FieldTypeEnum.INTEGER:
			return value_string.to_int()  ## Converts the string to an integer.
		FieldTypeEnum.FLOAT:
			return value_string.to_float()  ## Converts the string to a float.
		FieldTypeEnum.STRING:
			return value_string  ## Returns the string as-is.
		FieldTypeEnum.BOOL:
			## Returns true if the string contains "true", false otherwise.
			return value_string.contains("true")
	
	## If no valid type is found, log an error and return null.
	print("Error: Field value returning 'NULL' due to unexpected field type!")
	return null

# ------ VALUE_STRING SETTERS & GETTERS ------

## Getter for `value_string`, simply returns the current string value.
func _GetValueString() -> String:
	return value_string

## Setter for `value_string`. Validates and sets the string based on `type`.
func _SetValueString(t_value: String):
	match type:
		FieldTypeEnum.INTEGER:
			## Check if the string is a valid integer.
			if t_value.is_valid_int():
				value_string = t_value
			else:
				value_string = ""
				print("Error: '{}' is not a valid integer value!".format([t_value], "{}"))
		FieldTypeEnum.FLOAT:
			## Check if the string is a valid float.
			if t_value.is_valid_float():
				value_string = t_value
			else:
				value_string = ""
				print("Error: '{}' is not a valid float value!".format([t_value], "{}"))
		FieldTypeEnum.STRING:
			## Directly set the string value.
			value_string = t_value
		FieldTypeEnum.BOOL:
			## Check if the string represents a boolean value.
			if t_value.contains("true") or t_value.contains("1"):
				value_string = "True"
			elif t_value.contains("false") or t_value.contains("0"):
				value_string = "False"
			else:
				value_string = "False"
				print("Error: '{}' is not a valid bool value!".format([t_value], "{}"))

	## Log the set value.
	print("value_string set to '{}'".format([value_string], "{}"))

# ------ TYPE SETTERS & GETTERS ------

## Sets the `type` of the field and initializes the `value_string` to a default based on the type.
func _SetType(t_type: FieldTypeEnum):
	match t_type:
		FieldTypeEnum.INTEGER:
			type = t_type
			value_string = "0"  ## Default integer value.
		FieldTypeEnum.FLOAT:
			type = t_type
			value_string = "0.0"  ## Default float value.
		FieldTypeEnum.STRING:
			type = t_type
			value_string = ""  ## Default empty string.
		FieldTypeEnum.BOOL:
			type = t_type
			value_string = "false"  ## Default boolean value (false).
