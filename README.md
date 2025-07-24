# 🤖 AI Translator

This is a one-page AI-powered translation app.  
Users can enter text in any language and receive translations via OpenAI.



## 🔧 Tech Stack

- **Frontend:** React (Vite)
- **Backend:** Elixir + Plug + Req
- **AI Service:** OpenAI GPT-3.5-turbo (via Chat Completion API)
- **Persistence:** JSON file storage
- **Testing:** ExUnit (Elixir's built-in test framework)

### Furthermore, if I had more time
- Database for schalability - I’d consider PostgreSQL, but opted for JSON for speed.
- Authentication & User Persistence
- Added integration tests (e.g., frontend-backend flow) beyond unit tests.


## 🚀 Features

### 📚　Book-Reading Companion Design

As a bonus feature, I added enhancements that could benefit the user experience.  
I also wanted to showcase my design thinking as a UI/UX designer in this part.  
I envisioned this app as a **book-reading companion**, and designed features with clean, comfortable typography and layout to enhance readability and usability.  

- 📱 **Responsive Design**:
  Users will be able to use this app in any circumstance.
- 📜 **Translation History**:
    Users can revisit previous translations anytime.
- 🧭 **Smooth and Simple User Flow**:
  I adopted a **progressive disclosure** approach, guiding users step-by-step through a clear and intuitive process:
  - The starting point: clearly highlighted with a large input prompt
  - The **Translate** button is disabled until the user inputs text
  - A **friendly loading animation** plays when translating, and the button shows “Translating…”
  - The translated result appears in **literature-friendly serif typography**

## 🛠️ Setup Instructions

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

3. Create a `.env` file based on `.env.example`:

    ```bash
    cp .env.example .env
    ```

5. Open `.env` and add your OpenAI API key:

    ```ini
    OPENAI_API_KEY=your-openai-api-key
    ```

   🔑 You can get your API key from the official OpenAI website: https://platform.openai.com/account/api-keys

7. Start the backend server:

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

    ```ini
    OPENAI_API_KEY=your-openai-api-key
    BASE_URL=http://localhost:4000
    ```

    ※ BASE_URL is the address where your backend API is running.

5. Start the frontend development server:

    ```bash
    npm run dev
    ```

6. Open the app in your browser:

    ```
    http://localhost:3000
    ```

**🔐 Environment & Security Notes**
- .env files are listed in .gitignore, so they will not be pushed to GitHub.
- Never share your real API keys publicly.

### 🧪 Running Tests (Backend only)

To run backend tests:

```bash
mix test
```
Tests cover the following (via ExUnit):

- POST /translate
- GET /history
- Handling of invalid requests


## 📁 Project Structure

### Backend - translate_api/
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
└── mix.exs                         # Project definition and dependencies

### Frontend - translate-app/
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


## Clone this repository

```bash
git clone https://github.com/canacoconut-hyper-engineer/Kanako-translate
cd your-repo-name

