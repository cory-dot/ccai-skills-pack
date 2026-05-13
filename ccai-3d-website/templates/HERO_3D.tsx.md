# Sample Hero3D component template

This is the reference component the skill produces for a "Hero with 3D background" integration. The skill adapts it to your specific project's `STYLE_GUIDE.md` colors, typography, and copy.

## `components/sections/Hero3D.tsx`

```tsx
'use client'

import dynamic from 'next/dynamic'
import { Suspense } from 'react'
import { useReducedMotion } from 'framer-motion'

// Lazy-load the 3D scene, Three.js can't SSR
const HeroScene = dynamic(() => import('@/components/three/HeroScene'), {
  ssr: false,
  loading: () => <HeroFallback />,
})

function HeroFallback() {
  return (
    <div
      className="absolute inset-0 bg-gradient-to-br from-neutral-900 to-neutral-800"
      aria-hidden="true"
    />
  )
}

export function Hero3D() {
  const prefersReducedMotion = useReducedMotion()

  return (
    <section className="relative min-h-[100svh] overflow-hidden bg-neutral-50">
      {/* 3D background, only render if user hasn't requested reduced motion */}
      <div className="absolute inset-0">
        {prefersReducedMotion ? (
          <img
            src="/3d/hero-fallback.jpg"
            alt=""
            className="h-full w-full object-cover"
          />
        ) : (
          <Suspense fallback={<HeroFallback />}>
            <HeroScene />
          </Suspense>
        )}
      </div>

      {/* Copy overlay */}
      <div className="relative z-10 flex min-h-[100svh] items-center px-6 md:px-12">
        <div className="max-w-3xl">
          <h1 className="font-serif text-5xl text-neutral-50 md:text-7xl">
            {/* Headline from STYLE_GUIDE.md + BRAND_VOICE.md */}
            Your headline here
          </h1>
          <p className="mt-6 max-w-xl text-lg text-neutral-200 md:text-xl">
            Subhead text, pulled from your offer brief.
          </p>
          <div className="mt-10 flex flex-col gap-4 sm:flex-row">
            <a
              href="/book"
              className="rounded-md bg-primary px-8 py-4 font-medium text-white"
            >
              Primary CTA →
            </a>
          </div>
        </div>
      </div>
    </section>
  )
}
```

## `components/three/HeroScene.tsx`

```tsx
'use client'

import { Canvas } from '@react-three/fiber'
import { Environment, Float, OrbitControls } from '@react-three/drei'
import { useGLTF } from '@react-three/drei'

function HeroModel() {
  // Load the GLB file from public/3d/
  const { scene } = useGLTF('/3d/hero-model.glb')
  return <primitive object={scene} scale={1.5} />
}

export default function HeroScene() {
  return (
    <Canvas
      camera={{ position: [0, 0, 5], fov: 45 }}
      gl={{ antialias: true, alpha: true }}
      dpr={[1, 2]}
    >
      <ambientLight intensity={0.4} />
      <directionalLight position={[5, 5, 5]} intensity={0.8} />

      <Float
        speed={1.5}
        rotationIntensity={0.5}
        floatIntensity={0.5}
      >
        <HeroModel />
      </Float>

      <Environment preset="city" />

      {/* Optional: allow user to interact (or remove for purely-decorative background) */}
      <OrbitControls
        enableZoom={false}
        enablePan={false}
        autoRotate
        autoRotateSpeed={0.5}
      />
    </Canvas>
  )
}

// Preload the model for slightly faster perceived load
useGLTF.preload('/3d/hero-model.glb')
```

## What you customize after generation

1. **Replace `/3d/hero-model.glb`** with your actual model
2. **Adjust `scale={1.5}`** in `HeroModel`, depends on your model's native scale
3. **Camera position**, `[0, 0, 5]` works for most front-facing models; raise Z for distant objects
4. **Update headline + subhead + CTA**, from your offer/brief
5. **Replace `/3d/hero-fallback.jpg`**, a still image for users on reduced-motion or low-power devices

## Performance notes

- `dpr={[1, 2]}` caps device pixel ratio at 2 to avoid retina-display performance hits
- `autoRotate` is gentle (`autoRotateSpeed={0.5}`), too fast looks gimmicky
- `useGLTF.preload` starts loading the model before the component mounts

## Spline-based alternative

If your asset is a Spline `.splinecode` URL instead of a GLB:

```tsx
'use client'

import dynamic from 'next/dynamic'

const Spline = dynamic(() => import('@splinetool/react-spline'), { ssr: false })

export default function HeroScene() {
  return (
    <div className="h-full w-full">
      <Spline scene="https://prod.spline.design/your-scene-id/scene.splinecode" />
    </div>
  )
}
```

Spline is heavier (~1MB) but easier for non-3D-modelers.
