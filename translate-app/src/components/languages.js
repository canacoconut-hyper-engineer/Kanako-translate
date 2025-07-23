/* eslint-disable */

import React, { useState } from "react";

const LANGUAGES = [
  { label: "Japanese", code: "ja" },
  { label: "Russian", code: "ru" },
  { label: "Spanish", code: "es" },
  { label: "French", code: "fr" },
  { label: "Arabic", code: "ar" },
  { label: "Chinese", code: "zh" },
  { label: "German", code: "de" },
  { label: "Hindi", code: "hi" },
  { label: "Portuguese", code: "pt" }
];

const Languages = ({ language, onLanguageChange }) => {
  if (language === undefined) {
    language = "ja";
  }

  const languageConfig = LANGUAGES.find(l => l.code === language);
  if (!languageConfig) {
    throw new Error(`Unknown language code '${language}'`);
  }

  const [open, setOpen] = useState(false);

  const onSelect = (selectedLanguageCode) => {
    setOpen(false);
    onLanguageChange(selectedLanguageCode);
  };

  return (
    <div>
      <label className="label">Select Language</label>
      <div className={`dropdown ${open && "is-active"}`}>
        <div className="dropdown-trigger">
          <button className="button" onClick={() => setOpen(!open)}>
            <span>{languageConfig.label}</span>
            <span className="icon is-small">
              <i className="fas fa-angle-down" />
            </span>
          </button>
        </div>
        <div className="dropdown-menu">
          <div className="dropdown-content">
          {LANGUAGES.map(({ label, code }) => (
            <li key={code}>
              <a
                href="#"
                onClick={() => onSelect(code)}
                className="dropdown-item"
              >
                {label}
              </a>
            </li>
          ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Languages;
