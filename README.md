# SpellBound AI

A playful worksheet-to-game learning companion. The MVP focuses on a working local-first quiz experience; Supabase and voice providers are optional integrations configured by the operator.

## Features
- Mobile-responsive study hub with stars, streaks, and mascot cards
- Worksheet image selection with a safe local demo parser (no image is uploaded by default)
- Editable study text to generate spelling/knowledge questions
- Interactive multiple-choice quiz, streak feedback, score and confetti-style celebration
- Browser speech synthesis for question read-aloud (free, device-provided; availability varies)
- Optional Supabase Auth/database wiring scaffold
- SQL schema with RLS and ownership policies

## Run locally

```bash
npm install
cp .env.example .env
npm run dev
```

Open the local URL printed by Vite. Node.js 20+ recommended.

## Supabase setup
1. Create a Supabase project.
2. Run `supabase/schema.sql` in the SQL Editor.
3. Add your project URL and anon/publishable key to `.env`.
4. Never put a service-role key in frontend code. For production, use Edge Functions for OCR/AI and validate generated content server-side.

## Provider integrations
- **Speech:** the MVP uses `window.speechSynthesis` without paid APIs.
- **ElevenLabs:** not called until a secure server-side proxy/Edge Function is configured. Never expose an ElevenLabs API key in Vite client variables.
- **OCR / AI quiz generation:** currently a local demo parser. Add an authorized backend endpoint before sending worksheet images or student data to a third-party AI provider.
- **Payments:** upgrade UI is a non-functional preview only. Do not claim paid entitlements based on client-side flags. Integrate Stripe/RevenueCat via verified server-side webhooks before charging users.

## Child safety and privacy
This app is an early prototype, not a certified child-directed service. Avoid collecting unnecessary information, do not use real children's data during testing, and review COPPA/GDPR-K and applicable school/privacy requirements before launch. Supabase RLS restricts rows by authenticated user; storage buckets and any future API endpoints need their own policies and authorization checks.

## Current limitations
- No production OCR, LLM, cloud image storage, billing, or ElevenLabs synthesis is enabled.
- Guest progress stays in the current browser session; signed-in persistence is scaffolded for extension.
- Validate question quality and answers before using for formal learning or assessment.

## License
MIT. See `LICENSE`.