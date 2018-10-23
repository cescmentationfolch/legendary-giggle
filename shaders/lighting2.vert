#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;
uniform vec4 lightAmbient; // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse; // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 lightPosition; // similar a gl_LightSource[0].position
uniform vec4 matAmbient; // similar a gl_FrontMaterial.ambient
uniform vec4 matDiffuse; // similar a gl_FrontMaterial.diffuse
uniform vec4 matSpecular; // similar a gl_FrontMaterial.specular
uniform float matShininess; // similar a gl_FrontMaterial.shininess

vec4 Phong(vec3 N, vec3 V, vec3 L)
{
    vec3 R = normalize(2.0*dot(N, L)*N-L);
    float factorDiffuse = max(0.0, dot(N,L));
    float dotRV = max(0.0, dot(R,V));
    float factorSpecular = 0;
    if (factorDiffuse > 0.0) factorSpecular = pow(dotRV, matShininess);
    return matAmbient * lightAmbient + matDiffuse * lightDiffuse * factorDiffuse
        + matSpecular * lightSpecular * factorSpecular;
}

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    vec3 P = normalize((modelViewMatrix * vec4(vertex, 1.0)).xyz);
    vec3 V = -P;
    vec3 L = normalize(lightPosition.xyz - P);
    frontColor = Phong(N,V,L);
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
