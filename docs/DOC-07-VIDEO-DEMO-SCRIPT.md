# DOC-07: 3-Minute Video Demo Script & Storyboard

**Runtime:** 3:00  
**Format:** 16:9 screen recording with voiceover and captions.

> **Accuracy note:** The current MVP does not yet implement worksheet OCR, server-side ElevenLabs voice generation, complete Supabase authentication/persistence, or billing. Record only features that work in the exact build being submitted. Use the marked roadmap lines if a feature is not ready; do not present mockups as live integrations.

## Video title

**SpellBound AI — Turn Paper Worksheets into Voice-Guided Learning Games**

## 0:00–0:30 — The hook

**Visual:** Show a paper spelling worksheet, then cut to the SpellBound AI dashboard. Use fictional, non-identifying sample content.

**Voiceover:**  
“Worksheets help children practice, but repeating the same words can feel like a chore. SpellBound AI is designed to make learning practice more engaging with playful, voice-guided activities. Let me show you the experience we’re building.”

**On-screen text:** “From worksheet practice to playful learning”

## 0:30–1:10 — Meet the app

**Visual:** Show the app dashboard, choose a mascot, and navigate into the quiz experience. Keep cursor movements deliberate and zoom in on key controls.

**Voiceover — only after verifying the controls in the deployed build:**  
“Students can enter a friendly learning space, choose a character, and practice in short quiz rounds. The interface focuses on clear prompts, feedback, and small celebrations when an answer is correct.”

**On-screen text:** “Friendly characters • Short practice rounds • Feedback”

**If worksheet scanning is not implemented, say:**  
“Photo-to-quiz extraction is a planned next step. Today, I’m demonstrating the working practice experience.”

## 1:10–1:55 — Gameplay and voice

**Visual:** Answer several questions, show the actual correct/incorrect feedback, and demonstrate the voice option only if it works in the recorded build. Capture real interactions.

**Voiceover:**  
“Practice works best when learners can try, get feedback, and try again. SpellBound’s game loop is built around that rhythm. In this prototype, I’m showing the quiz experience; worksheet extraction and premium character voice generation remain planned integrations.”

**On-screen text:** “Practice • Feedback • Try again”

**If ElevenLabs is implemented and tested before recording:** Replace the roadmap sentence with a truthful description of the voice request actually being made. Do not claim ElevenLabs usage unless the recording demonstrates it.

## 1:55–2:30 — How it is built

**Visual:** Show the repository, React/Vite project, and Supabase schema or RLS policies only if the artifacts exist and are accurate. Never show API keys, private student records, or tokens.

**Voiceover:**  
“SpellBound AI is being developed as a web app with React and Vite. Supabase is the planned foundation for accounts and learning progress, with row-level security needed to protect each learner’s data. OCR, managed voice generation, and billing will be added and tested before being described as production-ready.”

**On-screen text:** “React + Vite • Supabase foundation • Integrations in progress”

## 2:30–3:00 — Close and call to action

**Visual:** Return to the app. Show the repository URL and demo URL only if the deployment has been confirmed and is accessible. End with the SpellBound AI name and a concise call to action.

**Voiceover:**  
“Our goal is simple: help children practice with more confidence and less friction. SpellBound AI is an evolving prototype, and we’re building toward a workflow that connects worksheets, interactive quizzes, and encouraging audio. Explore the code, try the verified demo, and follow along as we ship the next milestones.”

**On-screen text:**  
“SpellBound AI — Make practice playful”  
“Explore the code • Try the verified demo”

## Recording checklist

- Use fictional worksheet content and test accounts.
- Record the exact build reviewers can access.
- Verify every button and interaction before recording.
- Never show keys, tokens, student names, or personal information.
- Add captions and keep text readable on mobile.
- Do not claim integrations, sponsor usage, or production security that has not been verified.
- If GitHub Pages deployment has not passed its workflow, do not call the URL a live production demo.
- Replace roadmap language only after the feature is implemented and tested end-to-end.
