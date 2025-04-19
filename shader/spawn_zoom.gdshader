shader_type canvas_item;

uniform float saturation : hint_range(0.0, 1.0) = 0.0; // Adjustable saturation

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    float gray = dot(tex_color.rgb, vec3(0.299, 0.587, 0.114)); // Standard grayscale formula
    vec3 desaturated = mix(vec3(gray), tex_color.rgb, saturation);
    COLOR = vec4(desaturated, tex_color.a);
}