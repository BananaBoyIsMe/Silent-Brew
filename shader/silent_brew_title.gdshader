shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114)); // Luminance formula
    gray = clamp(gray * 5.0, 0.0, 1.0); // Increase brightness (adjust 1.5 as needed)
    COLOR = vec4(vec3(gray), color.a);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
