const { Octokit } = require("@octokit/action");
const fs = require("fs");

const octokit = new Octokit();
const [owner, repo] = process.env.GITHUB_REPOSITORY.split("/");

async function run() {
  // 1. Get language bytes from GitHub API
  const { data: languages } = await octokit.request("GET /repos/{owner}/{repo}/languages", {
    owner,
    repo,
  });

  // 2. Build the Mermaid chart text
  let mermaidText = '```mermaid\npie title Repository Languages\n';
  for (const [lang, bytes] of Object.entries(languages)) {
    mermaidText += `    "${lang}" : ${bytes}\n`;
  }
  mermaidText += '```';

  // 3. Update README.md
  let readme = fs.readFileSync("README.md", "utf8");
  
  // Use markers in your README to know where to paste the chart
  const startMarker = "";
  const endMarker = "";
  const regex = new RegExp(`${startMarker}[\\s\\S]*${endMarker}`);
  
  const newContent = `${startMarker}\n${mermaidText}\n${endMarker}`;
  readme = readme.replace(regex, newContent);

  fs.writeFileSync("README.md", readme);
}

run();