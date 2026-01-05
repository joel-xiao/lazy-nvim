local default_prompts = {
  default = "请基于当前项目上下文完成需求实现。\n\n通用要求：\n- 严格遵循项目现有规范与目录结构（见 .cursorrules/现有代码风格）\n- 不引入无关依赖；优先复用项目已有工具/组件/封装\n- 处理边界与空态：可空值、加载态、错误态、权限/无数据\n- 保证类型与可维护性：避免 any、减少隐式副作用、避免重复逻辑\n- 输出必须可直接粘贴使用：给出文件落点清单 + 最终代码（按文件分块）\n\n技术栈规范（按涉及语言选择遵循）：\n- TypeScript：strict 思维，类型可推导/可复用，避免过度断言\n- React：函数组件 + Hooks，副作用集中管理，避免不必要重渲染\n- Vue：Vue3 SFC（<script setup>）+ Composition API，拆分 composables/组件\n- Node.js：async/await，明确错误处理与返回结构，避免阻塞 I/O\n- Rust：所有权/借用清晰，Result/Option 完整处理，错误类型可追踪\n- Java：清晰分层（controller/service/repo），异常与校验明确，避免过度静态工具类\n- HTML：语义化结构与可访问性（ARIA/键盘导航）\n- CSS：结构清晰（按项目约定命名），避免全局污染，优先变量/复用\n",
  fix = "请修复以下问题，并保持行为一致（除 bug 修复外不要改动需求）。\n\n要求：\n- 先定位根因（给出最小解释）\n- 给出最小变更方案，避免大范围重构\n- 补齐边界/空态/错误处理与类型\n- 修复后提供自检清单（如何验证修复有效，包含关键用例）\n- 输出：文件落点清单 + 最终代码（按文件分块）\n",
  code_review = "请对以下内容进行代码审查：指出潜在 bug、边界/空态缺失、类型风险、性能问题与可维护性问题，并给出可执行的修改建议（必要时直接给出替换后的代码块）。",
  refactor = "请在保持行为一致的前提下重构以下内容：消除重复、显式化副作用、强化类型与边界处理，并按项目既有分层/目录规范拆分代码。输出：拆分后的文件清单 + 最终代码。",
  test_cases = "请为以下组件/函数补齐单元测试：覆盖正常/边界/异常。\n- 若项目已存在测试框架：沿用现有写法与目录\n- 若不存在：给出最小可落地方案与运行命令",
  explain = "请用通俗易懂的方式解释以下代码：核心流程、关键状态/数据结构、边界与空态策略，并指出潜在风险点（类型/并发/性能/安全）。",
  docstring = "请为以下代码生成严格的 docstring/类型说明（按项目习惯与格式）。",
  optimize = "请优化以下代码的性能与可读性，同时保持行为一致并遵循项目规范：减少不必要的计算/渲染/IO，提升类型与可维护性。",
  translate = "请将以下代码转换为目标语言/框架（Rust/Java/React/TS/Vue/Node.js/CSS/HTML），保持逻辑一致，并补齐关键类型定义与边界处理策略。",
  security = "请分析以下代码的安全风险（XSS/注入/越权/敏感信息泄露/依赖风险），并给出可在本项目落地的修复方案与代码。",
  architecture = "请分析当前模块/系统架构：目录结构与职责边界、依赖方向与复用策略、可扩展点与最小迁移步骤（尽量少改动）。",
  database = "请分析接口/数据库交互设计：字段映射、空值策略、错误码处理、缓存/分页策略，并给出更规范可维护的实现建议与代码。",
}

return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
      vim.g.opencode_opts = {
        prompts = default_prompts,
      }

      vim.o.autoread = true

      vim.keymap.set({ "n", "x" }, "<leader>oa", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "Ask opencode" })

      vim.keymap.set({ "n", "x" }, "<leader>ox", function()
        require("opencode").select()
      end, { desc = "Execute opencode action…" })

      vim.keymap.set({ "n", "t" }, "<leader>ot", function()
        require("opencode").toggle()
      end, { desc = "Toggle opencode" })
    end,
  },
}
