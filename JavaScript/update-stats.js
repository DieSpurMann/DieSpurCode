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
  const width = 800; 
  const height = 20;
  
  let currentX = 0;
  let svgParts = [];
  
  // Initialize the table header
  let legend = "\n\n| Language | Percentage | Size |\n| :--- | :--- | :--- |\n";

  for (const [lang, bytes] of Object.entries(languages)) {
    const percent = (bytes / totalBytes);
    // 1. Calculate Widths
    const rawWidth = width * percent;
    const partWidth = Math.max(rawWidth, 2); // Minimum 2px visibility rule
    
    const color = colors[lang] || "#cccccc";
    const percentText = (percent * 100).toFixed(2);
    
    // 2. Build SVG Rect (The visual bar)
    svgParts.push(`
      <rect x="${currentX}" y="0" width="${partWidth}" height="${height}" fill="${color}" stroke="#ffffff" stroke-width="0.5">
        <title>${lang}: ${percentText}% (${bytes.toLocaleString()} bytes)</title>
      </rect>`);
    
    currentX += partWidth;

    // 3. Build Table Row with Badge (The data list)
    // We encode the names to handle spaces safely in the URL
    const safeName = encodeURIComponent(lang);
    const safeColor = color.replace('#', '');
    
    // Create the badge image
    const badge = `<img src="https://img.shields.io/badge/${safeName}-${safeColor}?style=flat-square&logo=${encodeURIComponent(lang.toLowerCase())}&logoColor=white" />`;
    
    // Add row to table: | Badge | % | Bytes |
    legend += `| ${badge} | ${percentText}% | ${bytes.toLocaleString()} B |\n`;
  }

  // 4. Construct the SVG
  const svg = `<svg width="${width}" height="${height}" viewBox="0 0 ${width} ${height}" xmlns="http://www.w3.org/2000/svg">
    <defs>
      <linearGradient id="shine" x1="0" y1="0" x2="0" y2="1">
        <stop offset="0%" stop-color="white" stop-opacity="0.25" />
        <stop offset="50%" stop-color="white" stop-opacity="0" />
        <stop offset="100%" stop-color="black" stop-opacity="0.1" />
      </linearGradient>
    </defs>
    <clipPath id="round">
      <rect width="${width}" height="${height}" rx="6" ry="6" />
    </clipPath>
    <g clip-path="url(#round)">
      ${svgParts.join('')}
      <rect width="${width}" height="${height}" fill="url(#shine)" pointer-events="none" />
    </g>
  </svg>`;

  // 5. Save SVG file
  fs.writeFileSync("bar.svg", svg);

  // 6. Update README
  let readme = fs.readFileSync("README.md", "utf8");
  const startMarker = "";
  const endMarker = "";
  const regex = new RegExp(`${startMarker}[\\s\\S]*${endMarker}`);
  
  // Combine: Start Tag + Image Link + Table Legend + End Tag
  const finalContent = `${startMarker}\n\n![Language Bar](bar.svg)\n${legend}\n${endMarker}`;
  
  readme = readme.replace(regex, finalContent);
  fs.writeFileSync("README.md", readme);
}

run().catch(err => {
  console.error(err);
  process.exit(1);
});