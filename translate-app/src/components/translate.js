import React, { useEffect, useState, useCallback } from "react";
import axios from "axios";
import debounce from "lodash.debounce";

const languageMap = {
  ja: "Japanese",
  ru: "Russian",
  es: "Spanish",
  fr: "French",
  ar: "Arabic",
  zh: "Chinese",
  de: "German",
  hi: "Hindi",
  pt: "Portuguese"
};

const doTranslate = async (input, languageCode, cancelToken) => {
  console.log("Translating:", input, "to", languageMap[languageCode]);

  try {
    const { data } = await axios.post(
      "https://api.openai.com/v1/chat/completions",
      {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "You are a helpful translator." },
          {
            role: "user",
            content: `Translate the following text into ${languageMap[languageCode]}:\n"${input}"`
          }
        ]
      },
      {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${process.env.REACT_APP_OPENAI_API_KEY}`
        },
        cancelToken: cancelToken.token
      }
    );

    return data.choices[0].message.content;
  } catch (error) {
    console.error("Translation error:", error);
    return "";
  }
};

export default ({ language, text }) => {
  const [translated, setTranslated] = useState("");

  const debouncedTranslate = useCallback(
    debounce((text, language, cancelToken) => {
      doTranslate(text, language, cancelToken).then(setTranslated);
    }, 1000), // <= 1000ms（1秒）入力が止まったら翻訳開始
    []
  );

  useEffect(() => {
    if (!text) return;

    const cancelToken = axios.CancelToken.source();
    debouncedTranslate(text, language, cancelToken);

    return () => cancelToken.cancel();
  }, [text, language, debouncedTranslate]);

  return (
    <div>
      <label className="label">Output</label>
      <h1 className="title">{translated}</h1>
    </div>
  );
};
