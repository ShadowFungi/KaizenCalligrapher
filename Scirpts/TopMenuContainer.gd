extends Control


onready var tab_c := $PanelContainer/VBoxContainer/TabContainer


var app_name := 'KaizenCalligrapher'

var NewDoc = preload('res://Scenes/UI Components/TextEdit.tscn')





func _ready() -> void:
	update_window_title()
	var FileMenu := $PanelContainer/VBoxContainer/HBoxContainer/HBoxContainer/FileMenu
	var EditMenu := $PanelContainer/VBoxContainer/HBoxContainer/HBoxContainer/EditMenu
	var FormatMenu := $PanelContainer/VBoxContainer/HBoxContainer/HBoxContainer/FormatMenu
	var ViewMenu := $PanelContainer/VBoxContainer/HBoxContainer/HBoxContainer/ViewMenu
	var HelpMenu := $PanelContainer/VBoxContainer/HBoxContainer/HBoxContainer/HelpMenu
	FileMenu.get_popup().connect("id_pressed", self, "_on_FileMenu_item_pressed")
	EditMenu.get_popup().connect("id_pressed", self, "_on_edit_menu_item_pressed")
	FormatMenu.get_popup().connect("id_pressed", self, "_on_format_menu_item_pressed")
	ViewMenu.get_popup().connect("id_pressed", self, "_on_view_menu_item_pressed")
	HelpMenu.get_popup().connect("id_pressed", self, "_on_HelpMenu_item_pressed")

func update_window_title() -> void:
	if tab_c.get_tab_count() >= 1:
		OS.set_window_title(tab_c.get_tab_title(tab_c.current_tab) + " - " + app_name)
	elif tab_c.get_tab_count() <= 0:
		OS.set_window_title(app_name)


func _on_FileMenu_item_pressed(id : int) -> void:
	var OpenDialog := get_node('OpenFile')
	var SaveDialog := get_node('SaveFile')
	if id == 0:
		tab_c.add_child(NewDoc.instance(), true)
		tab_c.set_current_tab(tab_c.get_tab_count() -1)
		update_window_title()
	
	elif id == 1:
		OpenDialog.set_visible(true)
		update_window_title()
	
	elif id == 2:
		var fi := File.new()
		fi.open(fi.get_path_absolute(), 1)
		if fi.file_exists(tab_c.get_tab_title(tab_c.current_tab)) == true:
			fi.store_pascal_string(tab_c.get_tab_title(tab_c.current_tab))
		
		fi.close()
		


func _on_HelpMenu_item_pressed(id : int) -> void:
	if id == 0:
		print("This KaizenCalligrapher What did you think it was?")
	
	elif id == 1:
		print("You can't yet.")
	
	elif id == 2:
		print("KaizenCalligrapher is provided under the zlib license.")
	
	elif id == 3:
		print("Not yet implemented.")
	
	elif id == 4:
		print("KaizenCalligrapher is a text and document editing program.")


func _on_SaveFile_file_selected(path: String) -> void:
	var fi := File.new()
	fi.open(path, 1)
	if fi.file_exists(tab_c.get_tab_title(tab_c.current_tab)) == true:
		fi.store_pascal_string(tab_c.get_tab_title(tab_c.current_tab))
	
	fi.close()


func _on_OpenFile_file_selected(path: String) -> void:
	var fi := File.new()
	fi.open(path, 1)
	tab_c.add_child(NewDoc.instance(), true)
	tab_c.set_current_tab(tab_c.get_tab_count() - 1)
	tab_c.set_tab_title(tab_c.get_tab_count() - 1, fi.get_path())
	tab_c.get_current_tab_control().set_text(fi.get_as_text())
	fi.close()
	update_window_title()
