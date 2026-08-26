hl.on("hyprland.start", function()
    exec_once("spotify_player --daemon")
    exec_once("hyprpm enable hyprglass")
end)