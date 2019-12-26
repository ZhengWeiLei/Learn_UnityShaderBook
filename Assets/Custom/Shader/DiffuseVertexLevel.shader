// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Unlit/DiffuseVertexLevel"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Diffuse ("Diffuse", color) = (1,1,1,1)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			Tags {"LightMode" = "ForwardBase"}

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			//#pragma multi_compile_fog
			
			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			struct a2v
			{
				float4 vertex : POSITION;
				float2 normal : NORMAL;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				half3 color : COLOR;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			half4 _Diffuse;
			
			v2f vert (a2v v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

				fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;

				//fixed3 worldNormal = normalize(mul(v.normal, (float3x3)_World2Object));
				fixed3 worldNormal = normalize(mul((float3x3)unity_ObjectToWorld, v.normal ));
				fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);

				fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * saturate(dot(worldNormal, worldLight));

				o.color = ambient + diffuse;

				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				return fixed4(i.color, 1.0);
			}
			ENDCG
		}
	}

	Fallback "VertexLit"
}
