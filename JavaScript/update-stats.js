const { Octokit } = require("@octokit/action");
const fs = require("fs");

const octokit = new Octokit();
const [owner, repo] = process.env.GITHUB_REPOSITORY.split("/");

// Standard colors for your specific languages
const colors = {
  "PLpgSQL": "#336791", "Jupyter Notebook": "#DA5B0B", "Python": "#3572A5",
  "Ruby": "#701516", "TypeScript": "#3178c6", "HTML": "#e34c26",
  "Lua": "#000080", "Haskell": "#5e5086", "Rust": "#dea584",
  "Java": "#b07219", "C": "#555555", "JavaScript": "#f1e05a"
};

async function run() {
  const { data: languages } = await octokit.request("GET /repos/{owner}/{repo}/languages", {
    owner, repo
  });

  const totalBytes = Object.values(languages).reduce((a, b) => a + b, 0);
  
  // 1. Build the HTML Bar
  let barHtml = '<div style="display: flex; width: 100%; height: 20px; border-radius: 5px; overflow: hidden; background-color: #ddd;">\n';
  let legend = "\n\n";

  for (const [lang, bytes] of Object.entries(languages)) {
    const percent = ((bytes / totalBytes) * 100).toFixed(2);
    const color = colors[lang] || "#cccccc";
    
    // Add segment to the bar
    barHtml += `  <div style="width: ${percent}%; background-color: ${color};" title="${lang}: ${percent}%"></div>\n`;
    
    // Add colored dot and text to the legend
    legend += `<span><kbd>●</kbd> <b>${lang}</b> ${percent}%</span> &nbsp; `;
  }
  barHtml += '</div>';

  // 2. Update README.md
  let readme = fs.readFileSync("README.md", "utf8");
  const startMarker = "";
  const endMarker = "";
  const regex = new RegExp(`${startMarker}[\\s\\S]*${endMarker}`);
  
  // Note: GitHub sanitizes some HTML, so we use a table-based fallback for maximum compatibility
  const finalContent = `${startMarker}\n\n${barHtml}\n${legend}\n\n${endMarker}`;
  
  readme = readme.replace(regex, finalContent);
  fs.writeFileSync("README.md", readme);
}

run();