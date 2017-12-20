//
//  scn_modifiers_common.metal
//
//  Structs defined for SCNShaderModifiers
//
//  Created by Hiroaki Yamane on 12/20/17.
//  Copyright © 2017 Hiroaki Yamane. All rights reserved.
//

#include <metal_stdlib>

using namespace metal;

#include <SceneKit/scn_metal>

/**
 // This structure hold all the informations that are constant through a render pass
 // In a shader modifier, it is given both in vertex and fragment stage through an argument named "scn_frame".
 struct SCNSceneBuffer {
     float4x4    viewTransform;
     float4x4    inverseViewTransform; // transform from view space to world space
     float4x4    projectionTransform;
     float4x4    viewProjectionTransform;
     float4x4    viewToCubeTransform; // transform from view space to cube texture space (canonical Y Up space)
     float4      ambientLightingColor;
     float4        fogColor;
     float3        fogParameters; // x:-1/(end-start) y:1-start*x z:exp
     float2      inverseResolution;
     float       time;
     float       sinTime;
     float       cosTime;
     float       random01;
 };
 **/

struct SCNNodeBuffer {
    float4x4 modelTransform;
    float4x4 inverseModelTransform;
    float4x4 modelViewTransform;
    float4x4 inverseModelViewTransform;
    float4x4 normalTransform; // This is the inverseTransposeModelViewTransform, need for normal transformation
    float4x4 modelViewProjectionTransform;
    float4x4 inverseModelViewProjectionTransform;
    float2x3 boundingBox;
    float2x3 worldBoundingBox;
};

struct SCNShaderGeometry{
    
    float4 position         [[attribute(SCNVertexSemanticPosition)]];
    float3 normal           [[attribute(SCNVertexSemanticNormal)]];
    float4 tangent          [[attribute(SCNVertexSemanticTangent)]];
    float4 color            [[attribute(SCNVertexSemanticColor)]];
    float4 skinningWeights  [[attribute(SCNVertexSemanticBoneWeights)]];
    uint4  skinningJoints   [[attribute(SCNVertexSemanticBoneIndices)]];
    
    float2 texcoord0        [[attribute(SCNVertexSemanticTexcoord0)]];
    float2 texcoord1        [[attribute(SCNVertexSemanticTexcoord1)]];
    float2 texcoord2        [[attribute(SCNVertexSemanticTexcoord2)]];
    float2 texcoord3        [[attribute(SCNVertexSemanticTexcoord3)]];
    float2 texcoord4        [[attribute(SCNVertexSemanticTexcoord4)]];
    float2 texcoord5        [[attribute(SCNVertexSemanticTexcoord5)]];
    float2 texcoord6        [[attribute(SCNVertexSemanticTexcoord6)]];
    float2 texcoord7        [[attribute(SCNVertexSemanticTexcoord7)]];
} /* _geometry */;

struct SCNShaderSurface {
    float3 view;                     // Direction from the point on the surface toward the camera (V)
    float3 position;                 // Position of the fragment
    float3 normal;                   // Normal of the fragment (N)
    float3 tangent;                  // Tangent of the fragment
    float3 bitangent;                // Bitangent of the fragment
    float4 ambient;                  // Ambient property of the fragment
    float2 ambientTexcoord;          // Ambient texture coordinates
    float4 diffuse;                  // Diffuse property of the fragment. Alpha contains the opacity.
    float2 diffuseTexcoord;          // Diffuse texture coordinates
    float4 specular;                 // Specular property of the fragment
    float2 specularTexcoord;         // Specular texture coordinates
    float4 emission;                 // Emission property of the fragment
    float2 emissionTexcoord;         // Emission texture coordinates
    float4 multiply;                 // Multiply property of the fragment
    float2 multiplyTexcoord;         // Multiply texture coordinates
    float4 transparent;              // Transparent property of the fragment
    float2 transparentTexcoord;      // Transparent texture coordinates
    float4 reflective;               // Reflective property of the fragment
    float metalness;                 // Metalness property of the fragment
    float2 metalnessTexcoord;        // Metalness texture coordinates
    float roughness;                 // Roughness property of the fragment
    float2 roughnessTexcoord;        // Metalness texture coordinates
    float4 selfIllumination;         // Self illumination property of the fragment
    float2 selfIlluminationTexcoord; // Self illumination texture coordinates
    float shininess;                 // Shininess property of the fragment
    float fresnel;                   // Fresnel property of the fragment
    float ambientOcclusion;          // Ambient occlusion term of the fragment
} /*_surface*/;


/*
 Access: ReadWrite
 Stages: Vertex shader and fragment shader
 */
struct SCNShaderLightingContribution {
    float3 ambient;
    float3 diffuse;
    float3 specular;
} /*_lightingContribution*/;

/*
 Access: ReadOnly
 Stages: Vertex shader and fragment shader
 */
struct SCNShaderLight {
    float4 intensity;
    float3 direction; // Direction from the point on the surface toward the light (L)
} /*_light*/;

struct SCNShaderGeometryOut
{
    float4 position [[position]];
    float3 normal;
    float4 tangent;
    float4 color;
    float2 texcoords[8];
};

struct SCNShaderOutput {
    half4 color;
};
