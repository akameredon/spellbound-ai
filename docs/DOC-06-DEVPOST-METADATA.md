# DOC-06: Devpost Submission Metadata

> Submission draft. Add a real demo URL, screenshots and demo video before submitting. Do not claim integrations that are not connected.

## Project title
SpellBound AI — Worksheet-to-Game Learning Companion

## Tagline
Turn study notes into playful quizzes, spelling challenges and voice-guided learning adventures.

## Inspiration
Worksheets and revision notes can feel static and repetitive. SpellBound AI explores how small, playful interactions and spoken prompts can help learners engage with study material in a more inviting way.

## What it does
- Study-to-quiz: learners paste study notes and generate a lightweight practice quiz.
- Interactive practice: multiple-choice answers, feedback, scores, stars and celebratory effects.
- Voice tutor: choose a friendly mascot and hear prompts using the browser's built-in speech engine.
- Worksheet selection: select an image as a starting point for a future OCR workflow. OCR is not connected in this MVP; users paste text manually.
- Privacy-aware foundation: a Supabase schema with row-level security is provided for future signed-in persistence.

## How we built it
- React and Vite for the web app.
- Tailwind CSS for responsive styling.
- Lucide React for icons.
- Canvas Confetti for reward moments.
- Browser SpeechSynthesis API for free device-based read-aloud.
- Supabase SQL schema for a planned authenticated data layer.
- GitHub Actions for production build and GitHub Pages deployment.

## Current working demo
- Responsive study dashboard and navigation.
- Sample quiz and local quiz generation from pasted text.
- Answer feedback, score/stars and confetti.
- Mascot selection and browser voice playback.

## Planned / not yet connected
- Automatic printed/handwritten OCR and AI-generated question quality checks.
- ElevenLabs character voice synthesis through a secure server-side function.
- Supabase authentication and persistent user data wiring.
- Stripe/RevenueCat purchase validation and subscription entitlements.
- Family sync and production-grade child privacy controls.

## Sponsor-track alignment (not a claim of entry or eligibility)
- ElevenLabs Voice AI: potential fit after ElevenLabs synthesis is implemented and demonstrated. Current voice is browser-native.
- RevenueCat Monetization: potential fit only after a supported RevenueCat integration and verified purchase flow; payments are not active.
- Supabase: schema/RLS foundation exists; live auth and app persistence still need wiring and testing.
- Netlify/deployment: this repository is configured for GitHub Pages; do not claim a Netlify deployment unless separately created.

## Built with
React, Vite, Tailwind CSS, Lucide React, Canvas Confetti, browser SpeechSynthesis API, Supabase schema and GitHub Actions.

## Suggested demo flow
1. Open the Study Hub at mobile width.
2. Create a study game by pasting a short set of notes.
3. Generate a quiz and answer questions.
4. Demonstrate read-aloud and select another mascot.
5. Show the repository and explain which backend integrations remain planned.

## Before submission checklist
- [ ] Add the live deployed URL after GitHub Pages reports a successful deployment.
- [ ] Capture screenshots and record a short demo video.
- [ ] Verify all statements against the current build.
- [ ] Review official sponsor eligibility, dates and rules.
- [ ] Add privacy policy and child-safety disclosures before testing with real children.
- [ ] Never put service-role, voice-provider or payment secrets in frontend variables.
