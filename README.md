# SpellBound AI

A playful worksheet-to-game learning companion. **Built with Bolt.new** (project concept and development workflow).

> Current MVP: quiz generation from pasted study notes, interactive multiple-choice games, mascot selection, browser-native voice playback, and a Supabase RLS schema foundation. Worksheet OCR, live Supabase persistence, ElevenLabs, and payments are not connected yet.

## Live demo
GitHub Pages URL: https://akameredon.github.io/spellbound-ai/ (available after the Actions deployment succeeds).

## Run locally

    npm install
    cp .env.example .env.local
    npm run dev

## Deploy
GitHub Actions builds the Vite app and deploys dist/ to GitHub Pages on each push to main. Check the repository Actions tab for build/deploy status.

## Supabase setup
Run supabase/schema.sql in the Supabase SQL Editor. The app currently does not persist application data through Supabase; authentication and data wiring remain future work. Never expose service-role keys in frontend code.

## Privacy and child safety
This is a prototype, not a certified child-directed service. Avoid real children's data in testing. Before launch, review COPPA, GDPR-K, school privacy rules, parental consent, retention, deletion and vendor terms. A private storage bucket needs its own access policies if image upload is added.

## Documentation
- [UI/UX component tree and design system](docs/DOC-03-UI-UX-SPEC.md)
- [API integration spec and environment variables](docs/DOC-04-API-INTEGRATION-ENVIRONMENT.md)
- [Devpost submission metadata](docs/DOC-06-DEVPOST-METADATA.md)
- [Three-minute video demo script](docs/DOC-07-VIDEO-DEMO-SCRIPT.md)

DOC-01 (master system prompt), DOC-02 (database schema and RLS), and DOC-05 (Bolt context rules) should be maintained as the approved source documents for the project. DOC-02's current schema file is at `supabase/schema.sql`.

## License
MIT. See LICENSE.
