if hl.plugin.hyprglass then
    local hg = hl.plugin.hyprglass

    hg.config({
        enabled = true,
        default_theme = "dark",
        default_preset = "glass",
        layers = { enabled = true },
    })

    local function tint(c, alpha)
    return tonumber(c:match("%x%x%x%x%x%x"), 16) * 256
        + math.floor(alpha * 255 + 0.5)
    end

    -- Layer surfaces: each call whitelists the namespace and configures it
    hg.layer("waybar", { preset = "glass", mask_threshold = 0.3 })
    hg.layer("mako", { preset = "glass", mask_threshold = 0.03 })
    hg.layer("fuzzel", { preset = "glass", mask_threshold = 0.03 })
    hg.layer("quickshell:bezel", { preset = "glass", mask_threshold = 0.3 })
    hg.layer("gtk-layer-shell", { preset = "glass", mask_threshold = 0.3 })

    hg.layer("debug-panel", { exclude = true })

    -- Presets
    hg.preset("glass", {
        blur_strength = 2.0,
        blur_iterations = 3,
        chromatic_aberration = 0.8,
        fresnel_strength = 0.8,
        edge_thickness = 0.08,
        lens_distortion = 0.9,
        brightness = 1.0,
        contrast = 1.7,
        saturation = 1,
        vibrancy = 0.8,
        vibrancy_darkness = 1,
        adaptive_boost = 0.5
    })

    hg.preset("apple", {
        glass_opacity= 0.66,
        blur_strength = 2.2,
        blur_iterations = 3,
        refraction_strength = 0.55,
        chromatic_aberration = 0.3,
        fresnel_strength = 0.5,
        specular_strength = 0.75,
        edge_thickness = 0.05,
        lens_distortion = 0.3,
        dark = { brightness = 0.82, contrast = 0.90, saturation = 0.80, vibrancy = 0.15, adaptive_dim = 0.4 },
        light = { brightness = 1.12, contrast = 0.92 , saturation = 0.85, vibrancy = 0.12, adaptive_boost = 0.4 },
    })
end