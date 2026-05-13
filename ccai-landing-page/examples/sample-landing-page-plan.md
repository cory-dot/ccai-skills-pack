# Sample Landing Page Plan, Creative Core AI Skool Course (free)

## Brief

- **Awareness stage:** Solution-aware (they know AI tools exist, evaluating which one + how to use it)
- **Offer:** Free Skool course "The AI Operator's Playbook" + $20/mo community (founding-50 lock)
- **Audience:** Small business owner, 30-50, using ChatGPT or Claude but feels output sounds generic
- **Proof anchor:** 12 of 14 clients I onboarded this year are producing usable AI output by week 2
- **Primary objection:** "I don't have time to learn another tool"
- **Transformation:** "AI that sounds like AI" → "AI that sounds like your business", one weekend of setup

## Framework: PAS (Problem → Agitation → Solution) for primary, with FAB for the offer panel

## Page route
`app/free-course/page.tsx` → `creativecore.ai/free-course`

## The 7 panels

### Panel 1, Hero
- **Headline:** Your AI sounds like every other AI. Here's how to fix that in one weekend.
- **Subhead:** The free course that turns Claude into a tool that sounds like *you*, not like a corporate chatbot. Built for small business owners. No coding required.
- **Primary CTA:** Start the free course →
- **Sub-CTA:** No credit card. 9 modules. The first one takes a Saturday.
- **Visual:** Stark split image, left side over-formal AI email, right side casual real-person email with a thin red dividing line.

### Panel 2, Social proof
- **Format:** Logo strip (5 client logos) above a 3-quote testimonial row
- **3 testimonials (placeholder, user provides):**
  - [Client A, real estate broker]: "I was 2 months in with ChatGPT and getting nowhere, this course got me past the 'sounds AI' wall in a weekend."
  - [Client B, coach]: "12 of my 14 weekly emails are now drafted by Claude in my voice. Saved me 3 hours/week."
  - [Client C, agency owner]: "Best $0 course I've ever taken, and I've taken too many."

### Panel 3, Problem agitation
- **Heading:** You've tried using Claude or ChatGPT for your business. The output looks fine, but you can't actually use it.
- **3 specific examples** the audience will recognize:
  - "You wrote a great captions prompt but the captions still sound like LinkedIn drivel."
  - "You ask for emails and get 'I hope this finds you well, I noticed...' three sentences in."
  - "You paste blog drafts and your readers can tell within 2 paragraphs."
- **Closing line:** *"The problem isn't Claude. It's that Claude has no idea what you sound like."*

### Panel 4, Offer
- **Heading:** What you build in the course
- **Module list with 1-line outcomes:**
  - Module 0, Set up Claude correctly the first time
  - Module 1, Claude Code mastery + brand voice capture
  - Module 2, Design + websites with AI
  - Module 3, Content creation and marketing
  - Module 4, Ads, leads, sales
  - Module 5, Video and creative
  - Module 6, Automation and agents
  - Module 7, Memory, tokens, efficiency
  - Module 8, Advanced orchestration
- **Deliverables column:** Free course, free Module 0 ready now, paid $20/mo community
- **Founding offer callout (red accent):** First 50 founding members lock $20/mo forever. Currently [27/50].

### Panel 5, FAQ (handles top objections)
- **Q1:** I don't have time to learn another tool, how long does this take?
  *A: Module 0 takes one Saturday. After that, you can pace at 1-2 hours/week. The course is designed for people running businesses, not for full-time learners.*
- **Q2:** Will this work for my specific business?
  *A: We've taught 14 owners across coaching, real estate, ecom, services, and SaaS. The framework is universal because brand voice and AI workflows are universal, the examples adapt.*
- **Q3:** Is the community really $20/mo for founding members?
  *A: Yes, locked forever. Once we hit 50 founding members, the rate moves to $40/mo. Until then, the founding rate is exactly $20.*
- **Q4:** What's in the free version vs. the paid community?
  *A: The course (all 9 modules) is free. The $20/mo community is where you get peer review, live sessions, and access to me for questions. You can complete the course without joining the paid tier.*
- **Q5:** What if it doesn't work for me?
  *A: The course is free. If after Module 0 you decide it's not right, you've lost a Saturday, and you'll have a working Claude setup as a parting gift. If you joined the community: 30-day refund, no questions, keep the course.*

### Panel 6, Risk reversal
- **Heading:** Three layers of "you can't lose"
  1. The course is free. Zero financial risk to start.
  2. The community has a 30-day money-back guarantee. You finish Module 0 and try the community for a month risk-free.
  3. Founding rate locked forever. Even if we 10x prices later, your $20 stays $20.

### Panel 7, Final CTA
- **Primary action:** Start the free course → (Skool link)
- **Alternate path:** Or [book a free diagnostic call](https://creativecore.ai/book) if you'd rather have us build the workflow for you

---

## Tech notes

- All 7 sections as separate components in `components/sections/free-course/`
- Hero gets a Framer Motion entry on initial load
- Social proof + final CTA get viewport-triggered reveals
- Form is Cal.com inline embed for the diagnostic-call alternate path
- Image placeholders for 3 testimonial photos + 5 client logos (user uploads)

---

## What gets generated

```
app/
└── free-course/
    └── page.tsx                    # imports all 7 sections
components/
└── sections/
    └── free-course/
        ├── Hero.tsx
        ├── SocialProof.tsx
        ├── Problem.tsx
        ├── Offer.tsx
        ├── FAQ.tsx
        ├── Risk.tsx
        └── FinalCTA.tsx
```

7 React components. ~500 lines total. Mobile-responsive. Framer Motion entry on hero + scroll reveals on social proof / final CTA. Cal.com embed wired in section 7.

---

*Plan generated by ccai-landing-page. Approval gate before generating code.*
