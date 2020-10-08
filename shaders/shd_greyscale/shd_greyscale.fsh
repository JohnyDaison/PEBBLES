varying vec2 v_texcoord;

uniform float time;
uniform vec2 mouse_pos;
uniform vec2 resolution;

void main()
{ 
    float gray = dot(texture2D(gm_BaseTexture,v_texcoord).rgb, vec3(0.21, 0.71, 0.07));

    gl_FragColor = vec4(vec3(gray), texture2D(gm_BaseTexture,v_texcoord).a);
}
