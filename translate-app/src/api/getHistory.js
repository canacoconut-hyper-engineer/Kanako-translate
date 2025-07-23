// src/api/getHistory.js
export async function getHistory() {
    const res = await fetch("http://localhost:4000/history");
    if (!res.ok) {
      throw new Error("Failed to fetch history");
    }
    const data = await res.json();
    return data.history;
  }