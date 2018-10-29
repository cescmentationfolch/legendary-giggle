#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float time;

void main()
{
    float sigma = time*texCoord.s;
    mat3 Rot = mat3(vec3(cos(sigma), 0, sin(sigma)),
                    vec3(0, 1, 0), vec3(-sin(sigma), 0, cos(sigma)));
    frontColor = vec4(0,0,1,1.0);
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(Rot*vertex, 1.0);
}
