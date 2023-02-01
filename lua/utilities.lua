function USER.loading_error_msg(plugin_name)
    vim.notify(plugin_name, "ERROR", { title = "Loading failed" })
end
