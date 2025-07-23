import React from "react";

function History({ history }) {
  if (!history || history.length === 0) {
    return <p>There is no history yet.</p>;
  }

  return (
    <div className="custom-history">
      <h2>History</h2>
      <ul>
        {history.map((item, index) => 
        (
          <li key={index}>
            <div className="custom-history-header">
                <div className="custom-history-language">
                    {item.source_language} → {item.language} 
                </div> 
                <div className="custom-history-time">
                    {new Date(item.timestamp).toLocaleString("en-GB", {
                        day: "2-digit",
                        month: "numeric",
                        year: "numeric",
                        hour: "numeric",
                        minute: "2-digit",
                        hour12: true,
                    })}
                </div> 
            </div><br />
            <div className="custom-history-text">{item.text} </div> <br />
            <div className="custom-history-result"> {item.result} </div> <br />
          </li>
        ))}
      </ul>
    </div>
  );
}

export default History;