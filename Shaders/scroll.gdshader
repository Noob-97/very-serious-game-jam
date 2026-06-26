shader_type canvas_item;

uniform vec2 speed = vec2(0.1, 0.0);

void fragment() {
    vec2 shifted_uv = UV + (TIME * speed);
    COLOR = texture(TEXTURE, shifted_uv);
}