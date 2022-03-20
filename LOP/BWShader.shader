shader_type canvas_item;
render_mode unshaded;

void fragment(){
	
	float lumi = COLOR.r *0.1  + COLOR.b * 0.1 + COLOR.g * 0.1;
	COLOR.rgb = vec3(lumi);
}
	