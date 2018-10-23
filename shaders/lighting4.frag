#version 330 core

in vec3 N,L,V;
out vec4 fragColor;

uniform vec4 lightAmbient; // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse; // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
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
    fragColor = Phong(N,V,L);
}
