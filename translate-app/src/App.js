import React, { useState, useEffect } from "react";
import "./styles.css";
import History from "./components/History";

export default function App() {
  const [text, setText] = useState("");
  const [targetLanguage, setTargetLanguage] = useState("Japanese");
  const [result, setResult] = useState("");
  const [loading, setLoading] = useState(false);
  const [isTranslated, setIsTranslated] = useState(false);
  const [historyData, setHistoryData] = useState([]);
  const fetchHistory = async () => {
    try {
      const res = await fetch("http://localhost:4000/history");
      const data = await res.json();
      setHistoryData(data.history || []);
    } catch (error) {
      console.error("Failed to fetch history:", error);
    }
  };

  useEffect(() => {
    fetchHistory();
  }, []);


  const handleTranslate = async () => {
    setLoading(true);
    setIsTranslated(false);
    try {
      const res = await fetch("http://localhost:4000/translate", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          text: text,
          language: targetLanguage,
        }),
      });

      const data = await res.json();
        setResult(data.translated_text || "Error");
        setIsTranslated(true);
      } catch (error) {
        setResult("Translation failed.");
        console.error("Error:", error);
      } finally {
        setLoading(false);
        fetchHistory();
      }
  };

  return (
    <div className="App" style={{ padding: "2rem", maxWidth: "600px", margin: "0 auto", width: "100%"}}>
      {/* <h1>Text Translator</h1> */}

      {/* Textarea */}
      <textarea
        className="custom-textarea"
        rows="4"
        value={text}
        onChange={(e) => setText(e.target.value)}
        placeholder="Type any language to translate."
      />
      <br />

      {/* Language */}
      <select
        className="custom-language"
        value={targetLanguage}
        onChange={(e) => setTargetLanguage(e.target.value)}
      >
        <option value="Japanese">🇯🇵 Japanese</option>
        <option value="English">🇺🇸 English</option>
        <option value="French">🇫🇷 French</option>
        <option value="German">🇩🇪 German</option>
        <option value="Spanish">🇪🇸 Spanish</option>
      </select>
      <br />

      {/* Translate Button */}
      <button
        className="custom-button"
        onClick={handleTranslate}
        disabled={!text || loading}
      >
        {loading
          ? "💭 Translating..."
          : isTranslated
          ? "Translated ✅"
          : "Translate"}
      </button>

      {/* Translate Result */}
      <div className="custom-result">
        {loading ? (
          <img
            src="/Book.gif"
            alt="Translating..."
            className="loading-gif"
          />
        ) : (
        <p
          className={result ? "translated-text" : "placeholder-text"}
          style={{ whiteSpace: "pre-wrap" }}
        >
          {result ? result : "Your translation will appear here."}
        </p>
        )}
      </div>

      {/* History */}
      <div className="custom-history">
        <History history={historyData} />
      </div>

    </div>
  );
}