
if vim.g.vscode then
    return {}
end

return {
    "eraserhd/parinfer-rust",
    build = "cargo build --release",
    ft = "clojure"
}
