const { Octokit } = require("@octokit/action");
const fs = require("fs");

const octokit = new Octokit();
const [owner, repo] = process.env.GITHUB_REPOSITORY.split("/");

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
  const width = 600; // Total width of the SVG
  const height = 20;
  
  let currentX = 0;
  let svgParts = [];
  let legend = "\n\n| Language | % | Bytes |\n| :--- | :--- | :--- |\n";

  for (const [lang, bytes] of Object.entries(languages)) {
    const percent = (bytes / totalBytes);
    const partWidth = width * percent;
    const color = colors[lang] || "#cccccc";
    
    // Add colored rectangle to SVG
    svgParts.push(`<rect x="${currentX}" y="0" width="${partWidth}" height="${height}" fill="${color}" />`);
    
    currentX += partWidth;
    legend += `| <span style="color:${color}">●</span> **${lang}** | ${(percent * 100).toFixed(2)}% | ${bytes} B |\n`;
  }

  // Wrap in SVG tags
  const svg = `<svg width="${width}" height="${height}" viewBox="0 0 ${width} ${height}" xmlns="http://www.w3.org/2000/svg" style="border-radius: 4px;">
    ${svgParts.join('')}
  </svg>`;

  fs.writeFileSync("bar.svg", svg);

  // Update README.md
  let readme = fs.readFileSync("README.md", "utf8");
  const startMarker = "";
  const endMarker = "";
  const regex = new RegExp(`${startMarker}[\\s\\S]*${endMarker}`);
  
  const finalContent = `${startMarker}\n![Language Bar](bar.svg)\n${legend}\n${endMarker}`;
  readme = readme.replace(regex, finalContent);
  fs.writeFileSync("README.md", readme);
}

run();