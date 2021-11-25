extends Node


enum ThemeTypes {HACKER, DARK, BLUE, LIGHT}
enum PanelLayout {AUTO, WIDESCREEN, TALLSCREEN}
enum ButtonSize {SMALL, BIG}
enum IconColorFrom {THEME, CUSTOM}

var root_directory := "."
var window_title := "" setget title_changed 
var config_cache := ConfigFile.new()
var directory_module : Reference

var documents := [] # Array of documents
var current_document : Document
var current_document_index := 0 setget document_changed

var recent_documents := []
var panel_layout = PanelLayout.AUTO

# Prefrences
var open_last_project := false
var smooth_padding := true

var dim_on_popup := true
var theme_type : int = ThemeTypes.DARK
var modulate_icon_color := Color.gray
var icon_color_from : int = IconColorFrom.THEME
var custom_icon_color := Color.gray
var button_size : int = ButtonSize.SMALL

var default_document_type := "odt"
var default_text_color := Color.lightgray
var defualt_highlight_color := Color.greenyellow
var line_separation


func title_changed(value : String) -> void:
	window_title = value
	OS.set_window_title(value)


func document_changed(value : int) -> void:
	current_document_index = value
	current_document = documents[value]
	current_document.change_project()



