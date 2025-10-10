shader_type canvas_item;

// grab the screen texture
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float darkness : hint_range(0.0, 1.0) = 0.5;
uniform float desaturate : hint_range(0.0, 1.0) = 0.5;
uniform vec3 tint_color : source_color = vec3(0.2, 0.3, 0.8); // subtle blue
uniform float tint_strength : hint_range(0.0, 1.0) = 0.1;    // default: 5%
uniform float contrast : hint_range(0.5, 2.0) = 1.2;          // >1 = more contrast

void fragment() {
    vec4 col = texture(SCREEN_TEXTURE, SCREEN_UV);

    // grayscale blend
    float gray = dot(col.rgb, vec3(0.299, 0.587, 0.114));
    col.rgb = mix(vec3(gray), col.rgb, 1.0 - desaturate);

    // darken
    col.rgb *= (1.2 - darkness);

    // subtle tint
    col.rgb = mix(col.rgb, tint_color, tint_strength);

    // contrast adjustment
    col.rgb = (col.rgb - 0.5) * contrast + 0.5;

    COLOR = col;
}
