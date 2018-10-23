#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec3 N;
out vec3 L;
out vec3 V;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrixInverse;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;
uniform vec4 lightPosition;
uniform bool world;

void main()
{
    if (world) {
        N = normalize(normal);
        V = normalize((modelViewMatrixInverse * vec4(0,0,0,1)).xyz - vertex.xyz);
        L = normalize((modelViewMatrixInverse * lightPosition).xyz - vertex.xyz);
    }
    else
    {
        N = normalize(normalMatrix * normal);
        V = -(modelViewMatrix * vec4(vertex, 1.0)).xyz;
        L = normalize(lightPosition.xyz + V);
        V = normalize(V);
    }
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
