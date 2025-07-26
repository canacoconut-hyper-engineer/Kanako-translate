# 🤖 AI Translator

This is a one-page AI-powered translation app.  
Users can enter text in any language and receive translations via OpenAI.

I chose the **Text Translation** feature for this project because it's both universally useful and ideal for demonstrating interaction design, API integration, and multilingual UX thinking in a simple UI.


## 🔧 Tech Stack

- **Frontend:** React (Create React App - CRA)
- **Backend:** Elixir + Plug + Req
- **AI Service:** OpenAI GPT-3.5-turbo (via Chat Completion API)
- **Persistence:** JSON file storage
- **Testing:** ExUnit (Elixir's built-in test framework)

## 📚 Features

### Book-Reading Companion Design

As a bonus feature, I added enhancements that could benefit the user experience.  
I also wanted to showcase my design thinking as a UI/UX designer in this part.  
I envisioned this app as a **book-reading companion**, and designed features with clean, comfortable typography and layout to enhance readability and usability.  

- 📱 **Responsive Design**:
  This app is designed to work seamlessly in any situation.
- 📝 **Comfortable Typography**: 
  Used Noto Sans and Noto Serif — globally trusted fonts designed for readability and broad language support, ideal for future multilingual scalability.
- 🎨 **Accessible Colour Contrast**: 
  Color contrast, especially for text, meets WCAG AA standards to ensure readability and accessibility.
- 🎯 **Visual Hierarchy**: 
  I used font sizes and layout to guide user focus and enhance readability.
- 📜 **Translation History**:
    Users can revisit previous translations anytime.
- 🧭 **Smooth and Simple User Flow**:
  I adopted a **progressive disclosure** approach, guiding users step-by-step through a clear and intuitive process:
  - The starting point: clearly highlighted with a large input prompt
  - The **Translate** button is disabled until the user inputs text
  - A **friendly loading animation** plays when translating, and the button shows “Translating…”
  - The translated result appears in **literature-friendly serif typography**
 
## 🧹 Code Quality
- I kept the backend modular with clear separation of concerns (e.g., `router`, `controller`, `services`).
- Used descriptive function names and consistent formatting for readability.
- Added simple unit tests to cover core logic and ensure confidence during changes.
- `.env` is gitignored and follows `.env.example` format to avoid leaking sensitive info
- Before submission, I consulted 3–5 senior engineer connections to review the code and incorporated their feedback to improve structure and clarity.
- While I focused mainly on unit tests due to time constraints, integration tests (e.g., frontend-backend communication) are planned as a next step.


## 🔭 Furthermore, if I had more time
- Use a database like PostgreSQL for better scalability (JSON chosen for speed).
- Add pagination, delete and filter (by date, content, language, etc.) in history.
- Add user authentication & persistence.
- Implement integration tests.
- UX idea: AI-powered history organisation — user translations are analysed by AI, linked to relevant books and articles, and automatically organised into a virtual bookshelf. This helps users not only translate but also build lasting, personalised knowledge collections.
  

## 🚀 How to run

### ⚙️ Prerequisites
Before running the app, make sure the following tools are installed on your system:

- **Elixir** ≥ 1.15
  - This project uses Plug, Plug.Cowboy, and modern .env loading via Dotenvy, which require Elixir 1.14 or higher, but 1.15 is recommended for stability and compatibility.
  👉 Install guide: https://elixir-lang.org/install.html
- **Erlang/OTP** ≥ 26
  - Required to run Elixir 1.15 properly. Often bundled with Elixir installation (e.g., via asdf).
- **Node.js** ≥ 16 
  👉 Install: https://nodejs.org/
- **npm** ≥ 8  
  Comes bundled with Node.js


### 🔁 Backend (Elixir API)

1. Navigate to the `translate_api` directory:

    ```bash
    cd translate_api
    ```

2. Install dependencies:

    ```bash
    mix deps.get
    ```

3. Create a `.env` file from the `.env.example`:

    ```bash
    cp .env.example .env
    ```

4. Open `.env` and add your OpenAI API key:

    ```env
    OPENAI_API_KEY=your-openai-api-key
    ```

   🔑 You can get your API key from the official OpenAI website: https://platform.openai.com/account/api-keys

5. Start the backend server:

    ```bash
    mix run --no-halt
    ```


### 💻 Frontend (React)

1. Navigate to the `translate-app` directory:

    ```bash
    cd translate-app
    ```

2. Install packages:

    ```bash
    npm install
    ```

3. Create a `.env` file based on `.env.example`:

    ```bash
    cp .env.example .env
    ```

4. Open `.env` and add your environment variables:

    ```env
    OPENAI_API_KEY=your-openai-api-key
    BASE_URL=http://localhost:4000
    ```

    ※ BASE_URL is the address where your backend API is running.

5. Start the frontend development server:
   Built with React using **Create React App**.  

    ```bash
    npm start
    ```

7. Open the app in your browser:

    ```
    http://localhost:3000
    ```
    
    
**🔐 Environment & Security Notes**
- .env files are listed in .gitignore, so they will not be pushed to GitHub.
- Never share your real API keys publicly.

## 🧪 Backend Testing (ExUnit)
Tests are written using Elixir's built-in test framework, ExUnit.
These tests cover API routing, translation history handling, and response behavior for both valid and invalid requests.

To run tests:
```bash
cd translate_api
mix test
```

Test cases cover:
- POST /translate: Successful and invalid requests
- GET /history: Successful retrieval of stored translations

Test files:
```bash
translate_api/test/
├── history_test.exs          # Tests for reading/writing history
├── router_test.exs           # Endpoint routing and request handling
└── translate_api_test.exs    # Application setup and coverage
```


## 📁 Project Structure

### Backend - translate_api/
```bash
translate_api/
├── lib/translate_api/               # Main backend logic (controllers, routing, AI service, history persistence)
│   ├── application.ex               # Application entry point
│   ├── history.ex                   # Module for reading/writing translation history
│   ├── openai.ex                    # Module for interacting with OpenAI API
│   ├── router.ex                    # HTTP routing
│   ├── translate_controller.ex      # Handles translation requests
│   └── translate_api.ex             # Main supervision tree
│
├── test/                            # Backend test files using ExUnit
│   ├── history_test.exs             # Tests translation history persistence
│   ├── router_test.exs              # Tests API routes and HTTP response behavior
│   └── translate_api_test.exs       # Tests the main translation flow and edge cases
│
├── config/config.exs               # Basic app configuration
├── data/history.json               # Stores translation history (production)
├── tmp/test_history.json           # Stores translation history for testing
└── mix.exs                         # Project definition and dependencies
```

### Frontend - translate-app/
```bash
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
└── package.json               # Project config and dependencies
```

