@tool
class_name VersionBumperDock
extends VBoxContainer

var plugin: EditorPlugin

@onready var version_label: Label = $VersionLabel
@onready var major_button: Button = $Buttons/MajorButton
@onready var minor_button: Button = $Buttons/MinorButton
@onready var patch_button: Button = $Buttons/PatchButton

func _ready() -> void:
    # Allow buttons to visually depress on both left and right clicks
    major_button.button_mask = MOUSE_BUTTON_MASK_LEFT | MOUSE_BUTTON_MASK_RIGHT
    minor_button.button_mask = MOUSE_BUTTON_MASK_LEFT | MOUSE_BUTTON_MASK_RIGHT
    patch_button.button_mask = MOUSE_BUTTON_MASK_LEFT | MOUSE_BUTTON_MASK_RIGHT

    # Bind the specific version tier index (0, 1, 2) directly into the signal connection
    major_button.gui_input.connect(_on_button_gui_input.bind(0))
    minor_button.gui_input.connect(_on_button_gui_input.bind(1))
    patch_button.gui_input.connect(_on_button_gui_input.bind(2))

func update_version(major: String, minor: String, patch: String) -> void:
    version_label.text = "Current Version: " + major + "." + minor + "." + patch

func _on_button_gui_input(event: InputEvent, change_type: int) -> void:
    if event is InputEventMouseButton and event.pressed:
        if plugin:
            if event.button_index == MOUSE_BUTTON_LEFT:
                plugin.change_version(change_type, 1)
            elif event.button_index == MOUSE_BUTTON_RIGHT:
                plugin.change_version(change_type, -1)
