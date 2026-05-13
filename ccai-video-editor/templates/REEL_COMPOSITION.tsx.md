# Sample Reel composition (Remotion)

> Reference for a 30-second vertical reel template. The skill produces this with your specific brand colors, fonts, and copy.

## `src/Root.tsx`

```tsx
import { Composition } from 'remotion'
import { Reel } from './Composition'
import { variants } from './data'

export const RemotionRoot = () => {
  return (
    <>
      {variants.map((variant, index) => (
        <Composition
          key={index}
          id={`Reel-${index + 1}`}
          component={Reel}
          durationInFrames={30 * 30}        // 30sec at 30fps
          fps={30}
          width={1080}
          height={1920}
          defaultProps={variant}
        />
      ))}
    </>
  )
}
```

## `src/Composition.tsx`

```tsx
import { AbsoluteFill, Sequence, useCurrentFrame } from 'remotion'
import { Hook } from './components/Hook'
import { Body } from './components/Body'
import { Outro } from './components/Outro'

export interface ReelProps {
  headline: string
  subhead: string
  proofNumber: string
  ctaText: string
  ctaUrl: string
  backgroundImage?: string
}

export const Reel: React.FC<ReelProps> = (props) => {
  return (
    <AbsoluteFill style={{ backgroundColor: '#fafaf8' }}>
      {/* 0–3 sec: hook */}
      <Sequence from={0} durationInFrames={90}>
        <Hook headline={props.headline} />
      </Sequence>

      {/* 3–24 sec: body */}
      <Sequence from={90} durationInFrames={630}>
        <Body
          subhead={props.subhead}
          proofNumber={props.proofNumber}
          backgroundImage={props.backgroundImage}
        />
      </Sequence>

      {/* 24–30 sec: CTA */}
      <Sequence from={720} durationInFrames={180}>
        <Outro ctaText={props.ctaText} ctaUrl={props.ctaUrl} />
      </Sequence>
    </AbsoluteFill>
  )
}
```

## `src/components/Hook.tsx`

```tsx
import { AbsoluteFill, useCurrentFrame, interpolate, spring, useVideoConfig } from 'remotion'

export const Hook: React.FC<{ headline: string }> = ({ headline }) => {
  const frame = useCurrentFrame()
  const { fps } = useVideoConfig()

  // Spring entry animation
  const opacity = spring({
    frame,
    fps,
    config: { damping: 200 },
  })

  const translateY = interpolate(frame, [0, 20], [40, 0], { extrapolateRight: 'clamp' })

  return (
    <AbsoluteFill
      style={{
        backgroundColor: '#0a0a0a',
        justifyContent: 'center',
        alignItems: 'center',
        padding: 80,
      }}
    >
      <h1
        style={{
          opacity,
          transform: `translateY(${translateY}px)`,
          color: '#fafaf8',
          fontFamily: 'DM Serif Display, serif',
          fontSize: 96,
          lineHeight: 1.1,
          textAlign: 'center',
          margin: 0,
        }}
      >
        {headline}
      </h1>
    </AbsoluteFill>
  )
}
```

## `src/data.ts`, variants

```typescript
import { ReelProps } from './Composition'

export const variants: ReelProps[] = [
  {
    headline: '$20 is the cheaper Claude plan.',
    subhead: '12 of 14 clients regretted starting on Free.',
    proofNumber: '12/14',
    ctaText: 'Free plan guide in bio',
    ctaUrl: 'creativecore.ai/guides/which-claude-plan',
  },
  {
    headline: 'Your AI sounds generic. Here\'s the fix.',
    subhead: '20-minute setup. Every prompt benefits.',
    proofNumber: '20 min',
    ctaText: 'Free course in bio',
    ctaUrl: 'skool.com/creative-core-ai',
  },
  // ... add as many as you want
]
```

## Rendering all variants

```bash
# Preview one variant in browser
npm run preview

# Render a single variant to MP4
npx remotion render Reel-1 out/reel-1.mp4

# Render all variants
npm run render-all
```

The `render-all` script iterates `variants[]` and produces `out/reel-1.mp4`, `out/reel-2.mp4`, etc.

## Resolution + codec notes

Default Remotion settings produce a good-quality MP4 for social media. To optimize:

```bash
# Smaller file size (faster upload)
npx remotion render Reel-1 out/reel-1.mp4 --codec=h264 --crf=23

# Highest quality (larger file)
npx remotion render Reel-1 out/reel-1.mp4 --codec=h264 --crf=18
```

For Meta/TikTok delivery, `--crf=23` is the sweet spot.
