# AI Meeting Copilot – iOS App

AI Meeting Copilot iOS is a SwiftUI-based mobile application that enables users to record meetings, upload audio to an AI-powered backend, receive structured summaries, and interact with meeting content using contextual AI chat.

The app is designed with clean MVVM architecture, modular services, reusable UI components, and production-style API integration.

---

# Project Overview

The iOS app acts as the frontend client for the AI Meeting Copilot platform.

It handles:

- Audio recording
- Microphone permission handling
- File upload to backend
- Meeting summary visualization
- AI chat interaction
- Meeting history access
- Persistent local meeting context
- Error handling
- State-driven UI updates

The application communicates with a FastAPI backend deployed in cloud infrastructure.

---

# Core Features

## 1. Audio Recording

Users can record meeting conversations directly from the iOS app.

Capabilities:
- Microphone permission request
- Start recording
- Stop recording
- Save temporary audio file
- Upload-ready audio preparation

---

## 2. Upload Audio to AI Backend

Recorded audio is uploaded to the backend API.

The backend processes:
- Speech-to-text transcription
- Summarization
- Action item extraction
- Key decision extraction

The app then renders structured results.

---

## 3. AI Meeting Summary

After upload, users receive:

- Transcript
- Summary
- Action items
- Key decisions

This converts raw meeting audio into business insights.

---

## 4. Ask AI (Meeting Chat)

Users can ask contextual questions based on meeting content.

Examples:
- What was discussed?
- What were the next steps?
- What decisions were made?
- Were blockers identified?

The chat integrates with backend AI processing.

---

## 5. Meeting State Persistence

The app stores local meeting context for smoother UX.

Used for:
- Current meeting tracking
- Last uploaded meeting
- Chat continuity
- Navigation state

---

## 6. Error Handling

Implemented for:
- Upload failures
- Missing data
- Invalid responses
- API issues
- Network failures
- Permission failures

This improves reliability.

---

## 7. Clean Modular UI

Views are separated for maintainability.

Includes:
- Dashboard
- Recording
- Processing
- Summary
- Chat
- Reusable cards

---

# Tech Stack

## Language
- Swift 5

## UI Framework
- SwiftUI

## Architecture
- MVVM (Model View ViewModel)

## Networking
- URLSession
- REST API integration

## Storage
- AppStorage / Local persistence

## Audio
- AVFoundation

## Testing
- XCTest
- Mock URL Protocol

---

# Architecture Flow

```text
User
   ↓
SwiftUI View
   ↓
ViewModel Layer
   ↓
Service Layer
   ↓
REST API Calls
   ↓
FastAPI Backend
   ↓
AI Processing
   ↓
Response Mapping
   ↓
UI Rendering
Key Functional Flow
Meeting Upload Flow
Record Audio
   ↓
Save Local File
   ↓
Upload API
   ↓
Backend Processing
   ↓
Transcript
   ↓
Summary
   ↓
Action Items
   ↓
Key Decisions
   ↓
Display in UI
Ask AI Flow
Meeting Selected
   ↓
User Question
   ↓
POST /chat
   ↓
AI Answer
   ↓
Chat Rendering
Major Screens
Dashboard

Main landing page.

Provides access to:

Record meeting
Upload flow
Ask AI
Meeting summary
Recording Screen

Handles:

Permission request
Start / stop recording
Recording state
Processing Screen

Displays:

Upload in progress
AI processing state
Loading feedback
Summary Screen

Shows:

Transcript
Summary
Action items
Key decisions
Ask AI Screen

Chat-based interaction for meeting understanding.

Project Structure
AIMeetingCopilot/
│
├── Models/
│   ├── UploadResponse.swift
│   ├── ChatRequest.swift
│   ├── ChatResponse.swift
│   └── ChatMessage.swift
│
├── ViewModels/
│   ├── MeetingViewModel.swift
│   └── RecordingViewModel.swift
│
├── Services/
│   ├── APIService.swift
│   ├── UploadService.swift
│   └── AudioRecorderService.swift
│
├── Views/
│   ├── SplashView.swift
│   ├── RecordingView.swift
│   ├── ProcessingView.swift
│   ├── ChatView.swift
│   └── DashboardCard.swift
│
├── Utilities/
│   ├── AppStorageManager.swift
│   └── AppError.swift
│
└── AIMeetingCopilotApp.swift
Important Components
APIService

Handles:

Generic backend API calls
Response decoding
Error handling
UploadService

Responsible for:

Multipart upload
Audio file submission
Upload response mapping
AudioRecorderService

Handles:

AVFoundation recording
File generation
Recorder lifecycle
MeetingViewModel

Manages:

Upload state
Summary state
Meeting data
Chat interaction
RecordingViewModel

Controls:

Recording lifecycle
Permission flow
UI updates
Testing

Unit tests added for:

API service
Upload service
Recording logic
ViewModels
Mock networking

This improves maintainability and confidence.

Build & Run
Clone Repo
git clone https://github.com/goutamroy/ai-meeting-copilot-ios.git
Open in Xcode

Open:

AIMeetingCopilot.xcodeproj
Run

Select simulator or physical device → Build & Run.

Backend Integration

Connected with FastAPI backend for:

Upload API
Meeting retrieval
Chat API
Health checks
Engineering Practices

Implemented:

MVVM separation
Reusable components
Service abstraction
Structured models
State-driven SwiftUI
Error-first handling
Clean navigation
Testable code design
Use Cases

Can be extended for:

AI meeting assistant
Voice notes summarization
Productivity apps
Team collaboration tools
Enterprise meeting intelligence
Interview demonstration project
Future Enhancements

Planned:

Authentication
Offline support
Multi-meeting chat
Search across meetings
Dark mode refinements
Real-time transcription
Push notifications
iPad optimization
Author

Goutam Roy
Senior iOS Engineer | SwiftUI | MVVM | Mobile Architecture | AI/ML Integration | Cloud-Connected Applications
