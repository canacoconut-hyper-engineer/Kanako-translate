# 🤖 AI Translator

This is a one-page AI-powered translation app.  
Users can enter text in any language and receive translations via OpenAI.

---

## 🔧 Tech Stack

- **Frontend:** React (Vite)
- **Backend:** Elixir + Plug + Req
- **AI Service:** OpenAI GPT-3.5-turbo (via Chat Completion API)
- **Persistence:** JSON file storage
- **Testing:** ExUnit (Elixir's built-in test framework)

---

## 🚀 Features

- 📚 **Book-Reading Companion Design**  
  As a bonus feature, I added enhancements that could benefit the user experience.  
  I also wanted to showcase my design thinking as a UI/UX designer in this part.  
  I envisioned this app as a **book-reading companion**, and designed features with clean, comfortable typography and layout to enhance readability and usability.  

  - 📱 **Responsive Design**
    Users will be able to use this app in any circumstance.
  - 📜 **Translation History**
      Users can revisit previous translations anytime.
  - 🧭 **Smooth and Simple User Flow**:
    I adopted a **progressive disclosure** approach, guiding users step-by-step through a clear and intuitive process:
    - The starting point: clearly highlighted with a large input prompt
    - The **Translate** button is disabled until the user inputs text
    - A **friendly loading animation** plays when translating, and the button shows “Translating…”
    - The translated result appears in **literature-friendly serif typography**

---

## 🛠️ Setup Instructions

### Backend (Elixir API)
mix deps.get
cp .env.example .env
# Then edit `.env` to include your OpenAI API key
mix run --no-halt

🔑 Environment Variables
To run the backend, you need an OpenAI API key.

1. Copy the example file:
cp .env.example .env

2. Open .env and replace the placeholder with your actual OpenAI API key:
OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxx

⚠️ Note:
.env is included in .gitignore and will not be committed to Git for security reasons.
Please do not share your actual API key publicly.
You can get your API key from https://platform.openai.com/account/api-keys

**Frontend (React)**
cd translate-app
npm install
npm run dev

**Running Tests**
mix test
All tests are written with ExUnit and include integration tests for:
- POST /translate
- GET /history
- Invalid requests


---

**📁 Project Structure**

**Backend - translate_api/**
translate_api/
├── lib/translate_api/               # Main backend logic (controllers, routing, AI service, history persistence)
│   ├── application.ex               # Application entry point
│   ├── history.ex                   # Module for reading/writing translation history
│   ├── openai.ex                    # Module for interacting with OpenAI API
│   ├── router.ex                    # HTTP routing
│   ├── translate_controller.ex      # Handles translation requests
│   └── translate_api.ex             # Main supervision tree
│
├── test/                            # Test files using ExUnit
│   ├── history_test.exs
│   ├── router_test.exs
│   └── translate_api_test.exs
│
├── config/config.exs               # Basic app configuration
├── data/history.json               # Stores translation history (production)
├── tmp/test_history.json           # Stores translation history for testing
├── mix.exs                         # Project definition and dependencies
├── README.md                       # Project overview and documentation

**Frontend - translate-app/**
translate-app/
├── public/                     # Static assets
│   ├── Book.gif               # Loading animation
│   ├── favicon.ico           # Site icon
│   └── index.html            # Main HTML template
│
├── src/                       # Main React source code
│   ├── api/                   # API communication logic
│   │   └── getHistory.js     # Fetches translation history
│   │
│   ├── components/            # React components
│   │   ├── field.js          # Input field with language selector
│   │   ├── History.js        # Displays translation history
│   │   ├── languages.js      # Language list config
│   │   └── translate.js      # Main translation logic
│   │
│   ├── styles.css             # Main CSS styles (responsive layout, typography)
│   ├── App.js                 # Root app layout and logic
│   └── index.js               # React entry point
│
├── package.json               # Project config and dependencies
└── README.md                  # Project documentation

### 1. Clone this repository

```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name