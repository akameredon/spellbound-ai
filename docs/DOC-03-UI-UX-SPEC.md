# DOC-03: UI/UX Component Tree & Design System Spec

## Purpose
Define a maintainable, accessible, mobile-first interface. This is the target component architecture; the current MVP remains primarily in src/App.jsx and should be migrated incrementally.

## 1. Target project layout

    src/
    ├── components/
    │   ├── layout/ (AppShell.jsx, TopHeader.jsx, Navigation.jsx)
    │   ├── scanner/ (WorksheetScanner.jsx, OCRPreview.jsx, ScanHistory.jsx)
    │   ├── arena/ (QuizEngine.jsx, FlashcardGame.jsx, AudioButton.jsx, RewardModal.jsx)
    │   ├── tutor/ (VoiceTutorStudio.jsx, MascotCard.jsx)
    │   └── monetization/ (PaywallModal.jsx, FeatureComparison.jsx)
    ├── lib/ (supabase.js, speech.js, vision.js)
    ├── types/ (index.js)
    ├── App.jsx
    ├── index.css
    └── main.jsx

The current repository uses JavaScript/JSX, not TypeScript. Convert the Vite configuration and files in a dedicated change before introducing TSX files.

## 2. Component responsibilities
- AppShell: responsive frame and global page layout.
- TopHeader: avatar, level, stars, streak and accessible page heading.
- Navigation: desktop sidebar and mobile bottom bar with active states.
- WorksheetScanner: image selection, camera-friendly input, file validation, progress and error states.
- OCRPreview: editable extracted text; clearly distinguish real OCR from manual entry.
- ScanHistory: saved sheets, loading/empty/error states and delete confirmation.
- QuizEngine: question flow, answer validation, progress, keyboard support and completion.
- FlashcardGame: accessible reveal interaction for spelling and vocabulary.
- AudioButton: playback controls and unsupported-browser fallback.
- RewardModal: score summary, earned stars and reduced-motion-friendly celebration.
- VoiceTutorStudio/MascotCard: persona selection and audio. Browser speech is the current free fallback; ElevenLabs requires a server-side proxy.
- PaywallModal/FeatureComparison: presentation only until purchases and entitlements are verified server-side. Never trust a client-set is_pro flag.

## 3. Design system
- Primary: indigo/violet (#6657e8) for navigation, focus and primary actions.
- Reward: amber/gold (#f5b72f) for stars and achievements.
- Success: emerald (#16845b) for correct answers and completed states.
- Error: rose/red with explanatory text and icon; never rely on color alone.
- Surfaces: white cards on a soft slate/lavender background.
- Cards: rounded-2xl, subtle border and shadow.
- Buttons: rounded-xl, visible focus ring, clear disabled/loading states and touch-friendly targets.
- Motion: brief transitions; honor prefers-reduced-motion.
- Accessibility: semantic headings, keyboard operation, descriptive labels, contrast, screen-reader announcements, and no audio autoplay.

## 4. Scanner states
1. Empty: explain file types and size limits.
2. Selected: preview the file and explain where data goes.
3. Processing: show progress only when the OCR service reports it.
4. Review: let a parent/learner correct extracted text before quiz generation.
5. Error: explain failure and allow retry/manual paste.
6. Privacy: do not upload images until the user clearly initiates a configured OCR flow.

## 5. Implementation status
Implemented: responsive dashboard, navigation, mascot picker, text-based quiz generation, multiple-choice quiz, browser speech synthesis, image file selection and basic feedback. Not yet implemented: production OCR, scan-history persistence, real ElevenLabs integration, authentication UI, production billing and family sync.
