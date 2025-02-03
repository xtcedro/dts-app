#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting environment setup...${NC}"

# Update package list and install dependencies
echo -e "${GREEN}Updating system packages...${NC}"
sudo apt update && sudo apt upgrade -y

# Install Node.js and npm (if not installed)
if ! command -v node &> /dev/null
then
    echo -e "${GREEN}Installing Node.js and npm...${NC}"
    sudo apt install -y nodejs npm
else
    echo -e "${GREEN}Node.js is already installed.${NC}"
fi

# Create project directories
echo -e "${GREEN}Setting up project structure...${NC}"
mkdir -p backend frontend

# Set up Backend
echo -e "${GREEN}Initializing backend environment...${NC}"
cd backend
npm init -y
npm install express cors dotenv
cat <<EOL > server.js
require("dotenv").config();
const express = require("express");
const cors = require("cors");
const app = express();
app.use(cors());
app.use(express.json());
app.get("/", (req, res) => res.json({ message: "Dominguez Tech API running..." }));
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(\`Server running on port \${PORT}\`));
EOL

# Create .env file
cat <<EOL > .env
PORT=5000
EOL

cd ..

# Set up Frontend
echo -e "${GREEN}Initializing frontend environment...${NC}"
cd frontend
npx create-react-app .
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

# Configure Tailwind
cat <<EOL > tailwind.config.js
module.exports = {
  content: ["./src/**/*.{js,jsx,ts,tsx}"],
  theme: {
    extend: {
      colors: {
        primary: "#0A1931",
        gold: "#FFD700",
        white: "#FFFFFF",
      },
    },
  },
  plugins: [],
};
EOL

cd ..

# Finish setup
echo -e "${GREEN}Setup complete!${NC}"
echo -e "${GREEN}To start the backend, run: cd backend && node server.js${NC}"
echo -e "${GREEN}To start the frontend, run: cd frontend && npm start${NC}"