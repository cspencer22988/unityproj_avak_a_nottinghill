Shader "Lockwood/WaterReflection" {
	Properties {
		_BumpMap ("Normals ", 2D) = "bump" {}
		_CubeMap ("Environment ", Cube) = "white" {}
		_DistortParams ("Distortions (Bump waves, FresnelScale, Fresnel power, Fresnel bias)", Vector) = (1,0.75,2,1.15)
		_BumpTiling ("Bump Tiling", Vector) = (1,1,-2,3)
		_BumpDirection ("Bump Direction & Speed", Vector) = (1,1,-1,1)
		_BaseColor ("Base color", Vector) = (0.54,0.95,0.99,0.5)
		_ReflectionColor ("Reflection color", Vector) = (0.54,0.95,0.99,0.5)
	}
	SubShader {
		Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
		Pass {
			Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
			ColorMask RGB -1
			Cull Off
			GpuProgramID 10716
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpTiling;
					uniform highp vec4 _BumpDirection;
					varying mediump vec3 xlv_TEXCOORD0;
					varying mediump vec4 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex).xyz;
					  tmpvar_2 = ((tmpvar_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
					  tmpvar_1 = (tmpvar_3 - _WorldSpaceCameraPos);
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _BumpMap;
					uniform lowp samplerCube _CubeMap;
					uniform highp vec4 _BaseColor;
					uniform highp vec4 _ReflectionColor;
					uniform highp vec4 _DistortParams;
					varying mediump vec3 xlv_TEXCOORD0;
					varying mediump vec4 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec4 baseColor_1;
					  mediump float facing_2;
					  mediump vec3 reflectVector_3;
					  mediump vec3 worldNormal_4;
					  mediump vec3 bump_5;
					  lowp vec3 tmpvar_6;
					  tmpvar_6 = (((texture2D (_BumpMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0) + ((texture2D (_BumpMap, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0));
					  bump_5 = tmpvar_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (((bump_5.xxy * _DistortParams.x) * vec3(1.0, 0.0, 1.0)) + vec3(0.0, 1.0, 0.0));
					  worldNormal_4 = tmpvar_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = normalize(worldNormal_4);
					  worldNormal_4 = tmpvar_8;
					  mediump vec3 tmpvar_9;
					  tmpvar_9 = normalize(xlv_TEXCOORD0);
					  mediump vec3 tmpvar_10;
					  tmpvar_10 = (tmpvar_9 - (2.0 * (
					    dot (tmpvar_8, tmpvar_9)
					   * tmpvar_8)));
					  reflectVector_3.yz = tmpvar_10.yz;
					  reflectVector_3.x = -(tmpvar_10.x);
					  mediump vec3 x_11;
					  x_11 = -(tmpvar_9);
					  highp float tmpvar_12;
					  tmpvar_12 = (1.0 - dot (x_11, (tmpvar_8 * _DistortParams.y)));
					  facing_2 = tmpvar_12;
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp ((_DistortParams.w + (
					    ((1.0 - _DistortParams.w) * pow (facing_2, _DistortParams.z))
					   * 2.0)), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  baseColor_1 = _BaseColor;
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = textureCube (_CubeMap, reflectVector_3);
					  baseColor_1.xyz = (baseColor_1.xyz * tmpvar_15.xyz);
					  highp vec4 tmpvar_16;
					  tmpvar_16 = mix (baseColor_1, _ReflectionColor, vec4(tmpvar_13));
					  baseColor_1.xyz = tmpvar_16.xyz;
					  baseColor_1.w = 1.0;
					  gl_FragData[0] = baseColor_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpTiling;
					uniform highp vec4 _BumpDirection;
					varying mediump vec3 xlv_TEXCOORD0;
					varying mediump vec4 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex).xyz;
					  tmpvar_2 = ((tmpvar_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
					  tmpvar_1 = (tmpvar_3 - _WorldSpaceCameraPos);
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _BumpMap;
					uniform lowp samplerCube _CubeMap;
					uniform highp vec4 _BaseColor;
					uniform highp vec4 _ReflectionColor;
					uniform highp vec4 _DistortParams;
					varying mediump vec3 xlv_TEXCOORD0;
					varying mediump vec4 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec4 baseColor_1;
					  mediump float facing_2;
					  mediump vec3 reflectVector_3;
					  mediump vec3 worldNormal_4;
					  mediump vec3 bump_5;
					  lowp vec3 tmpvar_6;
					  tmpvar_6 = (((texture2D (_BumpMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0) + ((texture2D (_BumpMap, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0));
					  bump_5 = tmpvar_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (((bump_5.xxy * _DistortParams.x) * vec3(1.0, 0.0, 1.0)) + vec3(0.0, 1.0, 0.0));
					  worldNormal_4 = tmpvar_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = normalize(worldNormal_4);
					  worldNormal_4 = tmpvar_8;
					  mediump vec3 tmpvar_9;
					  tmpvar_9 = normalize(xlv_TEXCOORD0);
					  mediump vec3 tmpvar_10;
					  tmpvar_10 = (tmpvar_9 - (2.0 * (
					    dot (tmpvar_8, tmpvar_9)
					   * tmpvar_8)));
					  reflectVector_3.yz = tmpvar_10.yz;
					  reflectVector_3.x = -(tmpvar_10.x);
					  mediump vec3 x_11;
					  x_11 = -(tmpvar_9);
					  highp float tmpvar_12;
					  tmpvar_12 = (1.0 - dot (x_11, (tmpvar_8 * _DistortParams.y)));
					  facing_2 = tmpvar_12;
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp ((_DistortParams.w + (
					    ((1.0 - _DistortParams.w) * pow (facing_2, _DistortParams.z))
					   * 2.0)), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  baseColor_1 = _BaseColor;
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = textureCube (_CubeMap, reflectVector_3);
					  baseColor_1.xyz = (baseColor_1.xyz * tmpvar_15.xyz);
					  highp vec4 tmpvar_16;
					  tmpvar_16 = mix (baseColor_1, _ReflectionColor, vec4(tmpvar_13));
					  baseColor_1.xyz = tmpvar_16.xyz;
					  baseColor_1.w = 1.0;
					  gl_FragData[0] = baseColor_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpTiling;
					uniform highp vec4 _BumpDirection;
					varying mediump vec3 xlv_TEXCOORD0;
					varying mediump vec4 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = (unity_ObjectToWorld * _glesVertex).xyz;
					  tmpvar_2 = ((tmpvar_3.xzxz + (_Time.xxxx * _BumpDirection)) * _BumpTiling);
					  tmpvar_1 = (tmpvar_3 - _WorldSpaceCameraPos);
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _BumpMap;
					uniform lowp samplerCube _CubeMap;
					uniform highp vec4 _BaseColor;
					uniform highp vec4 _ReflectionColor;
					uniform highp vec4 _DistortParams;
					varying mediump vec3 xlv_TEXCOORD0;
					varying mediump vec4 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec4 baseColor_1;
					  mediump float facing_2;
					  mediump vec3 reflectVector_3;
					  mediump vec3 worldNormal_4;
					  mediump vec3 bump_5;
					  lowp vec3 tmpvar_6;
					  tmpvar_6 = (((texture2D (_BumpMap, xlv_TEXCOORD1.xy).xyz * 2.0) - 1.0) + ((texture2D (_BumpMap, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0));
					  bump_5 = tmpvar_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (((bump_5.xxy * _DistortParams.x) * vec3(1.0, 0.0, 1.0)) + vec3(0.0, 1.0, 0.0));
					  worldNormal_4 = tmpvar_7;
					  mediump vec3 tmpvar_8;
					  tmpvar_8 = normalize(worldNormal_4);
					  worldNormal_4 = tmpvar_8;
					  mediump vec3 tmpvar_9;
					  tmpvar_9 = normalize(xlv_TEXCOORD0);
					  mediump vec3 tmpvar_10;
					  tmpvar_10 = (tmpvar_9 - (2.0 * (
					    dot (tmpvar_8, tmpvar_9)
					   * tmpvar_8)));
					  reflectVector_3.yz = tmpvar_10.yz;
					  reflectVector_3.x = -(tmpvar_10.x);
					  mediump vec3 x_11;
					  x_11 = -(tmpvar_9);
					  highp float tmpvar_12;
					  tmpvar_12 = (1.0 - dot (x_11, (tmpvar_8 * _DistortParams.y)));
					  facing_2 = tmpvar_12;
					  mediump float tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = clamp ((_DistortParams.w + (
					    ((1.0 - _DistortParams.w) * pow (facing_2, _DistortParams.z))
					   * 2.0)), 0.0, 1.0);
					  tmpvar_13 = tmpvar_14;
					  baseColor_1 = _BaseColor;
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = textureCube (_CubeMap, reflectVector_3);
					  baseColor_1.xyz = (baseColor_1.xyz * tmpvar_15.xyz);
					  highp vec4 tmpvar_16;
					  tmpvar_16 = mix (baseColor_1, _ReflectionColor, vec4(tmpvar_13));
					  baseColor_1.xyz = tmpvar_16.xyz;
					  baseColor_1.w = 1.0;
					  gl_FragData[0] = baseColor_1;
					}
					
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
			}
		}
	}
	Fallback "Diffuse"
}