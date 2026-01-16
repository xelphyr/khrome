extends StaticBody3D


func _on_fan_area_body_entered(body: Node3D) -> void:
    if body.is_in_group(&"Player"):
        body.call("on_fan_entered", $FanArea.gravity)


func _on_fan_area_body_exited(body: Node3D) -> void:
    if body.is_in_group(&"Player"):
        body.call("on_fan_exited")
