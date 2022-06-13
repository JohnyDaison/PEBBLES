varying vec2 v_texcoord;

void main()
{ 
    float gray = dot(texture2D(gm_BaseTexture,v_texcoord).rgb, vec3(0.299, 0.587, 0.114));

    gl_FragColor = vec4(vec3(gray), texture2D(gm_BaseTexture,v_texcoord).a);
}
