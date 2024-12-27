/// <reference path="../pb_data/types.d.ts" />

routerAdd("POST", "/webhook", (c) => {
    return c.json(200, { message: "OK" })
})