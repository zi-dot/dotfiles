#!/usr/bin/env node

const path = require("path");
const { execSync } = require("child_process");

/**
 * @param {string} cwd
 * @returns {string}
 */
const getGitBranch = (cwd) => {
  try {
    const branch = execSync("git branch --show-current 2>/dev/null", {
      cwd,
      encoding: "utf-8",
    }).trim();
    return branch || "";
  } catch {
    return "";
  }
};

/**
 * @param {number} tokens
 * @returns {string}
 */
const formatTokenCount = (tokens) =>
  tokens >= 1000000
    ? `${(tokens / 1000000).toFixed(1)}M`
    : tokens >= 1000
      ? `${(tokens / 1000).toFixed(1)}K`
      : tokens.toString();

/**
 * @param {string} input
 * @returns {string}
 */
const buildStatusLine = (input) => {
  const data = JSON.parse(input);
  const model = data.model?.display_name || "Unknown";
  const cwd = data.workspace?.current_dir || data.cwd || ".";
  const currentDir = path.basename(cwd);
  const gitBranch = getGitBranch(cwd);

  const contextWindow = data.context_window || {};
  const contextSize = contextWindow.context_window_size;
  const currentUsage = contextWindow.current_usage;
  const autoCompactLimit = contextSize * 0.8;

  const currentTokens =
    (currentUsage.input_tokens || 0) +
    (currentUsage.cache_creation_input_tokens || 0) +
    (currentUsage.cache_read_input_tokens || 0);

  const percentage = Math.min(
    100,
    Math.round((currentTokens / autoCompactLimit) * 100),
  );
  const tokenDisplay = formatTokenCount(currentTokens);

  const percentageColor =
    percentage >= 90
      ? "\x1b[31m" // Red
      : percentage >= 70
        ? "\x1b[33m" // Yellow
        : "\x1b[32m"; // Green

  const branchDisplay = gitBranch ? ` | 🌿 ${gitBranch}` : "";
  return `[${model}] 📁 ${currentDir}${branchDisplay} | 🪙 ${tokenDisplay} | ${percentageColor}${percentage}%\x1b[0m`;
};

const chunks = [];
process.stdin.on("data", (chunk) => chunks.push(chunk));
process.stdin.on("end", () => console.log(buildStatusLine(chunks.join(""))));
