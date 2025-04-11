shader_type canvas_item;

uniform float time_speed : hint_range(0.0, 10.0) = 1.0;
uniform float wobble_amplitude : hint_range(0.0, 20.0) = 2.0;
uniform float wobble_frequency : hint_range(0.1, 10.0) = 2.0;

uniform float transparency: hint_range(0.0, 1.0, 0.05) = 0.5;

void vertex() {
    float t = TIME * time_speed;

    // Use VERTEX position as input for localized sine noise
    float offset_x = sin(VERTEX.y * wobble_frequency + t) * wobble_amplitude;
    float offset_y = cos(VERTEX.x * wobble_frequency + t) * wobble_amplitude;

    VERTEX.xy += vec2(offset_x, offset_y);
}

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    // Get distance from center (0.5, 0.5 in UV space)
    float dist = distance(UV, vec2(0.5));

    // Make alpha fade out near the edges
    float edge_fade = smoothstep(0.4, 0.5, dist);

    COLOR = tex_color;
    COLOR.a *= (1.0 - edge_fade) * transparency; // Multiply with fade + general opacity
}

