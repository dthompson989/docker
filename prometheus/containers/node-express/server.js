const express = require("express");
const os = require("os");

const app=express();

app.get("/", (req, res) => {
    res.send("Hello from Swarm " + os.hostname());
});

app.listen(8080, () => {
    console.log("Server is running on port 8080");
});