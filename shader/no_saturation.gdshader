shader_type canvas_item;

uniform float brightness : hint_range(0.0, 2.0) = 1.0;
uniform float saturation : hint_range(0.0, 1.0) = 0.0;

void fragment() {
    // Sample the texture
    vec4 tex_color = texture(TEXTURE, UV);

    // Grayscale conversion
    float gray = dot(tex_color.rgb, vec3(0.299, 0.587, 0.114));
    vec3 gray_col = vec3(gray);

    // Mix between grayscale and original color based on saturation
    vec3 final_col = mix(gray_col, tex_color.rgb, saturation);

    // Apply brightness
    COLOR = vec4(final_col * brightness, tex_color.a);
}
