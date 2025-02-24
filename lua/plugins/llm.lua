return {
  'huggingface/llm.nvim',
  config = function()
    require('llm').setup({
      model = "deepseek-ai/DeepSeek-R1",
      backend = "huggingface",
    })
  end,
}
