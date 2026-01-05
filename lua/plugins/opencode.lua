-- =========================================
-- lazy.nvim 配置：Opencode.nvim 全栈 + 排除依赖/构建目录
-- 官方推荐方式（无需 setup()）
-- =========================================
local uv = vim.loop
local json_decode = vim.fn.json_decode

-- 1️⃣ 读取 .cursorrules（系统提示词）
local function load_cursorrules()
  local path = vim.fn.getcwd() .. "/.cursorrules"
  if uv.fs_stat(path) then
    local f = io.open(path, "r")
    if f then
      local content = f:read("*a")
      f:close()
      return content
    end
  end
  -- 默认全栈系统提示词
  return [[
你是全栈资深工程师，精通 Vue/JS、React/JSX/TSX、Java、Go、Node.js、Rust、Lua 及各类数据库。
遵循最佳实践，代码风格统一，空值显示 '--'。
生成、审查、重构、测试、解释、优化、文档、架构、数据库设计等任务都必须遵循项目规范。
通用模块/组件不得耦合特定业务逻辑/API/路由，逻辑应可复用。
]]
end
local system_prompt = load_cursorrules()

-- 2️⃣ 读取 opencode.json（项目可选配置）
local function load_project_json()
  local path = vim.fn.getcwd() .. "/opencode.json"
  if uv.fs_stat(path) then
    local f = io.open(path, "r")
    if f then
      local data = f:read("*a")
      f:close()
      return json_decode(data)
    end
  end
  return nil
end
local project_config = load_project_json()

-- 3️⃣ 递归读取 RAG 上下文（排除依赖和构建目录）
local function read_context_files(paths)
  local texts = {}
  local exts = "%.(ts|tsx|vue|js|jsx|java|go|rs|lua|json|sql|db)$"
  local ignore_dirs = { "node_modules", "vendor", "target", ".git", ".idea", ".venv", "__pycache__", "dist", "build", "out" }

  local function is_ignored(path)
    for _, d in ipairs(ignore_dirs) do
      if path:find("/" .. d .. "/") then
        return true
      end
    end
    return false
  end

  local function scan_dir(dir)
    local handle = uv.fs_scandir(dir)
    if not handle then return end
    while true do
      local name, typ = uv.fs_scandir_next(handle)
      if not name then break end
      local path = dir .. "/" .. name
      if not is_ignored(path) then
        if typ == "file" and path:match(exts) then
          local f = io.open(path, "r")
          if f then
            table.insert(texts, f:read("*a"))
            f:close()
          end
        elseif typ == "directory" then
          scan_dir(path) -- 递归
        end
      end
    end
  end

  for _, p in ipairs(paths or {}) do
    local full_path = vim.fn.getcwd() .. "/" .. p
    if uv.fs_stat(full_path) then
      scan_dir(full_path)
    end
  end

  return table.concat(texts, "\n")
end
local rag_context = read_context_files(project_config and project_config.contextFiles)

-- 4️⃣ 默认 prompts（全栈 + 数据）
local default_prompts = {
  default      = "请根据当前项目生成代码。",
  code_review  = "请审查以下代码，指出潜在问题和优化建议。",
  refactor     = "请对以下代码进行重构，使其更简洁、高效，并遵循项目规范。",
  test_cases   = "请为以下组件/函数生成完整单元测试示例。",
  explain      = "请用通俗易懂的语言解释以下代码逻辑。",
  docstring    = "请为代码生成严格的 docstring 注释。",
  optimize     = "请优化性能和可读性，并保持项目风格一致。",
  translate    = "请将代码从一种语言转换为另一种语言，保持逻辑一致。",
  security     = "请检查代码安全漏洞并提供修复方案。",
  architecture = "请分析系统架构，提出优化、扩展和性能改进方案。",
  database     = "请分析数据库设计，提出优化建议和规范化方案。",
}
local prompts = (project_config and project_config.prompts) or default_prompts

-- 5️⃣ 返回 lazy.nvim 配置
return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = function()
      -- 官方推荐全局配置
      vim.g.opencode_opts = {
        systemPrompt = system_prompt,
        context      = rag_context,
        prompts      = prompts,
        modelConfig  = {
          provider    = "gemini3 Pro",
          apiUrl      = "https://api.gemini3pro.com/v1/chat",
          apiKey      = "YOUR_API_KEY_HERE",
          model       = "gemini-3pro",
          temperature = 0.7,
          maxTokens   = 2048,
        },
      }

      -- 快捷键：打开对话框
      vim.keymap.set("n", "<leader>oa", function()
        require("opencode").toggle()
      end, { desc = "OpenCode: Toggle dialog" })

      -- 快捷键：使用当前 buffer 提问
      vim.keymap.set("n", "<leader>oq", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "OpenCode: Ask current buffer" })

      -- 快捷键：选择操作
      vim.keymap.set("n", "<leader>os", function()
        require("opencode").select()
      end, { desc = "OpenCode: Select action" })
    end,
  },
}
