extends Control

func _ready() -> void:
	%GameMenu.visible = true
	%SettingsMenu.visible = false

	$CanvasLayer/SettingsMenu/VBoxContainer/MasterSetting/HSlider.value = AudioManager.volumes["master"]
	$CanvasLayer/SettingsMenu/VBoxContainer/SFXSetting/HSlider.value = AudioManager.volumes["sfx"]
	$CanvasLayer/SettingsMenu/VBoxContainer/MusicSetting/HSlider.value = AudioManager.volumes["music"]

func _on_play_button_pressed() -> void:
	%SFX.play()
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
	

func _on_quit_button_pressed() -> void:
	%SFX.play()
	get_tree().quit()
	

func _on_settings_pressed() -> void:
	%GameMenu.visible = false
	%SettingsMenu.visible = true
	%SFX.play()

func _on_save_button_pressed() -> void:
	%GameMenu.visible = true
	%SettingsMenu.visible = false
	%SFX.play()

func _on_english_pressed() -> void:
	TranslationServer.set_locale("en")
	%SFX.play()

func _on_french_pressed() -> void:
	TranslationServer.set_locale("fr")
	%SFX.play()
	


func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		%SFX.play()
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		%SFX.play()

func _on_h_slider_master_value_changed(value: float) -> void:
	AudioManager.change_volume(AudioManager.AUDIO_BUSES.Master, value)

func _on_h_slider_sfx_value_changed(value: float) -> void:
	AudioManager.change_volume(AudioManager.AUDIO_BUSES.SFX, value)

func _on_h_slider_music_value_changed(value: float) -> void:
	AudioManager.change_volume(AudioManager.AUDIO_BUSES.Music, value)


func _on_spanish_pressed() -> void:
	TranslationServer.set_locale("es")
	%SFX.play()
