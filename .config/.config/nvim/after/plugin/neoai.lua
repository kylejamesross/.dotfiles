local status_ok, neoai = pcall(require, "neoai")
if not status_ok then
    return
end

neoai.setup({
    -- Below are the default options, feel free to override what you would like changed
    ui = {
        output_popup_text = "ChatGPT",
        input_popup_text = "Message",
        width = 50,               -- As percentage eg. 30%
        output_popup_height = 80, -- As percentage eg. 80%
    },
    models = {
        {
            name = "openai",
            model = "gpt-3.5-turbo"
        },
    },
    register_output = {
        ["g"] = function(output)
            return output
        end,
        ["c"] = require("neoai.utils").extract_code_snippets,
    },
    inject = {
        cutoff_width = 75,
    },
    prompts = {
        context_prompt = function(context)
            return "Hey, I'd like to provide some context for future "
                .. "messages. Here is the code/text that I want to refer "
                .. "to in our upcoming conversations:\n\n"
                .. context
        end,
    },
    open_api_key_env = "OPENAI_API_KEY",
    shortcuts = {
        {
            key = "<leader>as",
            use_context = true,
            prompt = [[
                Please rewrite the text to make it more readable, clear,
                concise, and fix any grammatical, punctuation, or spelling
                errors
            ]],
            modes = { "v" },
            strip_function = nil,
            desc = "Rewrite text"
        },
        {
            key = "<leader>ag",
            use_context = false,
            prompt = function()
                return [[
                    Using the following git diff generate a consise and
                    clear git commit message, with a short title summary
                    that is 75 characters or less:
                ]] .. vim.fn.system("git diff --minimal --cached | head -c 4100")
            end,
            modes = { "n" },
            strip_function = nil,
            desc = "Commit message"
        },
        {
            key = "<leader>an",
            use_context = false,
            prompt = function()
                return [[]] ..
                    [[ Write me a commit message. From these code changes: ]] ..
                    vim.fn.system("git diff --minimal --cached | head -c 4100") ..
                    [[ <END OF CODE CHANGES> ]] ..
                    [[ In the short summary prefix it with AB#<number> based off the number in this branch name here: ]] ..
                    vim.fn.system("git rev-parse --abbrev-ref HEAD") ..
                    [[ Write a commit message in this format, do not show diffs of code:
                        Short summary (50 chars or less) of code changes

                        Detailed explanatation of the code changes (300 chars or less), wrap at 72 chars, Put in bullet point format
                    ]]
            end,
            modes = { "n" },
            strip_function = nil,
            desc = "Commit message (NUDE)"
        },
    },
})
