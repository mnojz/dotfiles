hl.config { plugin = { dynamic_cursors = {

    enabled = true,

    mode = "tilt",
    -- mode = "rotate",
    -- mode = "stretch",

    threshold = 2,


    rotate = {
        length = 24,
        offset = 0.0,
    },


    tilt = {
        limit = 3000,

        -- activation = "linear",
        -- activation = "quadratic",
        activation = "negative_quadratic",

        window = 100,
        full = 90,
    },


    stretch = {
        limit = 1000,

        -- activation = "linear",
        -- activation = "quadratic",
        activation = "negative_quadratic",
        window = 100,
    },

    shake = {
        enabled = true,
        threshold = 5.0,
        base = 4.0,
        speed = 4.0,
        influence = 0.0,
        limit = 0.0,
        timeout = 2000,
        effects = true,
        ipc = false,
    },

    hyprcursor = {
        nearest = 1,
        enabled = true,
        resolution = -1,
        fallback = "clientside",
    },
} } }
