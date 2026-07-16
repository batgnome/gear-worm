shader_type canvas_item;
uniform vec2 mouse_position;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    float dist = distance(UV, mouse_position);
    // Example: Highlight pixels near the mouse
    COLOR = texture(TEXTURE, UV) * smoothstep(0.1, 0.0, 3);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
