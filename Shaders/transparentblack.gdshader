shader_type canvas_item;

// Umbral para decidir qué tan "negro" debe ser para volverse transparente
uniform float threshold : hint_range(0.0, 1.0) = 0.1;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    float brightness = (tex_color.r + tex_color.g + tex_color.b) / 3.0;
    
    if (brightness < threshold) {
        tex_color.a = 0.0;
    }
    COLOR = tex_color;
}