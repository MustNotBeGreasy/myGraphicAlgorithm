#version 430 core
layout(location = 0) in vec3 _Position;
layout(location = 1) in vec3 _Normal;
layout(location = 2) in vec2 _TexCoord;

layout(std140, binding = 0) uniform u_Matrices4ProjectionWorld
{
	mat4 u_ProjectionMatrix;
	mat4 u_ViewMatrix;
};

uniform mat4 u_ModelMatrix;

out vec2 v2f_TexCoords;
out vec3 v2f_Normal;
out vec3 v2f_FragPos;

void main()
{
	vec4 FragPos =  u_ModelMatrix * vec4(_Position, 1.0f);
	gl_Position = u_ProjectionMatrix * u_ViewMatrix * FragPos;
	v2f_TexCoords = _TexCoord;
	v2f_Normal = normalize(mat3(transpose(inverse(u_ModelMatrix))) * _Normal);	//这个可以在外面算好了传进来
	v2f_FragPos = vec3(FragPos);
}