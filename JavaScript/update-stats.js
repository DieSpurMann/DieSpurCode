const { Octokit } = require("@octokit/action");
const fs = require("fs");

const octokit = new Octokit();
const [owner, repo] = process.env.GITHUB_REPOSITORY.split("/");

async function run() {
  const { data: languages } = await octokit.request("GET /repos/{owner}/{repo}/languages", {
    owner,
    repo,
  });

  const totalBytes = Object.values(languages).reduce((a, b) => a + b, 0);
  const barWidth = 30; // Number of blocks in the bar
  
  let barChart = "### 📊 Project Progress Bar\n\n";
  let barLine = "";
  let legend = "\n\n";

  for (const [lang, bytes] of Object.entries(languages)) {
    const percent = (bytes / totalBytes) * 100;
    const blocks = Math.max(1, Math.round((percent / 100) * barWidth));
    
    // Build the visual bar (using different symbols for variety if desired)
    barLine += "█".repeat(blocks);
    
    // Build the legend with the exact percentage
    legend += `- **${lang}**: ${percent.toFixed(2)}% (${bytes} bytes)\n`;
  }

  // Wrap the bar in a code block or just bold it
  const finalOutput = `\`${barLine}\`${legend}`;

  let readme = fs.readFileSync("README.md", "utf8");
  const startMarker = "";
  const endMarker = "";
  const regex = new RegExp(`${startMarker}[\\s\\S]*${endMarker}`);
  
  readme = readme.replace(regex, `${startMarker}\n${finalOutput}\n${endMarker}`);
  fs.writeFileSync("README.md", readme);
}

run();