shader_type canvas_item;

uniform float speed : hint_range(0.0, 2.0) = 0.1;
uniform float distortion : hint_range(0.0, 2.0) = 1.0;
uniform float intensity : hint_range(0.0, 2.0) = 0.5;
uniform float transparency : hint_range(0.0, 1.0) = 0.7;

// Aurora gradient stops
uniform vec4 color1 : source_color = vec4(1.0, 0.8, 0.7, 1.0); // red-orange
uniform vec4 color2 : source_color = vec4(0.6, 0.8, 1.0, 1.0); // cyan-blue
uniform vec4 color3 : source_color = vec4(0.5, 0.7, 0.9, 0.6); // purple
uniform vec4 color4 : source_color = vec4(0.5, 1.0, 0.5, 1.0); // green
uniform vec4 color5 : source_color = vec4(0.9, 0.9, 0.3, 1.0); // yellow

// Seed (set from script for randomness)
uniform vec2 seed_offset = vec2(0.0, 0.0);

// Simple hash
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

// 2D noise
float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(a, b, u.x) +
           (c - a) * u.y * (1.0 - u.x) +
           (d - b) * u.x * u.y;
}

// Gradient helper
vec3 gradient(float x) {
    if (x < 0.25) {
        return mix(color1.rgb, color2.rgb, smoothstep(0.0, 0.25, x));
    } else if (x < 0.5) {
        return mix(color2.rgb, color3.rgb, smoothstep(0.25, 0.5, x));
    } else if (x < 0.75) {
        return mix(color3.rgb, color4.rgb, smoothstep(0.5, 0.75, x));
    } else {
        return mix(color4.rgb, color5.rgb, smoothstep(0.75, 1.0, x));
    }
}

void fragment() {
    vec2 uv = UV + seed_offset; // add randomness
    float t = TIME * speed;

    // Warp UVs for curvy motion
    uv.x += noise(vec2(uv.y * 2.0, t) + seed_offset) * distortion;

    // Multi-layer noise
    float n = noise(uv * 5.0 + vec2(t, 0.0));
    n = (n + noise(uv * 7.0 - vec2(0.0, t * 0.6))) * 0.5;

    // Gradient color
    vec3 aurora = gradient(fract(n));

    // Vertical fade
    float vfade = smoothstep(0.1, 0.4, UV.y) * (1.0 - smoothstep(0.6, 0.95, UV.y));

    // Flicker shimmer
    float flicker = 0.8 + 0.2 * sin(TIME * 2.0 + UV.x * 10.0);

    COLOR = vec4(aurora * vfade * intensity, vfade * transparency * flicker);
}
