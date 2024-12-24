import pocketbase from "pocketbase"

export const pb = new pocketbase("http://localhost:8090")
await pb.admins.authWithPassword("gillgurpal699@gmail.com", "Gurpal@123")
