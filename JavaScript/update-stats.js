const { Octokit } = require("@octokit/action");
const fs = require("fs");

const octokit = new Octokit();
const [owner, repo] = process.env.GITHUB_REPOSITORY.split("/");

// Defined colors to ensure your languages look professional
const colors = {
  "PLpgSQL": "#336791", "Jupyter Notebook": "#DA5B0B", "Python": "#3572A5",
  "Ruby": "#701516", "TypeScript": "#3178c6", "HTML": "#e34c26",
  "Lua": "#000080", "Haskell": "#5e5086", "Rust": "#dea584",
  "Java": "#b07219", "C": "#555555", "JavaScript": "#f1e05a"
};

async function run() {
  // 1. Fetch language data from GitHub API
  const { data: languages } = await octokit.request("GET /repos/{owner}/{repo}/languages", {
    owner, repo
  });

  const totalBytes = Object.values(languages).reduce((a, b) => a + b, 0);
  const width = 800; // SVG Width
  const height = 20; // SVG Height
  
  let currentX = 0;
  let svgParts = [];
  let legend = "\n\n";

  // 2. Build SVG segments and Legend
  for (const [lang, bytes] of Object.entries(languages)) {
    const percent = (bytes / totalBytes);
    const rawWidth = width * percent;
    const partWidth = Math.max(rawWidth, 2); // Minimum 2px so tiny langs are visible
    
    const color = colors[lang] || "#cccccc";
    const percentText = (percent * 100).toFixed(2);
    
    // SVG Rectangle with hover <title>
    svgParts.push(`
      <rect x="${currentX}" y="0" width="${partWidth}" height="${height}" fill="${color}" stroke="#ffffff" stroke-width="0.5">
        <title>${lang}: ${percentText}% (${bytes} bytes)</title>
      </rect>`);
    
    currentX += partWidth;

    // Generate badge for the legend
    const badgeLang = encodeURIComponent(lang);
    const badgeColor = color.replace('#', '');
    legend += `<img src="https://img.shields.io/badge/${badgeLang}-${badgeColor}?style=flat-square&logo=${badgeLang.toLowerCase()}&logoColor=white" /> `;
  }

  // 3. Assemble the SVG with rounded corners and a "glass" shine
  const svg = `<svg width="${width}" height="${height}" viewBox="0 0 ${width} ${height}" xmlns="http://www.w3.org/2000/svg">
    <defs>
      <linearGradient id="shine" x1="0" y1="0" x2="0" y2="1">
        <stop offset="0%" stop-color="white" stop-opacity="0.25" />
        <stop offset="50%" stop-color="white" stop-opacity="0" />
        <stop offset="100%" stop-color="black" stop-opacity="0.1" />
      </linearGradient>
    </defs>
    <clipPath id="round">
      <rect width="${width}" height="${height}" rx="10" ry="10" />
    </clipPath>
    <g clip-path="url(#round)">
      ${svgParts.join('')}
      <rect width="${width}" height="${height}" fill="url(#shine)" pointer-events="none" />
    </g>
  </svg>`;

  // 4. Write the files
  fs.writeFileSync("bar.svg", svg);

  let readme = fs.readFileSync("README.md", "utf8");
  const startMarker = "";
  const endMarker = "";
  const regex = new RegExp(`${startMarker}[\\s\\S]*${endMarker}`);
  
  const finalContent = `${startMarker}\n\n${svg}\n\n${legend}\n\n${endMarker}`;
  readme = readme.replace(regex, finalContent);
  fs.writeFileSync("README.md", readme);
}

run().catch(err => {
  console.error(err);
  process.exit(1);
});