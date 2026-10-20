# DOC-04: API Integration Spec & Environment Variables

**Status:** Integration contract, not proof that each integration is implemented. Verify features end-to-end before describing them as working.

## 1. Environment variables

Copy `.env.example` to `.env.local` for local development. Never commit real credentials.

### Browser-safe Vite variables

```env
VITE_SUPABASE_URL=https://YOUR_PROJECT.supabase.co
VITE_SUPABASE_ANON_KEY=YOUR_SUPABASE_PUBLISHABLE_OR_ANON_KEY

# Public voice IDs are identifiers, not API secrets.
VITE_ELEVENLABS_VOICE_ID_OWL=21m00Tcm4TlvDq8ikWAM
VITE_ELEVENLABS_VOICE_ID_WIZARD=AZnzlk1XvdvUeBnXmlld

# Only if a supported RevenueCat web integration is configured:
# VITE_REVENUECAT_PUBLIC_SDK_KEY=YOUR_PUBLIC_WEB_SDK_KEY
```

### Server-side secrets — never prefix with VITE_

Store these only in the server runtime or Supabase Edge Function secrets:
- `ELEVENLABS_API_KEY`
- `OPENAI_API_KEY`
- Supabase service-role key
- Payment-provider secret keys and webhook signing secrets

**Important:** Vite embeds `VITE_*` values in downloadable browser assets. A key with that prefix is public even when the local env file is gitignored. GitHub Pages is static hosting and cannot safely hold private API keys. Use a serverless endpoint or Supabase Edge Function for privileged provider requests.

## 2. Integration status and architecture

| Capability | Recommended architecture | MVP status |
|---|---|---|
| Auth and progress | Supabase JS, database tables, tested Row Level Security (RLS) | Foundation/schema only; verify end-to-end auth and persistence |
| Worksheet OCR | Browser uploads image to a server endpoint / Edge Function, which calls OpenAI Vision | Not implemented |
| Character voice | Server endpoint / Edge Function calls ElevenLabs and returns audio bytes or a short-lived URL | Not implemented; browser speech synthesis is the current fallback |
| Subscription | Supported web billing integration; verify entitlements on a trusted server | Not implemented; an Apple `appl_...` key is not a generic web key |
| Hosting | GitHub Pages static build | Configured; confirm deployment in GitHub Actions |

## 3. Supabase client

The project includes `@supabase/supabase-js`. The browser may use only the project URL and publishable/anon key. That key is intentionally visible; security depends on correct database grants and RLS policies.

Requirements:
1. Enable RLS on all user/child data tables.
2. Test allowed and denied access with at least two separate accounts.
3. Never ship the service-role key to the browser.
4. Keep worksheet data and children's personal information to the minimum needed.

## 4. ElevenLabs text-to-speech contract

Suggested endpoint: `POST /api/voice` or a Supabase Edge Function.

Request:
```json
{ "text": "Spellbound", "voiceId": "configured-voice-id" }
```

Response: audio bytes (for example `audio/mpeg`) or a short-lived URL.

The server should validate authentication, text length, and allowed voice IDs; use `ELEVENLABS_API_KEY` from server-side secrets; handle rate limits/timeouts; and avoid logging sensitive worksheet content. If the browser creates an object URL using `URL.createObjectURL`, revoke it when playback is finished or the component unmounts.

Do not put the private key in `VITE_ELEVENLABS_API_KEY` or call ElevenLabs directly from the browser with a private key.

## 5. Vision OCR and quiz extraction contract

Suggested endpoint: `POST /api/worksheet/extract` or a Supabase Edge Function.

Request:
```json
{ "image": "data:image/jpeg;base64,...", "locale": "en" }
```

Validate MIME type and image size, call OpenAI from the server using `OPENAI_API_KEY`, request structured output, and validate the returned object against the app's schema before saving or displaying it.

Suggested normalized response:
```json
{
  "title": "Weekly spelling",
  "difficulty": "easy",
  "questions": [
    { "prompt": "Spell the word", "answer": "example", "hint": "A sample" }
  ]
}
```

Align this schema with the actual quiz model before implementation. Handle unreadable images, empty worksheets, unsupported formats, timeouts, and provider errors. Avoid transmitting identifiable child data unless necessary and covered by the privacy and consent process.

## 6. RevenueCat and billing

Do not assume an Apple `appl_...` SDK key supports a web app. Choose a supported web billing path first. Expose a public SDK key only when the provider explicitly identifies it as public; keep API secrets and webhook signing secrets server-side. Verify entitlements on a trusted server and provide transparent pricing and cancellation/restore paths before charging users.

## 7. Development and release checklist

1. Copy `.env.example` to `.env.local`; add only browser-safe values.
2. Confirm `.env.local` is ignored by Git and contains no committed secrets.
3. Configure server secrets in the Edge Function/server runtime.
4. Add input validation, rate limits, error handling, and privacy-conscious logs.
5. Test authentication and RLS with multiple accounts.
6. Run `npm run build` and test the production build.
7. Remember that static hosting compiles browser variables into public assets.
8. Update status claims only after integrations work end-to-end in a repeatable test.
